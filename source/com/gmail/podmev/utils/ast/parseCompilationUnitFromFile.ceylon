import ceylon.ast.core {
    AnyCompilationUnit,
    CompilationUnit
}
import ceylon.ast.redhat {
    parseAnyCompilationUnit,
    parseCompilationUnit
}
import ceylon.file {
    File,
    lines,
    parsePath
}
import ceylon.language.meta {
    type
}

import com.gmail.podmev.utils.functools {
    convertFuncWithKey,
    propagateMapFirstErrorAsEntry,
    propagateFirstError
}
//TODO подумать над сигнатурой
"Распарсить file как ceylon'овский файл и построить ast
 НО кроме паетов и модулей
 "
see(`function parseCompilationUnit`)
shared CompilationUnit|Exception parseCompilationUnitFromFile(File file) {
    try {

        String fileContent = "\n".join(lines(file));

        CompilationUnit? compilationUnit = parseCompilationUnit(fileContent);
        if(!exists compilationUnit){
            return Exception("Cannot parse compilationUnit from ``fileContent.substring(0, 200)``");
        }
        return compilationUnit;
        //TODO подумать, какая ошибка
    } catch(Throwable th){
        return Exception("Cannot load content of file ``file``",th);
    }
}
"Распарить много файлов Ceylon как ast или упать"
shared CompilationUnit[]|Exception parseCompilationUnitFromFiles(File[] files) =>
    propagateFirstError<CompilationUnit, Exception>(files.map(parseCompilationUnitFromFile));

//TODO подумать, нужно или нет
"Распарсить file как ceylon'овский файл и построить ast
 и пакеты и модули
 "
see(`function parseAnyCompilationUnit`)
shared AnyCompilationUnit|Exception parseAnyCompilationUnitFromFile(File file) {
    try {

        String fileContent = "\n".join(lines(file));

        AnyCompilationUnit? anyCompilationUnit = parseAnyCompilationUnit(fileContent);
        if(!exists anyCompilationUnit){
            return Exception("Cannot parse anyCompilationUnit from ``fileContent.substring(0, 200)``");
        }
        return anyCompilationUnit;
        //TODO подумать, какая ошибка
    } catch(Throwable th){
        return Exception("Cannot load content of file ``file``", th);
    }
}
"Распарить много файлов Ceylon как ast или упать"
shared AnyCompilationUnit[]|Exception parseAnyCompilationUnitFromFiles(File[] files) =>
        propagateFirstError<AnyCompilationUnit, Exception>(files.map(parseAnyCompilationUnitFromFile));

"Распарить много файлов Ceylon как ast или упать"
see(`function convertFuncWithKey`)
shared Map<File,AnyCompilationUnit>|Exception parseAnyCompilationUnitFromFilesInMap(File[] files) {
    <File->AnyCompilationUnit>[]|Exception res = propagateMapFirstErrorAsEntry<File,AnyCompilationUnit,Exception> {
        vals = files;
        transform = parseAnyCompilationUnitFromFile;
    };
    return if(is Exception res) then res else map(res);
}

shared void runParseCompilationUnitFromFile(){
    String pathStr = "/home/dpozdin/workspace/autodelivery/source/ru/dellin/autodelivery/preprocessor/module.ceylon";
    assert(is File file = parsePath(pathStr).resource);
    assert(is AnyCompilationUnit[] units = parseAnyCompilationUnitFromFiles([file]));
    print(type(units));
}

