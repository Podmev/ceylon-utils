import ceylon.language.meta {
    type
}
import ceylon.language.meta.model {
    ClassModel,
    Attribute
}
"Достать все поля из объекта, определённые прямо в классе, кроме hash и equals
 Порядок недетерминирован, но идёт в одном порядке для объектов одного и того же класса"
tagged("hasTest")
shared Anything[] fieldsInObject<ContainerType>(ContainerType containerObject) {
    ClassModel<ContainerType, Nothing> classModel = type(containerObject);
    Attribute<ContainerType, Anything, Nothing>[] declaredAttributes = classModel.getDeclaredAttributes<ContainerType, Anything>();
    Attribute<ContainerType, Anything, Nothing>[] selectedDeclaredAttributes =
            [for(declaredAttribute in declaredAttributes)
                if(!declaredAttribute.declaration.name in {"string", "hash"})
                    declaredAttribute
            ];
    Anything[] fields = [for(selectedByTagDeclaredAttribute in selectedDeclaredAttributes)
        selectedByTagDeclaredAttribute.bind(containerObject).get()
    ];
    return fields;
}

class Person(
    shared Integer age,
    shared String name,
    shared Boolean? married
        ){

    shared actual String string =>"Person(``name``, ``age``, ``married else "unknown"``)";

    shared actual Boolean equals(Object that) {
        if (is Person that) {
            return age==that.age &&
                name==that.name;
        }
        else {
            return false;
        }
    }

    shared actual Integer hash {
        variable value hash = 1;
        hash = 31*hash + age;
        hash = 31*hash + name.hash;
        return hash;
    }

}
shared void runFieldsInObject(){
    print(fieldsInObject(Person(20, "Dima", null)));
}