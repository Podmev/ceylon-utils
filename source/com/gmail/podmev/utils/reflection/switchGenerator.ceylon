import ceylon.ast.core {
    SwitchCases,
    SwitchCaseElse,
    SwitchClause,
    BaseExpression,
    MemberNameWithTypeArguments,
    LIdentifier,
    Node,
    CaseClause,
    IsCase,
    BaseType,
    TypeNameWithTypeArguments,
    UIdentifier,
    Block
}
import ceylon.collection {
    ArrayList
}
import ceylon.language.meta.declaration {
    ClassOrInterfaceDeclaration,
    ClassDeclaration,
    OpenTypeVariable,
    OpenUnion,
    OpenIntersection,
    OpenClassOrInterfaceType,
    nothingType
}
import ceylon.language.meta {
    type
}

"Формирует ast дерево вложенных switch по всем типам на основе дерева наследований объекта [[obj]]"
SwitchCaseElse? switchGenerator(Object obj, String variableName){
    ClassDeclaration classDeclaration  = type(obj).declaration;
    TreeNode<ClassOrInterfaceDeclaration> typeTree = createTypeTree(classDeclaration);
    return switchGeneratorByTree(typeTree, variableName);
}

"Формирует ast дерево вложенных switch по всем типам на основе дерева наследований
 Через рекурсию"
SwitchCaseElse? switchGeneratorByTree(TreeNode<ClassOrInterfaceDeclaration> typeTree, String variableName) {
    TreeNode<ClassOrInterfaceDeclaration>[] children = typeTree.children;
    if(!nonempty children){
        return null;
    }
    SwitchCaseElse switchCaseElse = SwitchCaseElse{
        clause = SwitchClause(BaseExpression(MemberNameWithTypeArguments(LIdentifier(variableName))));
        cases = SwitchCases{
            caseClauses = [
                for(child in children)
                    CaseClause {
                        caseItem = IsCase(BaseType(TypeNameWithTypeArguments(UIdentifier(child.node.name)))); //возможно ошибка если есть синглетоны как enum
                        //блок пустой если у ребёнка нед подтипов. иначе вложенный switch
                        block = Block{
                            content =
                                (if(exists childSwitchCaseElse = switchGeneratorByTree(child, variableName))
                                then [childSwitchCaseElse]
                                else []);
                        };
                    }
            ];
        };
    };
    return switchCaseElse;
}

"Построения цепояки от прародителя [[superClass]] до наследника [[classDeclaration]] по extends type'ам
 может упасть"
ClassDeclaration[] findRelations(
        ClassDeclaration superClass,
        ClassDeclaration classDeclaration
        ){
    if(classDeclaration==superClass){
        return [superClass];
    }
    assert (exists extendedType = classDeclaration.extendedType);
    ClassDeclaration extendedClass = extendedType.declaration;
    return findRelations(superClass, extendedClass).withTrailing(classDeclaration);
}

"Создание дерева of для классов и интерфейсов"
TreeNode<ClassOrInterfaceDeclaration> createTypeTree(ClassOrInterfaceDeclaration classOrInterfaceDeclaration){
    MutableTreeNode<ClassOrInterfaceDeclaration> mutableTreeNode =
            MutableTreeNode<ClassOrInterfaceDeclaration>(classOrInterfaceDeclaration);
    rawTypeTree(mutableTreeNode);
    TreeNode<ClassOrInterfaceDeclaration> treeNode = toImmutableTree(mutableTreeNode);
    return treeNode;
}
"версия только для классов и нтерфейсов, не покрывающая все типы"
void rawTypeTree(MutableTreeNode<ClassOrInterfaceDeclaration> emptyNode) {
    ClassOrInterfaceDeclaration classOrInterfaceDeclaration = emptyNode.node;
    ClassOrInterfaceDeclaration[] openClassOrInterfaceTypes =
            classOrInterfaceDeclaration.caseTypes.collect((caseType){
                switch(caseType)
                case (nothingType) {
                    throw Exception("not implemented case type with nothingType");
                }
                case (is OpenTypeVariable|OpenUnion|OpenIntersection) {
                    throw Exception("not implemented case type with ``caseType``");
                }
                case (is OpenClassOrInterfaceType) {
                    return caseType;
                }
            })*.declaration;
    MutableTreeNode<ClassOrInterfaceDeclaration>[] children = openClassOrInterfaceTypes.collect(MutableTreeNode);
    //рекурсия
    children.each(rawTypeTree);
    emptyNode.childrenArray.addAll(children);
}

class MutableTreeNode<NodeType>(shared NodeType node){
    shared ArrayList<MutableTreeNode<NodeType>> childrenArray;
    childrenArray = ArrayList<MutableTreeNode<NodeType>>{};
}

class TreeNode<NodeType>(
        shared NodeType node,
        shared TreeNode<NodeType>[] children){
}
"трансформация в иммутабельное дерево через рекурсию"
TreeNode<NodeType> toImmutableTree<NodeType>(MutableTreeNode<NodeType> mutableTreeRoot){
    if(mutableTreeRoot.childrenArray.empty){
        return TreeNode(mutableTreeRoot.node, []);
    }
    return TreeNode(mutableTreeRoot.node, (mutableTreeRoot.childrenArray.collect(toImmutableTree)));
}

"распечатка дерева"
void printTreeNode<NodeType>(
        TreeNode<NodeType> treeNode,
        String nodeTypeString(NodeType nodeType),
        Integer depth = 0){
    print("\t".repeat(depth)+"-" +nodeTypeString(treeNode.node));
    for(child in treeNode.children){
        printTreeNode(child, nodeTypeString, depth + 1);
    }
}

shared void run(){
    TreeNode<ClassOrInterfaceDeclaration> typeTree = createTypeTree(`class Node`);
    printTreeNode {
        treeNode = typeTree;
        nodeTypeString = ClassOrInterfaceDeclaration.name;
    };
    print("->".join(findRelations(`class Node`, `class SwitchCases`)*.name));
    print(switchGeneratorByTree(typeTree, "node"));
}
