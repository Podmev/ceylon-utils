import ceylon.ast.core {
    ClassDefinition,
    AnyCompilationUnit
}
import ceylon.file {
    current,
    Path,
    File
}
import ceylon.language.meta.declaration {
    Module,
    Package
}

import com.gmail.podmev.utils {
    multiAnd
}
import com.gmail.podmev.utils.ast {
    getSomeKindAstElements,
    parseAnyCompilationUnitFromFilesInMap,
    parseAnyCompilationUnitFromFiles
}
import com.gmail.podmev.utils.file {
    isCeylonFile,
    getSourceFilesByModuleOrPackage
}
shared Exception[] checkClassesInCode(
        Module|Package moduleOrPackage,
        "Предикат выбора классов"
        Boolean(ClassDefinition) classDefinitionSelector,
        "проверка "
        Exception[](ClassDefinition) classDefinitionChecker,
        //Дополнительные параметры
        Path projectDirectoryPath = current,
        String sourceName = "source",
        Boolean recursive = true
        ) {

    return [];
}
//TODO подумать о сигнатуре
"пара определение класса"
shared Map<File, Map<ClassDefinition, T>>|Exception mapClassesInCode<T>(
        Module|Package|String moduleOrPackage,
        "Предикаты выбора классов"
        Boolean(ClassDefinition)[] classDefinitionSelectors,
        "преобразование из классов во что требуется"
        T(ClassDefinition) classDefinitionTransform,
        //Дополнительные параметры
        "Селектор файлов - по умолчанию все файлы"
        Boolean(File)[] fileSelectors = [],
        Path projectDirectoryPath = current,
        String sourceName = "source",
        Boolean recursive = true
        ) {
    File[]|Exception allFiles = getSourceFilesByModuleOrPackage {
        moduleOrPackage = moduleOrPackage;
        projectDirectoryPath = projectDirectoryPath;
        sourceName = sourceName;
        recursive = recursive;

    };
    if(is Exception allFiles){
        return allFiles;
    }
    Map<File,[ClassDefinition+]>|Exception classDefinitionsByFiles = findClassDefinitionsInFilesInMap {
        files = allFiles;
        fileSelectors = fileSelectors;
        classDefinitionSelectors = classDefinitionSelectors;
    };
    if(is Exception classDefinitionsByFiles){
        return classDefinitionsByFiles;
    }
    return map{
            for (file->classDefinitions in classDefinitionsByFiles)
                file->(
                    map{for (classDefinition in classDefinitions)
                        classDefinition->classDefinitionTransform(classDefinition)
                    }
                )
        };
}

//TODO нужен фильтратор по импортам
"Достать все необходимые AST-представления классов из файлов
 Можно добавить фильтрации на файлы и ast-представления классов
 автоматически фильтрует по ceylon'овским файлам"
see(`function multiAnd`,
    `function isCeylonFile`,
    `function getSomeKindAstElements`)
shared Map<File,[ClassDefinition+]>|Exception findClassDefinitionsInFilesInMap(
        File[] files,
        "Селектор файлов - по умолчанию все файлы"
        Boolean(File)[] fileSelectors = [],
        "Набор Предикат выбора классов"
        Boolean(ClassDefinition)[] classDefinitionSelectors = []
        ){
    "отфильтрованные файлы, всегда дополнительно фильтруемся только по Ceylon'овским файлам"
    File[] selectedFiles = files.select(multiAnd(isCeylonFile, *fileSelectors));

    Map<File, AnyCompilationUnit>|Exception allAstsByFiles = parseAnyCompilationUnitFromFilesInMap(selectedFiles);
    if(is Exception allAstsByFiles){
        return allAstsByFiles;
    }
    return map{for(file->anyCompilationUnit in allAstsByFiles)
        if(nonempty [ClassDefinition+] classDefinitions = getSomeKindAstElements<ClassDefinition>(anyCompilationUnit)
            .select(multiAnd(*classDefinitionSelectors)))
                file->classDefinitions
    };
}

//TODO нужен фильтратор по импортам
see(`function multiAnd`,
    `function isCeylonFile`,
    `function getSomeKindAstElements`)
shared ClassDefinition[]|Exception findClassDefinitionsInFiles(
        File[] files,
        "Селектор файлов - по умолчанию все файлы"
        Boolean(File)[] fileSelectors = [],
        "Набор Предикат выбора классов"
        Boolean(ClassDefinition)[] classDefinitionSelectors = []
        ){

    "отфильтрованные файлы, всегда дополнительно фильтруемся только по Ceylon'овским файлам"
    File[] selectedFiles = files.select(multiAnd(isCeylonFile, *fileSelectors));
    AnyCompilationUnit[]|Exception allAsts = parseAnyCompilationUnitFromFiles(selectedFiles);
    if(is Exception allAsts){
        return allAsts;
    }
    ClassDefinition[] allClassDefinitions = allAsts.flatMap(getSomeKindAstElements<ClassDefinition>).sequence();
    ClassDefinition[] selectedClassDefinitions = allClassDefinitions.select(multiAnd(*classDefinitionSelectors));
    return selectedClassDefinitions;
}

//TODO написать метод, где нет equals и hashCode
//TODO написать метод, где нет string