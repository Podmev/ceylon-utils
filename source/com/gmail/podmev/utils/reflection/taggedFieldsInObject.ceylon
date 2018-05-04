import ceylon.language.meta {
    type,
    annotations
}
import ceylon.language.meta.model {
    ClassModel,
    Attribute
}

"достать значения полей, протегированных со значением [[taggedVal]], имеющим тип [[FieldType]] в объекте [[containerObject]]"
tagged("hasTests")
shared FieldType[] taggedFieldsInObject<FieldType, ContainerType>(ContainerType containerObject, String taggedVal) {
    ClassModel<ContainerType,Nothing> classModel = type(containerObject);
    Attribute<ContainerType,FieldType,Nothing>[] declaredAttributes = classModel.getDeclaredAttributes<ContainerType, FieldType>();
    Attribute<ContainerType, FieldType,Nothing>[] selectedByTagDeclaredAttributes =
            [for(declaredAttribute in declaredAttributes)
                if(exists TagsAnnotation tagsAnnotation = annotations(`TagsAnnotation`, declaredAttribute.declaration),
                    tagsAnnotation.tags.contains(taggedVal))
                        declaredAttribute
            ];
    FieldType[] fields = [for(selectedByTagDeclaredAttribute in selectedByTagDeclaredAttributes)
            selectedByTagDeclaredAttribute.bind(containerObject).get()
    ];
    return fields;
}

