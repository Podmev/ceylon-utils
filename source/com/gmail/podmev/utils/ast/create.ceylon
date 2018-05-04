import ceylon.ast.core {
    PrimaryType,
    BaseType,
    TypeNameWithTypeArguments,
    UIdentifier
}
import ceylon.language.meta.declaration {
    InterfaceDeclaration
}
//TODO проверить
"Создаёт тип по декларации инетрфейса"
shared PrimaryType createPrivaryTypeFromInterfaceDeclaration(InterfaceDeclaration interfaceDeclaration)=>
        BaseType(TypeNameWithTypeArguments(UIdentifier(interfaceDeclaration.name)));
