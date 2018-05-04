import ceylon.language.meta {
    type
}
import ceylon.language.serialization {
    SerializationException
}
"равенство объектов по всем полям кроме полей [[fieldNames]]
 Работает только в случае, если классы объектов проаннотированны аннотацией [[serializable]]"
tagged("hasTests")
throws(`class SerializationException`)
see(`class SerializableAnnotation`)
shared Boolean objEqualsExceptFields(String* fieldNames)(Object obj1, Object obj2){
    if(!type(obj1).exactly(type(obj2))) {
        return false;
    }
    Set<String> nameSet = set(fieldNames);
    return objDiffs(obj1, obj2)
        .filter(forKey(not(nameSet.contains)))
        .empty;
}