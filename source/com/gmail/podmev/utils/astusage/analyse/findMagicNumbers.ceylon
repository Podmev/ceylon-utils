import ceylon.ast.core {
    Node,
    Visitor,
    IntegerLiteral,
    FloatLiteral
}
import ceylon.collection {
    ArrayList
}

import com.gmail.podmev.utils.ast {
    parentSetterVisitor,
    getHeirarchy
}
//TODO: нужно написать обёрту над методом, котрая бы выкидывала присвоения магических чисел в переменные
"Нужно найти все магические числа, все отличные от 0(.0) и 1(.0)
 Не находит магические строки, поскольку не понятно, как их искать"
see(`value parentSetterVisitor`,
    `function getHeirarchy`)
shared [Node+][] findMagicNumbers(Node node) {
    ArrayList<Node> magicNumberNodes = ArrayList<Node>();
    object magicNumberVisitor satisfies Visitor{
        shared actual void visitIntegerLiteral(IntegerLiteral integerLiteral){
            String text = integerLiteral.text;
            if(text!="1", text!="0") {
                magicNumberNodes.add(integerLiteral);
            }
        }
        shared actual void visitFloatLiteral(FloatLiteral floatLiteral){
            String text = floatLiteral.text;
            if(text!="1.0", text!="0.0") {
                magicNumberNodes.add(floatLiteral);
            }
        }
    }
    node.visit(parentSetterVisitor);
    node.visit(magicNumberVisitor);
    return magicNumberNodes.collect(getHeirarchy);
}