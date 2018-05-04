import ceylon.language.meta {
    type
}
import ceylon.file {
    Resource,
    File,
    Link,
    Directory
}
//TODO подумать про Link
"берёт все файлы из директории [[directory]], рекурсивно или нет"
tagged("recursiveAlgorithm")
shared File[] getFilesInDirectory(Directory directory, Boolean recursive) =>
        concatenate(
            for(child in directory.children())
                (switch(child)
                case (is File) [child]
                case (is Directory) (if(recursive) then getFilesInDirectory(child, recursive) else [])
                case (is Link) []//вообще не берём Link
                )
        );

"берёт все файлы из директорий [[directories]], рекурсивно или нет"
see(`function getFilesInDirectory`)
shared File[] getFilesInDirectories(Directory[] directories, Boolean recursive) =>
        concatenate(
            for(directory in directories)
                getFilesInDirectory(directory, recursive)
        );

"Функция достать под директорию от [[directory]] с шагами [[orderedPaths]]
 аля `directory/orderedPaths[0]/orderedPaths[1]/../orderedPaths[orderedPaths.lastIndex]`
 "
shared Directory|Exception getSubDirectory(Directory directory, String* orderedPaths){
    variable Directory currentDir = directory;
    for(path in orderedPaths){
        Resource nextStepResource = currentDir.childResource(path);
        if(!is Directory nextStepResource){
            return Exception("sourcePath ``nextStepResource.path`` is not a directory: ``type(nextStepResource)``");
        }
        //переприсваем текущий путь
        currentDir = nextStepResource;
    }
    return currentDir;
}

"Достать файл с именем [[fileName]] из директории [[directory]]"
shared File|Exception getFileInDirectory(Directory directory, String fileName){
    Resource fileResource = directory.childResource(fileName);
    if(!is File fileResource){
        return Exception("sourcePath ``fileResource.path`` is not a file: ``type(fileResource)``");
    }
    return fileResource;
}

"Выдаёт все верхрнеуровневые поддиректории"
shared Directory[] getAllSubDirectories(Directory directory)=>
    [for(child in directory.children())
        if(is Directory child) child
    ];

"Выдаёт все поддиректории, которые содержат хотя бы один файл (первые по иерархии)"
shared Directory[] getAllNonemptySubDirectories(Directory directory)=>
        concatenate(for(child in directory.children())
            if(is Directory child) (
                if(hasFilesInDirectory(child))
                then [child]
                else getAllNonemptySubDirectories(child)
            )
        );

"Проверяет есть ли файлы в директории"
shared Boolean hasFilesInDirectory(Directory directory)=>
    !directory.children().narrow<File>().empty;

