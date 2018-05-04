import ceylon.file {
    current,
    Path,
    File
}
import ceylon.language.meta.declaration {
    NestableDeclaration
}
"Достать файл по декларации"
see(`function getSourceFileInSourcePackage`)
shared File|Exception fileByDeclaration(
        NestableDeclaration nestableDeclaration,
        "может быть другое имя файла - в этом случае явно указать"
        String fileName = nestableDeclaration.name + ".ceylon",
        Path projectDirectoryPath = current,
        String sourceName = "source"
        ) {

    return getSourceFileInSourcePackage{
        exactFileName = fileName;
        pack = nestableDeclaration.containingPackage;
        projectDirectoryPath = projectDirectoryPath;
        sourceName = sourceName;
    };
}