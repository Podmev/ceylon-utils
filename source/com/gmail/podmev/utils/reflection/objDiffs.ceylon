//import ceylon.language.meta {
//    type
//}
//import ceylon.language.serialization {
//    serialization,
//    ReachableReference,
//    Member
//}
//shared [<String->[Anything, Anything]>*] objDiffs(Object obj1, Object obj2) {
//    Map<String,Anything> obj1FieldMap = fieldValuesMap(obj1);
//    Map<String,Anything> obj2FieldMap = fieldValuesMap(obj2);
//
//    return { for (name in set(obj1FieldMap.keys)|set(obj1FieldMap.keys))
//            let (val1 = obj1FieldMap.getOrDefault(name, "<null>"),
//                val2 = obj2FieldMap.getOrDefault(name, "<null>"))
//                    name->[val1, val2]
//    }.select((name->[val1, val2])=>!equalsWithNull(val1, val2));
//}
//
//shared Boolean objEqualsExceptFields(String* fieldNames)(Object obj1, Object obj2){
//    if(type(obj1)!=type(obj2)) {
//        return false;
//    }
//    Set<String> nameSet = set(fieldNames);
//    return objDiffs(obj1, obj2).filter(forKey(not(nameSet.contains))).size==0;
//}
//
//shared Boolean objEqualsByAllFields(Object obj1, Object obj2){
//    if(type(obj1)!=type(obj2)) {
//        return false;
//    }
//    return objDiffs(obj1, obj2).size==0;
//}
//
//Boolean equalsWithNull(Anything a, Anything b){
//    if(exists a){
//        return if(exists b) then a==b else false;
//    }
//    return !b exists;
//}
//
//
//shared void run(){
//    A a1 = A(1);
//    A a2 = A(2);
//    value t = type(a2);
////    print(t.declaration);
////    print(t.getAttributes());
////    print(t.getDeclaredAttributes());
////    print(t.getMethods());
//    print(equalsWithNull(null, null));
//    print(equalsWithNull(null, 1));
//    print(equalsWithNull(1, null));
//    print(equalsWithNull(1, 1));
// //   Map<String, Anything> references = fieldValuesMap(a1);
//    print(objDiffs(a1, a2));
//    print(objEqualsExceptFields("s", "f")(a1, a2));
//    print(objEqualsExceptFields("s")(a1, a2));
////    print(references);
////    print(serialization().references(a2));
//
//
//}
//
//shared Map<String, Anything> fieldValuesMap(Object obj) =>
//        map{
//            for(ref->val in serialization().references(obj))
//                if(is Member ref)
//                    ref.attribute.name -> val
//        };
//
//
//serializable
//class A(Integer i){
//    shared String s=i.string;
//    shared Float f=i.float;
//    shared Float e=4.0;
//    shared Integer[] arr = [1,2];
//}