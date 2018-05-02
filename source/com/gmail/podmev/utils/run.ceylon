import ceylon.ast.core {
    ...
}
import ceylon.ast.redhat {
    parseCompilationUnit
}
String classDeclarationLit =
        """
           shared class MyError(Claim claim) satisfies Error{
            localCode => "1234";
            shared actual String localCode1 => "123";
            value [a,b] = [1,2];
            value c => "s" + 2.string;
            String d => "s" + 2.string;

            shared void foo(){
                value a = 3;
                print(a);
            }
           }
           """;

"Run the module `com.gmail.podmev.utils`."
shared void run() {
    assert(exists CompilationUnit compilationUnit = parseCompilationUnit(classDeclarationLit));
    //print(compilationUnit);
    assert(exists Declaration classDeclaration = compilationUnit.declarations.first);
    //print(classDeclaration.name);
    assert(is ClassDefinition classDeclaration);
    print(classDeclaration);
    print(getStringFieldValue(classDeclaration, "localCode"));
}

//TODO можно сделать кодогенератор разбора кейсов

<Node[]>[] findValues(Node node, Node[] nodeHeirararchy = []){
    [Node+] childNodeHeirarchy => nodeHeirararchy.withTrailing(node);
    "найденные у детей значения value"
    Node[][] childrenValues => concatenate(*node.children.map((childNode)=>findValues(childNode, childNodeHeirarchy)));
    variable Node[][] thisLevelValue = [];
    switch (node)
    case (is Expression) {}
    case (is Statement) {}
    case (is Declaration) {
        switch(node)
        case(is TypeDeclaration){}
        case(is TypedDeclaration){
            switch (node)
            case(is AnyValue){
                switch (node)
                case(is ValueDeclaration){}
                case(is ValueDefinition){
                    if(is ValueModifier type = node.type){
                        thisLevelValue = [childNodeHeirarchy];
                    }
                }
                case(is ValueGetterDefinition){
                    if(is ValueModifier type = node.type){
                        thisLevelValue = [childNodeHeirarchy];
                    }
                }
            }
            case(is AnyFunction){}
        }
        case(is ObjectDefinition){}
        case(is ValueSetterDefinition){}
        case(is ConstructorDefinition){}
    }
    case (is Annotation) {}
    case (is Annotations) {}
    case (is Parameter) {}
    case (is TypeParameter) {}
    case (is TypeParameters) {}
    case (is CaseTypes) {}
    case (is SatisfiedTypes) {}
    case (is TypeConstraint) {}
    case (is PackageDescriptor) {}
    case (is ModuleImport) {}
    case (is ModuleBody) {}
    case (is ModuleDescriptor) {}
    case (is ImportAlias) {}
    case (is ImportWildcard) {}
    case (is ImportElement) {}
    case (is ImportElements) {}
    case (is Import) {}
    case (is AnyCompilationUnit) {}
    case (is Condition) {}
    case (is Conditions) {}
    case (is IfClause) {}
    case (is ElseClause) {}
    case (is ExtendedType) {}
    case (is ClassSpecifier) {}
    case (is TypeSpecifier) {}
    case (is Variable) {}
    case (is ForIterator) {}
    case (is ForClause) {}
    case (is FailClause) {}
    case (is ComprehensionClause) {}
    case (is FinallyClause) {}
    case (is CatchClause) {}
    case (is Resource) {}
    case (is Resources) {}
    case (is TryClause) {}
    case (is CaseItem) {}
    case (is CaseClause) {}
    case (is SwitchCases) {}
    case (is SwitchClause) {}
    case (is TypeIsh) {}
    case (is Identifier) {}
    case (is FullPackageName) {}
    case (is ArgumentList) {}
    case (is SpreadArgument) {}
    case (is Arguments) {}
    case (is NamedArgument) {
        switch (node)
        case(is AnonymousArgument){}
        case(is SpecifiedArgument){}
        case(is InlineDefinitionArgument){
            switch (node)
            case(is ValueArgument){
                if(is ValueModifier type = node.type){
                    thisLevelValue = [childNodeHeirarchy];
                }
            }
            case(is FunctionArgument){}
            case(is ObjectArgument){}
        }
    }
    case (is AnySpecifier) {}
    case (is Parameters) {}
    case (is Bound) {}
    case (is Modifier) {}
    case (is Body) {}
    case (is Comprehension) {}
    case (is Subscript) {}
    case (is DecQualifier) {}
    case (is AnyMemberOperator) {}
    case (is Pattern) {}
    case (is SpecifiedPattern) {}
    case (is PatternList) {}
    case (is CaseExpression) {}
    case (is ExtensionOrConstruction) {}
    case (is ModuleSpecifier) {}
    return concatenate(thisLevelValue, childrenValues);
}

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