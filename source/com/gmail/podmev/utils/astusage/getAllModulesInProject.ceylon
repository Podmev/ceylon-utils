import ceylon.ast.core {
    ModuleDescriptor,
    AnyCompilationUnit
}
import ceylon.file {
    current,
    Path,
    Directory,
    File
}

import com.gmail.podmev.utils.ast {
    getModuleDescriptors,
    getModuleDescriptorName,
    parseAnyCompilationUnitFromFiles
}
import com.gmail.podmev.utils.file {
    getSourceDirectory,
    getFilesInDirectories,
    getAllNonemptySubDirectories,
    isCeylonModuleFile
}
//TODO можно отрефакторить и перегруппировать
"Выдаёт все ast-представления модулей проекта"
see(`function getAllNonemptySubDirectories`)
see(`function isCeylonModuleFile`)
shared ModuleDescriptor[]|Exception getAllModulesInProject(Path projectDirectoryPath = current, String sourceName = "source") {
    Directory|Exception maybeSourceDirectory = getSourceDirectory(projectDirectoryPath, sourceName);
    if(is Exception maybeSourceDirectory){
        return maybeSourceDirectory;
    }
    Directory[] subDirectories = getAllNonemptySubDirectories(maybeSourceDirectory);
    File[] topLevelFiles = getFilesInDirectories {
        directories = subDirectories;
        recursive = false;
    };
    //нужно пофильтроваться по именам файлов
    File[] moduleFiles = topLevelFiles.select(isCeylonModuleFile);
    //некоторые файлы могут не парситься, поэтому берём только файлы модулей
    AnyCompilationUnit[]|Exception allAsts = parseAnyCompilationUnitFromFiles(moduleFiles);
    if(is Exception allAsts){
        return allAsts;
    }
    ModuleDescriptor[] moduleDescriptors = allAsts.flatMap(getModuleDescriptors).sequence();
    return moduleDescriptors;
}

"Выводит все имена модулей проекта"
see(`function getModuleDescriptorName`)
shared String[]|Exception getAllModulesNamesInProject(Path projectDirectoryPath = current, String sourceName = "source") {
    ModuleDescriptor[]|Exception allModulesInProject = getAllModulesInProject(projectDirectoryPath, sourceName);
    if(is Exception allModulesInProject){
        return allModulesInProject;
    }
    return allModulesInProject.collect(getModuleDescriptorName);
}

shared void runGetAllModulesNamesInProject(){
    print(getAllModulesNamesInProject());
}
