import ceylon.ast.core {
    FloatLiteral,
    Visitor,
    Node,
    LIdentifier
}
import ceylon.collection {
    ArrayList
}

import com.gmail.podmev.utils.ast {
    parentSetterVisitor,
    getHeirarchy
}
//TODO исключить однобуквенные переменные из циклов i, j, k
"Найти все переменные и функции и их использования состоящие из 1 буквы или буквы"
shared [Node+][] findShortVariables(Node node) {
    ArrayList<Node> shortVariableNodes = ArrayList<Node>();

    object shortVariables satisfies Visitor {
        shared actual void visitLIdentifier(LIdentifier lIdentifier) {
            String name = lIdentifier.name;
            if (name.size==1|| name == "val") {
                shortVariableNodes.add(lIdentifier);
            }
        }
    }

    node.visit(parentSetterVisitor);
    node.visit(shortVariables);
    return shortVariableNodes.collect(getHeirarchy);
}