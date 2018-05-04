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
    print(getStringFieldValue("localCode")(classDeclaration));
}

String classDeclarationLit =
        """
           shared class MyError(Claim claim) satisfies Error{
            localCode => "1234";
            shared actual String localCode1 => "123";
           }
           """;

void examClass(ClassDefinition classDefinition) {
    SatisfiedTypes? satisfiedTypes = classDefinition.satisfiedTypes;
    if (!exists satisfiedTypes) {
        return;
    }
    [PrimaryType+] types = satisfiedTypes.satisfiedTypes;
    //types*.
}