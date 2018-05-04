import ceylon.language.meta {
    type
}
import ceylon.language.meta.model {
    Type
}

shared void initAllLate<T>(T obj) given T satisfies Object {
    value classModel = type(obj);
    Type<SharedAnnotation> sharesAnnotationType = `SharedAnnotation`;
    print(classModel.getAttributes(sharesAnnotationType));
}
