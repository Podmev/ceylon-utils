import ceylon.ast.core {
    CompilationUnit,
    Declaration,
    ClassDefinition,
    SatisfiedTypes,
    PrimaryType,
    Statement,
    LazySpecification,
    LazySpecifier,
    Expression,
    ValueExpression,
    Literal,
    StringLiteral,
    IntegerLiteral,
    FloatLiteral,
    CharacterLiteral
}
import ceylon.ast.redhat {
    parseCompilationUnit
}
"Run the module `com.gmail.podmev.utils`."
shared void run() {
    assert(exists CompilationUnit compilationUnit = parseCompilationUnit(classDeclarationLit));
    //print(compilationUnit);
    assert(exists Declaration classDeclaration = compilationUnit.declarations.first);
    //print(classDeclaration.name);
    assert(is ClassDefinition classDeclaration);
    print(getStringFieldValue(classDeclaration, "localCode"));
}

String classDeclarationLit =
    """
       shared class MyError(Claim claim) satisfies Error{
        localCode => "1234";
        shared actual String localCode1 => "123";
       }
       """;

void examClass(ClassDefinition classDefinition){
    SatisfiedTypes? satisfiedTypes = classDefinition.satisfiedTypes;
    if(!exists satisfiedTypes) {return;}
    [PrimaryType+] types = satisfiedTypes.satisfiedTypes;
    //types*.
}

String|Exception getStringFieldValue(ClassDefinition classDefinition, String fieldName){
    for(declarationOrStatement in classDefinition.body.content){
        switch (declarationOrStatement)
        case (is Declaration) {
            Declaration declaration = declarationOrStatement;
           //print(declaration.name);
        }
        case (is Statement) {
            Statement statement = declarationOrStatement;
            if(is LazySpecification statement, statement.name.name == fieldName){
                //нашли поле
                LazySpecifier specifier = statement.specifier;
                Expression expression = specifier.expression;
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
            continue;
        }
    }
    return Exception("no field");
}