import ceylon.ast.core {
    ValueExpression,
    StringLiteral,
    ClassDefinition,
    Statement,
    IntegerLiteral,
    Expression,
    Literal,
    Declaration,
    CharacterLiteral,
    FloatLiteral,
    ValueDefinition,
    AnySpecifier,
    Specification
}
"Достать для стригового поля с именем [[fieldName]] его значение из ast класса [[classDefinition]]"
shared String|Exception getStringFieldValue(String fieldName)(ClassDefinition classDefinition){
    for(declarationOrStatement in classDefinition.body.content){
        switch (declarationOrStatement)
        case (is Declaration) {
            Declaration declaration = declarationOrStatement;
            if(is ValueDefinition declaration, declaration.name.name == fieldName){
                return getStringLiteralExpresion(fieldName, declaration.definition);
            }
            //TODO Доделать, может, есть ещё случаи
        }
        case (is Statement) {
            Statement statement = declarationOrStatement;
            if(is Specification statement, statement.name.name == fieldName){
                return getStringLiteralExpresion(fieldName, statement.specifier);
            }
            continue;
        }
    }
    return Exception("no field");
}
"достать из [[anySpecifier]] литеральную стрингу, если считать, что это было значения поля с именем [[fieldName]]"
String|Exception getStringLiteralExpresion(String fieldName, AnySpecifier anySpecifier){
    Expression expression = anySpecifier.expression;
    if(!is ValueExpression expression){
        return Exception("Not a ValueExpression lazy spesifier with name ``fieldName``"); //TODO fix msg
    }
    //можно было бы проверять на Atom тоже
    if(!is Literal expression){
        return Exception("Not a Literal lazy spesifier with name ``fieldName``"); //TODO fix msg
    }
    switch (expression)
    case(is StringLiteral){
        return expression.text;
    }
    case(is IntegerLiteral){
        return Exception("Not a StringLiteral lazy spesifier with name ``fieldName``: It is IntegerLiteral: ``expression``"); //TODO fix msg
    }
    case(is FloatLiteral){
        return Exception("Not a StringLiteral lazy spesifier with name ``fieldName``: It is FloatLiteral: ``expression``"); //TODO fix msg
    }
    case(is CharacterLiteral){
        return Exception("Not a StringLiteral lazy spesifier with name ``fieldName``: It is CharacterLiteral: ``expression``"); //TODO fix msg
    }
}