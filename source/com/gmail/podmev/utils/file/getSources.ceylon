import ceylon.file {
    Resource,
    current,
    Path,
    File,
    Directory
}
import ceylon.language.meta {
    type
}
import ceylon.language.meta.declaration {
    Module,
    Package
}
//TODO нужны тесты
//TODO можно добавить маску
"берёт все файлы исходников, соответствующие модулю или пакету [[moduleOrPackage]]"
see(`value current`)
shared File[]|Exception getSourceFilesByModuleOrPackage(
        Module|Package|String moduleOrPackage,
        Path projectDirectoryPath = current,
        String sourceName = "source",
        Boolean recursive = true) {
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
    return getFilesInDirectory {
        directory = maybeTargetDirectory;
        recursive = recursive;
    };
}

"Достать конкретный файл исходников с именем [[exactFileName]] в пакете [[pack]]"
shared File|Exception getSourceFileInSourcePackage(
        Package|String pack,
        String exactFileName,
        Path projectDirectoryPath = current,
        String sourceName = "source") {
    Directory|Exception maybeSourceDirectory = getSourceDirectory(projectDirectoryPath, sourceName);
    if(is Exception maybeSourceDirectory){
        return maybeSourceDirectory;
    }
    Directory|Exception maybeTargetDirectory = getPackageDirInSources {
        sourceDirectory = maybeSourceDirectory;
        moduleOrPackage = pack;
    };
    if(is Exception maybeTargetDirectory){
        return maybeTargetDirectory;
    }
    return getFileInDirectory {
        directory = maybeTargetDirectory;
        fileName = exactFileName;
    };
}

"Возвращает директорию с исходниками в проекте,
 при указанном пути к корню проекта [[projectDirectoryPath]] и имени исходников [[sourceName]]
 Считается, что исходники лежат в корне проекта"
shared Directory|Exception getSourceDirectory(Path projectDirectoryPath, String sourceName){
    Resource directoryResource = projectDirectoryPath.resource;
    if(!is Directory directoryResource){
        return Exception("projectDirectoryPath ``projectDirectoryPath`` is not a directory: ``type(directoryResource)``");
    }
    Resource sourceResource = directoryResource.childResource(sourceName);
    if(!is Directory sourceResource){
        return Exception("sourcePath ``sourceResource.path`` is not a directory: ``type(sourceResource)``");
    }
    return sourceResource;
}

"достать директорию, соответствующую модулю или пакету [[moduleOrPackage]] или его строковому предствлению,
 при указании дикектории исходников [[sourceDirectory]]"
shared Directory|Exception getPackageDirInSources(Directory sourceDirectory, Module|Package|String moduleOrPackage) {
    String targetName = if(is Module|Package moduleOrPackage) then moduleOrPackage.name else moduleOrPackage;
    //Предполагаем, что в пути в модуле и пакетах разделены точками
    [String+] packageRelativePaths = targetName.split('.'.equals).sequence();
    Directory|Exception maybeSubDirectory = getSubDirectory(sourceDirectory, *packageRelativePaths);
    return maybeSubDirectory;//даже в случае ошибки
}

shared void runTest(){
    print(getSourceDirectory(current, "source"));
}