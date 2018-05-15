import com.gmail.podmev.utils {
    equalsWithNull
}
//TODO можно два других интерфейса по аннотациям includeInEquals excludeInEquals
"интерфейс, который позволяет не задавать equals и hash
 Так получилось, чо без Identifiable не работает

 Пример:

            class Person(
                shared Integer age,
                shared String name,
                shared Boolean? married) satisfies MetaEqualable<Person1> {}

  Тогда верно, что
            assertEquals(Person(1,\"abc\", true), Person(1,\"abc\", true))
 "
see(
    `function fieldsInObject`,
    `function equalsWithNull`
)
tagged("hasTests")
shared interface MetaEqualable<Self> satisfies Identifiable given Self satisfies MetaEqualable<Self> {
    "equals по всем полям [[Self]]"
    shared actual Boolean equals(Object that) {
        if (is Self that) {
            return everyPair(equalsWithNull, allFields, that.allFields);
        }
        else {
            return false;
        }
    }

    "hash по всем полям [[Self]]"
    shared actual Integer hash {
        variable value hash = 1;
        for(field in allFields){
            hash = 31*hash + (field?.hash else 0);
        }
        return hash;
    }

    "Все поля, по которым идёт сравнение на equals и hash"
    see(`function fieldsInObject`)
    shared Anything[] allFields {
        //Note: без этого не работает
        "Приведение к самому себе"
        assert(is Self reallyThis = this);
        return fieldsInObject(reallyThis);
    }
}
