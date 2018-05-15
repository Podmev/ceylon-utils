import ceylon.language.meta {
    type
}

import com.gmail.podmev.utils {
    equalsWithNull
}

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
    shared actual Boolean equals(Object that) {
        if (is Self that) {
            Anything[] fieldsFromThis = fieldsInObject(this);
            Anything[] fieldsFromThat = fieldsInObject(that);
            print(type(this));
            print(type(that));
            print("``fieldsFromThis`` <=> ``fieldsFromThis``");
            return everyPair(equalsWithNull, fieldsFromThis, fieldsFromThat);
        }
        else {
            return false;
        }
    }

    shared actual Integer hash {
        variable value hash = 1;
        for(field in fieldsInObject(this)){
            hash = 31*hash + (field?.hash else 0);
        }
        return hash;
    }
}
