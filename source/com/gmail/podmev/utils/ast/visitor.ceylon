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
//TODO переименовать
//TODO можно сделать оптимизацию: хранить родителя или уже всю цепочку
"Получить иерархию ноды, если родителя неявно проставлены через [[Node.data]]"
shared [Node+] getHeirarchy(Node node){
    Anything data = node.data;
    if(!exists data){
        return [node];
    }
    assert (is Node parentNode = data);
    return getHeirarchy(parentNode).withTrailing(node);
}