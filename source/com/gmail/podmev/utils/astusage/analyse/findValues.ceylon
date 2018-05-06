import ceylon.ast.core {
    SpecifiedPattern,
    ForIterator,
    InlineDefinitionArgument,
    FinallyClause,
    ModuleBody,
    ArgumentList,
    ModuleDescriptor,
    ValueDefinition,
    AnyFunction,
    Annotations,
    AnonymousArgument,
    ElseClause,
    DecQualifier,
    Conditions,
    TypeParameter,
    ClassSpecifier,
    SwitchClause,
    IfClause,
    PackageDescriptor,
    Node,
    SatisfiedTypes,
    TypedDeclaration,
    Statement,
    ForClause,
    Expression,
    CaseExpression,
    CaseClause,
    FailClause,
    ConstructorDefinition,
    ComprehensionClause,
    Variable,
    Comprehension,
    ImportElements,
    AnyValue,
    AnyCompilationUnit,
    Import,
    TypeConstraint,
    TypeDeclaration,
    ValueDeclaration,
    ValueArgument,
    AnySpecifier,
    ModuleSpecifier,
    ObjectDefinition,
    PatternList,
    Resource,
    Condition,
    Resources,
    TypeParameters,
    ExtendedType,
    Arguments,
    AnyMemberOperator,
    NamedArgument,
    Parameters,
    ValueModifier,
    SwitchCases,
    Annotation,
    Declaration,
    CaseItem,
    Subscript,
    FunctionArgument,
    Body,
    FullPackageName,
    Pattern,
    SpreadArgument,
    Bound,
    ImportAlias,
    ValueSetterDefinition,
    ValueGetterDefinition,
    ModuleImport,
    ImportWildcard,
    TryClause,
    CatchClause,
    ExtensionOrConstruction,
    SpecifiedArgument,
    TypeSpecifier,
    TypeIsh,
    ObjectArgument,
    Visitor,
    CaseTypes,
    Identifier,
    ImportElement,
    Modifier,
    Parameter
}
import ceylon.collection {
    ArrayList
}

import com.gmail.podmev.utils.ast {
    parentSetterVisitor,
    getHeirarchy
}

"Посчитать количество value в ноде через visitor"
shared Integer findNumberOfValuesByVisitor(Node node) {
    variable Integer valueCount = 0;
    object visitor satisfies Visitor{
        shared actual void visitValueDefinition(ValueDefinition valueDefinition){
            if(is ValueModifier type = valueDefinition.type) {
                valueCount++;
            }
            valueDefinition.visitChildren(this);
        }
        shared actual void visitValueGetterDefinition(ValueGetterDefinition valueGetterDefinition){
            if(is ValueModifier type = valueGetterDefinition.type) {
                valueCount++;
            }
            valueGetterDefinition.visitChildren(this);
        }
        shared actual void visitValueArgument(ValueArgument valueArgument){
            if(is ValueModifier type = valueArgument.type) {
                valueCount++;
            }
            valueArgument.visitChildren(this);
        }
    }
    node.visit(visitor);
    return valueCount;
}
see(`value parentSetterVisitor`,
    `function getHeirarchy`)
shared [Node+][] findValuesByVisitor(Node node) {
    ArrayList<Node> valueNodes = ArrayList<Node>();
    object valueVisitor satisfies Visitor{
        shared actual void visitValueDefinition(ValueDefinition valueDefinition){
            if(is ValueModifier type = valueDefinition.type) {
                valueNodes.add(valueDefinition);
            }
            super.visitValueDefinition(valueDefinition);
        }
        shared actual void visitValueGetterDefinition(ValueGetterDefinition valueGetterDefinition){
            if(is ValueModifier type = valueGetterDefinition.type) {
                valueNodes.add(valueGetterDefinition);
            }
            super.visitValueGetterDefinition(valueGetterDefinition);
        }
        shared actual void visitValueArgument(ValueArgument valueArgument){
            if(is ValueModifier type = valueArgument.type) {
                valueNodes.add(valueArgument);
            }
            super.visitValueArgument(valueArgument);
        }
    }
    node.visit(parentSetterVisitor);
    node.visit(valueVisitor);
    return  valueNodes.collect(getHeirarchy);
}
//Совсем сырая, но рабочая версия
shared <Node[]>[] findValues(Node node, Node[] nodeHeirararchy = []){
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