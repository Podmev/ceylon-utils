import ceylon.language.serialization {
    serialization,
    Member,
    ReachableReference,
    SerializationException,
    SerializationContext
}

//TODO необходимо проверить, действительно нужно брать тольно Member
"мапа всех полей объекта в формате: ключ - имя поля, значение - значение поля
 Работает только в случае, если классы объектов проаннотированны аннотацией [[serializable]]"
tagged("hasTests")
throws(`class SerializationException`)
see(
    `class SerializableAnnotation`,
    `interface ReachableReference`,
    `interface Member`,
    `function serialization`,
    `interface SerializationContext`,
    `function SerializationContext.references`
)
shared Map<String, Anything> fieldValuesMap(Object obj) =>
        map{
            for(ReachableReference ref-> Anything val in serialization().references(obj))
                if(is Member ref)
                    ref.attribute.name -> val
        };