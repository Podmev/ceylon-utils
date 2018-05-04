import ceylon.language.meta {
    type
}
import ceylon.language.serialization {
    SerializationException
}
"равенство объектов по всем полям, если разные типы, то выдаёт false
 Работает только в случае, если классы объектов проаннотированны аннотацией [[serializable]]"
tagged("hasTests")
throws(`class SerializationException`)
see(`class SerializableAnnotation`)
shared Boolean objEqualsByAllFields(Object obj1, Object obj2){
    if(!type(obj1).exactly(type(obj2))) {
        return false;
    }
    return objDiffs(obj1, obj2).empty;
}
