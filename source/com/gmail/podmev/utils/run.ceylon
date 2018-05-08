import ceylon.ast.core {
    CompilationUnit,
    Declaration,
    ClassDefinition
}
import ceylon.ast.redhat {
    parseCompilationUnit
}
import ceylon.language.meta {
    type
}

import com.gmail.podmev.utils.astusage.analyse {
    findValues,
    findNumberOfValuesByVisitor,
    findValuesByVisitor,
    findMagicNumbers,
    findShortVariables
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
                value val = 4;
                print(a);
                switch(a)
                case(is Integer){
                    print("22");
                }
                case(3){
                    print("33");
                }
                else{
                    print("--");
                }
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
    print(findValues(classDeclaration).size);
    print(findNumberOfValuesByVisitor(classDeclaration));
    print("values : ``findValuesByVisitor(classDeclaration).size``");
    print("magic numbers: ``findMagicNumbers(classDeclaration).size``");
    print("short variables: ``findShortVariables(classDeclaration).size``");
    for(index->path in findShortVariables(classDeclaration).indexed) {
        print("``index`` short variable: ``"->".join(path.exceptLast.collect(type)*.declaration*.name)``->``path.last``");
    }
}
