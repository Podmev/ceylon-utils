import ceylon.ast.core {
    ...
}

"для примера"
void fullNodeSwitch(Node node) {
    switch (node)
    case (is Expression) {
        switch (node)
        case (is ValueExpression) {
            switch (node)
            case (is Primary) {
                switch (node)
                case (is Atom) {
                    switch (node)
                    case (is Literal) {
                        switch (node)
                        case (is StringLiteral) {                        }
                        case (is CharacterLiteral) {                        }
                        case (is IntegerLiteral) {                        }
                        case (is FloatLiteral) {                        }
                    }
                    case (is StringTemplate) {                    }
                    case (is SelfReference) {
                        switch (node)
                        case (is This) {                        }
                        case (is Super) {                        }
                        case (is Outer) {                        }
                        case (is Package) {                        }
                    }
                    case (is GroupedExpression) {                    }
                    case (is Iterable) {                    }
                    case (is Tuple) {                    }
                    case (is DynamicValue) {                    }
                    case (is ObjectExpression) {                    }
                }
                case (is BaseExpression) {                }
                case (is QualifiedExpression) {                }
                case (is Invocation) {                }
                case (is ElementOrSubrangeExpression) {                }
                case (is Meta) {
                    switch (node)
                    case (is TypeMeta) {                    }
                    case (is BaseMeta) {                    }
                    case (is MemberMeta) {                    }
                }
                case (is Dec) {
                    switch (node)
                    case (is TypeDec) {
                        switch (node)
                        case (is ClassDec) {                        }
                        case (is InterfaceDec) {}
                        case (is AliasDec) {                        }
                        case (is GivenDec) {                        }
                    }
                    case (is MemberDec) {
                        switch (node)
                        case (is ValueDec) {                        }
                        case (is FunctionDec) {                        }
                    }
                    case (is ConstructorDec) {                    }
                    case (is PackageDec) {                    }
                    case (is ModuleDec) {                    }
                }
            }
            case (is Operation) {
                switch (node)
                case (is UnaryIshOperation) {
                    switch (node)
                    case (is UnaryOperation) {
                        switch (node)
                        case (is PostfixOperation) {
                            switch (node)
                            case (is PostfixIncrementOperation) {                            }
                            case (is PostfixDecrementOperation) {                            }
                        }
                        case (is PrefixOperation) {
                            switch (node)
                            case (is PrefixIncrementOperation) {                            }
                            case (is PrefixDecrementOperation) {                            }
                        }
                        case (is UnaryArithmeticOperation) {                            switch (node)
                            case (is IdentityOperation) {                            }
                            case (is NegationOperation) {                            }
                        }
                        case (is ExistsOperation) {                        }
                        case (is NonemptyOperation) {                        }
                        case (is NotOperation) {                        }
                    }
                    case (is UnaryTypeOperation) {                        switch (node)
                        case (is IsOperation) {                        }
                        case (is OfOperation) {                        }
                    }
                }
                case (is BinaryOperation) {
                    switch (node)
                    case (is ArithmeticOperation) {
                        switch (node)
                        case (is ExponentiationOperation) {                        }
                        case (is ProductOperation) {                        }
                        case (is QuotientOperation) {                        }
                        case (is RemainderOperation) {                        }
                        case (is SumOperation) {                        }
                        case (is DifferenceOperation) {                        }
                    }
                    case (is SetOperation) {
                        switch (node)
                        case (is IntersectionOperation) {                        }
                        case (is UnionOperation) {                        }
                        case (is ComplementOperation) {                        }
                    }
                    case (is ScaleOperation) {                    }
                    case (is SpanOperation) {                    }
                    case (is MeasureOperation) {                    }
                    case (is EntryOperation) {                    }
                    case (is InOperation) {                    }
                    case (is ComparisonOperation) {
                        switch (node)
                        case (is LargerOperation) {                        }
                        case (is SmallerOperation) {                        }
                        case (is LargeAsOperation) {                        }
                        case (is SmallAsOperation) {                        }
                    }
                    case (is CompareOperation) {                    }
                    case (is EqualityOperation) {
                        switch (node)
                        case (is EqualOperation) {                        }
                        case (is NotEqualOperation) {                        }
                        case (is IdenticalOperation) {                        }
                    }
                    case (is LogicalOperation) {
                        switch (node)
                        case (is AndOperation) {                        }
                        case (is OrOperation) {                        }
                    }
                    case (is ThenOperation) {                    }
                    case (is ElseOperation) {                    }
                    case (is AssignmentOperation) {
                        switch (node)
                        case (is AssignOperation) {                        }
                        case (is ArithmeticAssignmentOperation) {
                            switch (node)
                            case (is AddAssignmentOperation) {                            }
                            case (is SubtractAssignmentOperation) {                            }
                            case (is MultiplyAssignmentOperation) {                            }
                            case (is DivideAssignmentOperation) {                            }
                            case (is RemainderAssignmentOperation) {                            }
                        }
                        case (is SetAssignmentOperation) {
                            switch (node)
                            case (is IntersectAssignmentOperation) {                            }
                            case (is UnionAssignmentOperation) {                            }
                            case (is ComplementAssignmentOperation) {                            }
                        }
                        case (is LogicalAssignmentOperation) {
                            switch (node)
                            case (is AndAssignmentOperation) {                            }
                            case (is OrAssignmentOperation) {                            }
                        }
                    }
                }
                case (is WithinOperation) {                }
            }
        }
        case (is FunctionExpression) {        }
        case (is LetExpression) {        }
        case (is ConditionalExpression) {
            switch (node)
            case (is IfElseExpression) {            }
            case (is SwitchCaseElseExpression) {            }
        }
    }
    case (is Statement) {
        switch (node)
        case (is Specification) {
            switch (node)
            case (is ValueSpecification) {            }
            case (is LazySpecification) {            }
        }
        case (is ExpressionStatement) {
            switch (node)
            case (is AssignmentStatement) {            }
            case (is PrefixPostfixStatement) {            }
            case (is InvocationStatement) {            }
        }
        case (is Assertion) {        }
        case (is Directive) {
            switch (node)
            case (is Return) {            }
            case (is Throw) {            }
            case (is Break) {            }
            case (is Continue) {            }
        }
        case (is ControlStructure) {
            switch (node)
            case (is IfElse) {            }
            case (is While) {            }
            case (is ForFail) {            }
            case (is SwitchCaseElse) {            }
            case (is TryCatchFinally) {            }
            case (is DynamicBlock) {            }
        }
        case (is Destructure) {        }
    }
    case (is Declaration) {
        switch (node)
        case (is TypeDeclaration) {
            switch (node)
            case (is ClassOrInterface) {
                switch (node)
                case (is AnyClass) {
                    switch (node)
                    case (is ClassDefinition) {                    }
                    case (is ClassAliasDefinition) {                    }
                }
                case (is AnyInterface) {
                    switch (node)
                    case (is AnyInterfaceDefinition) {
                        switch (node)
                        case (is InterfaceDefinition) {                        }
                        case (is DynamicInterfaceDefinition) {                        }
                    }
                    case (is InterfaceAliasDefinition) {                    }
                }
            }
            case (is TypeAliasDefinition) {            }
        }
        case (is TypedDeclaration) {
            switch (node)
            case (is AnyValue) {
                switch (node)
                case (is ValueDeclaration) {                }
                case (is ValueDefinition) {                }
                case (is ValueGetterDefinition) {                }
            }
            case (is AnyFunction) {
                switch (node)
                case (is FunctionDeclaration) {                }
                case (is FunctionDefinition) {                }
                case (is FunctionShortcutDefinition) {                }
            }
        }
        case (is ObjectDefinition) {
        }
        case (is ValueSetterDefinition) {        }
        case (is ConstructorDefinition) {
            switch (node)
            case (is CallableConstructorDefinition) {            }
            case (is ValueConstructorDefinition) {            }
        }
    }
    case (is Annotation) {    }
    case (is Annotations) {    }
    case (is Parameter) {
        switch (node)
        case (is RequiredParameter) {
            switch (node)
            case (is ValueParameter) {            }
            case (is CallableParameter) {            }
            case (is ParameterReference) {            }
        }
        case (is DefaultedParameter) {
            switch (node)
            case (is DefaultedValueParameter) {            }
            case (is DefaultedCallableParameter) {            }
            case (is DefaultedParameterReference) {            }
        }
        case (is VariadicParameter) {        }
    }
    case (is TypeParameter) {    }
    case (is TypeParameters) {    }
    case (is CaseTypes) {    }
    case (is SatisfiedTypes) {    }
    case (is TypeConstraint) {    }
    case (is PackageDescriptor) {    }
    case (is ModuleImport) {    }
    case (is ModuleBody) {    }
    case (is ModuleDescriptor) {    }
    case (is ImportAlias) {    }
    case (is ImportWildcard) {    }
    case (is ImportElement) {    }
    case (is ImportElements) {    }
    case (is Import) {    }
    case (is AnyCompilationUnit) {
        switch (node)
        case (is CompilationUnit) {        }
        case (is ModuleCompilationUnit) {        }
        case (is PackageCompilationUnit) {        }
    }
    case (is Condition) {
        switch (node)
        case (is BooleanCondition) {        }
        case (is IsCondition) {        }
        case (is ExistsOrNonemptyCondition) {
            switch (node)
            case (is ExistsCondition) {            }
            case (is NonemptyCondition) {            }
        }
    }
    case (is Conditions) {    }
    case (is IfClause) {    }
    case (is ElseClause) {    }
    case (is ExtendedType) {    }
    case (is ClassSpecifier) {    }
    case (is TypeSpecifier) {    }
    case (is Variable) {
        switch (node)
        case (is TypedVariable) {        }
        case (is SpecifiedVariable) {        }
        case (is UnspecifiedVariable) {        }
        case (is VariadicVariable) {        }
    }
    case (is ForIterator) {    }
    case (is ForClause) {    }
    case (is FailClause) {    }
    case (is ComprehensionClause) {
        switch (node)
        case (is InitialComprehensionClause) {
            switch (node)
            case (is ForComprehensionClause) {            }
            case (is IfComprehensionClause) {            }
        }
        case (is ExpressionComprehensionClause) {        }
    }
    case (is FinallyClause) {    }
    case (is CatchClause) {    }
    case (is Resource) {    }
    case (is Resources) {    }
    case (is TryClause) {    }
    case (is CaseItem) {
        switch (node)
        case (is MatchCase) {        }
        case (is IsCase) {        }
    }
    case (is CaseClause) {    }
    case (is SwitchCases) {    }
    case (is SwitchClause) {    }
    case (is TypeIsh) {
        switch (node)
        case (is Type) {
            switch (node)
            case (is MainType) {
                switch (node)
                case (is UnionType) {                }
                case (is UnionableType) {
                    switch (node)
                    case (is IntersectionType) {                    }
                    case (is PrimaryType) {
                        switch (node)
                        case (is SimpleType) {
                            switch (node)
                            case (is BaseType) {                            }
                            case (is QualifiedType) {                            }
                        }
                        case (is TupleType) {                        }
                        case (is IterableType) {                        }
                        case (is GroupedType) {                        }
                        case (is OptionalType) {                        }
                        case (is SequentialType) {                        }
                        case (is CallableType) {                        }
                    }
                }
            }
            case (is EntryType) {            }
        }
        case (is NameWithTypeArguments) {
            switch (node)
            case (is TypeNameWithTypeArguments) {            }
            case (is MemberNameWithTypeArguments) {            }
        }
        case (is VariadicType) {        }
        case (is DefaultedType) {        }
        case (is TypeList) {        }
        case (is SpreadType) {        }
        case (is TypeArgument) {        }
        case (is TypeArguments) {        }
        case (is PackageQualifier) {        }
    }
    case (is Identifier) {
        switch (node)
        case (is LIdentifier) {        }
        case (is UIdentifier) {        }
    }
    case (is FullPackageName) {    }
    case (is ArgumentList) {    }
    case (is SpreadArgument) {    }
    case (is Arguments) {
        switch (node)
        case (is PositionalArguments) {        }
        case (is NamedArguments) {        }
    }
    case (is NamedArgument) {
        switch (node)
        case (is AnonymousArgument) {        }
        case (is SpecifiedArgument) {        }
        case (is InlineDefinitionArgument) {
            switch (node)
            case (is ValueArgument) {            }
            case (is FunctionArgument) {            }
            case (is ObjectArgument) {            }
        }
    }
    case (is AnySpecifier) {
        switch (node)
        case (is Specifier) {        }
        case (is LazySpecifier) {        }
    }
    case (is Parameters) {    }
    case (is Bound) {
        switch (node)
        case (is OpenBound) {        }
        case (is ClosedBound) {        }
    }
    case (is Modifier) {
        switch (node)
        case (is TypeModifier) {
            switch (node)
            case (is LocalModifier) {
                switch (node)
                case (is ValueModifier) {                }
                case (is FunctionModifier) {                }
            }
            case (is VoidModifier) {            }
            case (is DynamicModifier) {            }
        }
        case (is Variance) {
            switch (node)
            case (is InModifier) {            }
            case (is OutModifier) {            }
        }
    }
    case (is Body) {
        switch (node)
        case (is Block) {        }
        case (is ClassBody) {        }
        case (is InterfaceBody) {        }
    }
    case (is Comprehension) {    }
    case (is Subscript) {
        switch (node)
        case (is KeySubscript) {        }
        case (is RangeSubscript) {
            switch (node)
            case (is SpanSubscript) {            }
            case (is MeasureSubscript) {            }
            case (is SpanFromSubscript) {            }
            case (is SpanToSubscript) {            }
        }
    }
    case (is DecQualifier) {    }
    case (is AnyMemberOperator) {
        switch (node)
        case (is MemberOperator) {        }
        case (is SafeMemberOperator) {        }
        case (is SpreadMemberOperator) {        }
    }
    case (is Pattern) {
        switch (node)
        case (is VariablePattern) {        }
        case (is TuplePattern) {        }
        case (is EntryPattern) {        }
    }
    case (is SpecifiedPattern) {    }
    case (is PatternList) {    }
    case (is CaseExpression) {    }
    case (is ExtensionOrConstruction) {
        switch (node)
        case (is Extension) {        }
        case (is Construction) {        }
    }
    case (is ModuleSpecifier) {    }
}