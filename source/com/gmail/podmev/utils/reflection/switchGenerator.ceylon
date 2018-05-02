import ceylon.collection {
    ArrayList
}
import ceylon.language.meta.declaration {
    ClassOrInterfaceDeclaration,
    OpenClassOrInterfaceType,
    OpenTypeVariable,
    OpenUnion,
    OpenIntersection,
    nothingType
}
import ceylon.ast.core {
    Node
}
"Через рекурсию"
void switchGenerator(TreeNode<ClassOrInterfaceDeclaration> typeTree) {
    //if()
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

"рапечатка дерева"
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
}
