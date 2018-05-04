import ceylon.language.serialization {
    SerializationException
}

import com.gmail.podmev.utils {
    equalsWithNull
}

"список отличий между объектами по всем полям в виде мапы. ключ - имя поля, значение - пара
 [значение поля из первого объекта [[obj1]], значение поля из второго объекта [[obj2]]]"
tagged("hasTests")
see(`function equalsWithNull`)
see(`function fieldValuesMap`)
throws(`class SerializationException`)
shared Map<String, Anything[2]> objDiffs(Object obj1, Object obj2) {
    Map<String, Anything> obj1FieldMap = fieldValuesMap(obj1);
    Map<String, Anything> obj2FieldMap = fieldValuesMap(obj2);

    return map(
        { for (name in set(obj1FieldMap.keys)|set(obj2FieldMap.keys))
            let (val1 = obj1FieldMap.getOrDefault(name, "<null>"),
                val2 = obj2FieldMap.getOrDefault(name, "<null>"))
                    name->[val1, val2]
        }.filter((name->[val1, val2])=>!equalsWithNull(val1, val2))
    );
}