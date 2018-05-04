import ceylon.file {
    current,
    Path,
    File,
    Directory,
    Resource,
    parsePath
}

import com.gmail.podmev.utils.ast {
    parseAnyCompilationUnitFromFile
}
import com.gmail.podmev.utils.file {
    getSourceDirectory,
    getFilesInDirectory,
    isCeylonFile,
    getPackageDirInSources
}
import ceylon.language.meta.declaration {
    Module,
    Package
}
import ceylon.language.meta {
    type
}
"находит Ceylon'овские файлы проекта, которые не парсятся ast"
see(`function parseAnyCompilationUnitFromFile`)
see(`function isCeylonFile`)
shared File[]|Exception findBrokenFilesInProject(Path projectDirectoryPath = current, String sourceName = "source") {
    Directory|Exception maybeSourceDirectory = getSourceDirectory(projectDirectoryPath, sourceName);
    if(is Exception maybeSourceDirectory){
        return maybeSourceDirectory;
    }
    File[] allFiles = getFilesInDirectory(maybeSourceDirectory, true);
    return findBrokenFiles(allFiles);
}

"находит Ceylon'овские файлы проекта, которые не парсятся ast, вместе с их ошибками"
see(`function parseAnyCompilationUnitFromFile`)
see(`function isCeylonFile`)
shared <File->Exception>[]|Exception findBrokenFilesWithExceptionInProject(Path projectDirectoryPath = current, String sourceName = "source") {
    Directory|Exception maybeSourceDirectory = getSourceDirectory(projectDirectoryPath, sourceName);
    if(is Exception maybeSourceDirectory){
        return maybeSourceDirectory;
    }
    File[] allFiles = getFilesInDirectory(maybeSourceDirectory, true);
    return findBrokenFilesWithException(allFiles);
}

"находит Ceylon'овские файлы папки, которые не парсятся ast, вместе с их ошибками"
shared <File->Exception>[]|Exception findBrokenFilesWithExceptionInDirectory(Path directoryPath = current) {
    Resource directoryResource = directoryPath.resource;
    if(!is Directory directoryResource){
        return Exception("directory ``directoryPath`` is not a directory: ``type(directoryResource)``");
    }
    File[] allFiles = getFilesInDirectory(directoryResource, true);
    return findBrokenFilesWithException(allFiles);
}

shared File[]|Exception findBrokenFilesInModuleOrPackage(
        Module|Package|String moduleOrPackage,
        Path projectDirectoryPath = current,
        String sourceName = "source") {

    Directory|Exception maybeSourceDirectory = getSourceDirectory {
        projectDirectoryPath = projectDirectoryPath;
        sourceName = sourceName;
    };
    if(is Exception maybeSourceDirectory){
        return maybeSourceDirectory;
    }
    Directory|Exception maybeTargetDirectory = getPackageDirInSources {
        sourceDirectory = maybeSourceDirectory;
        moduleOrPackage = moduleOrPackage;
    };
    if(is Exception maybeTargetDirectory){
        return maybeTargetDirectory;
    }
    File[] allFiles = getFilesInDirectory(maybeTargetDirectory, true);
    return findBrokenFiles(allFiles);
}

File[]|Exception findBrokenFiles(File[] files){
    File[] ceylonFiles = files.select(isCeylonFile);
    return [
        for(file in ceylonFiles)
        if(is Exception parseException = parseAnyCompilationUnitFromFile(file))
        file
    ];
}

<File->Exception>[]|Exception findBrokenFilesWithException(File[] files){
    File[] ceylonFiles = files.select(isCeylonFile);
    return [
        for(file in ceylonFiles)
        if(is Exception parseException = parseAnyCompilationUnitFromFile(file))
        file->parseException
    ];
}


shared void runFindBrokenFilesInProject(){
    assert(is File[] brokenFiles = findBrokenFilesInProject());
    brokenFiles.each(print);
    print(brokenFiles.size);
}

shared void runFindBrokenFilesWithExceptionsInProject(){
    assert(is <File->Exception>[] brokenFilesWithException = findBrokenFilesWithExceptionInProject());
    for(file->exception in brokenFilesWithException){
        print("file: ``file``, exception = ``exception.cause?.message else exception.message``");
    }
    print(brokenFilesWithException.size);
}

shared void runFindBrokenFilesWithExceptionsInWorkspace(){
    Path path = parsePath("/home/dpozdin/workspace/ceylon");
    <File->Exception>[]|Exception brokenFilesWithException = findBrokenFilesWithExceptionInDirectory(path);
    if(is Exception brokenFilesWithException){
        throw brokenFilesWithException;
    }
//    for(file->exception in brokenFilesWithException){
//        print("file: ``file``, exception = ``exception.cause?.message else exception.message``");
//    }

    Map<String,[<File->Exception>+]> groups = brokenFilesWithException
        .filter((file->exception)=>!file.path.string.includes("bug"))//исключаем файлы с багами
        .filter((file->exception)=>!file.path.string.includes("Bug"))//исключаем файлы с багами
        .group((file->exception)=>exception.cause?.message else exception.message);
    for(msg->group in groups){
        print(msg);
        print("\t:``group*.key*.path``");
        //print("\t:``group*.key*.path*.elementPaths*.last``");
    }
    print(brokenFilesWithException.size);
    print(groups.size);

}
