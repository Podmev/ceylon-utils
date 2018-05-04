import ceylon.ast.core {
    ClassDefinition,
    CompilationUnit,
    SatisfiedTypes,
    PrimaryType
}
import ceylon.ast.redhat {
    parseCompilationUnit,
    classAliasDefinitionToCeylon
}

import com.gmail.podmev.utils.file {
    getSourceFileInSourcePackage,
    getFileInDirectory
}
import ceylon.file {
    File,
    parsePath
}
"достать все определения классов из кода в виде строки [[code]]"
shared ClassDefinition[]|Exception getClassDefinitionsFromCode(String code){
    CompilationUnit? compilationUnit = parseCompilationUnit(code);
    if(!exists compilationUnit){
        return Exception("cannot parse code:``code.substring(0, 200)``");
    }
    return getClassDefinitionsFromCompilationUnit(compilationUnit);
}

shared ClassDefinition[] getClassDefinitionsFromCompilationUnit(CompilationUnit compilationUnit) =>
        getSomeKindAstElements<ClassDefinition>(compilationUnit);

"проверяет только на типы"
shared Boolean satisfiesClassDefinition([PrimaryType+] requiredSatisfiedTypes)(ClassDefinition classDefinition){
    SatisfiedTypes? maybeSatisfiedTypes = classDefinition.satisfiedTypes;
    if(!exists maybeSatisfiedTypes){
        return false;
    }
    [PrimaryType+] satisfiedTypes = maybeSatisfiedTypes.satisfiedTypes;
    Set<PrimaryType> existingSatisfiesTypesSet = set(satisfiedTypes);
    //проверяем, что каждая должна там быть
    return requiredSatisfiedTypes.every(existingSatisfiesTypesSet.contains);
}

"проверяет на абстракность"
shared Boolean isAbstractClassDefinition(ClassDefinition classDeclaration) =>
        classDeclaration.annotations.annotations*.name*.name.contains("abstract");

shared ClassDefinition getClassDefinition(String path, String className){
    assert(is File file = parsePath(path).resource);
    assert(is CompilationUnit compilationUnitFromFile = parseCompilationUnitFromFile(file));
    assert(is ClassDefinition classDeclaration = getSomeKindAstElements<ClassDefinition>(compilationUnitFromFile)
        .find((classDefinition)=>classDefinition.name.name == className));
    return classDeclaration;
}

shared void run1(){
    ClassDefinition classDefinition = getClassDefinition {
        path = "/home/dpozdin/workspace/autodelivery/source/ru/dellin/autodelivery/reader/errors/excel.ceylon";
        className = "FileReadingError";
    };
    print(getStringFieldValue("localCode")(classDefinition));


}

//TODO добавить методы на проверку импортов и подстановку алисов от туда
//TODO импортам

