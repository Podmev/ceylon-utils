import ceylon.ast.core {
    Node,
    Declaration,
    AnyCompilationUnit
}

shared NodeKind[] getSomeKindAstElements<NodeKind>(AnyCompilationUnit anyCompilationUnit) given NodeKind satisfies Node=>
        [ for(Declaration declaration in anyCompilationUnit.declarations)
            if(is NodeKind declaration)
                declaration
        ];
