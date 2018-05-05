import ceylon.ast.core {
    Visitor,
    Node
}
"Визитор нод, который проставляет родителей нод ast в нетипизированное поле [[Node.data]]"
shared object parentSetterVisitor satisfies Visitor{
    shared actual void visitNode(Node node){
        super.visitNode(node);
        for(child in node.children){
            child.data = node; //записываем родителя в data
        }
    }
}