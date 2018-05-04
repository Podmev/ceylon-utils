import ceylon.file {
    File,
    Path
}

import com.gmail.podmev.utils {
    multiAnd
}
//фильтрации на файлы
shared Boolean isCeylonFile(File file) => file.name.endsWith(".ceylon");
shared Boolean isJavaFile(File file) => file.name.endsWith(".java");
shared Boolean isCeylonModuleFile(File file) => file.name.endsWith("module.ceylon");
shared Boolean isCeylonPackageFile(File file) => file.name.endsWith("package.ceylon");

"для фильтрации по множеству файлов"
shared Boolean isNotInBlackListFile(Set<Path> blackList)(File file) => !blackList.contains(file.path);
//TODO можно добавить другие фильтры
see(`function multiAnd`)
shared Boolean(File) composeFileSelectors(Boolean(File)* fileSelectors) => multiAnd(*fileSelectors);

