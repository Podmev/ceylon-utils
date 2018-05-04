import ceylon.language.meta.declaration {
    Module,
    ClassDeclaration,
    CallableConstructorDeclaration,
    Package,
    ValueConstructorDeclaration
}
import ceylon.language.meta.model {
    Interface,
    InvocationException
}
import ceylon.time {
    now
}
//TODO перенести в common
//TODO добавить методы для получения наследников абстрактного класса
//TODO добавить игнорирование абстрактных классов
"находит все реализации интерфейса [[targetInterface]] в модуле [[targetModule]] (проходит по всем пакетам модуля)
 и вызов в них дефолтного конструктора c параметрами [[args]]. В результате получаются инстансы интерфейса из пакета.
 По одному на каждую реализацию"
tagged("hasTests")
throws(`class InvocationException`, "если не получилось инстанциировать объекты")
shared [T*] implementationsWithArgsInModule<T>(
        Module targetModule,
        Interface<T> targetInterface,
        Anything* args) =>
        concatenate(
        for(curPackage in targetModule.members)
        implementationsWithArgsInPackage{
            args = args;
            targetInterface = targetInterface;
            targetPackage = curPackage;
        }
        );

"находит все реализации интерфейса [[targetInterface]] в пакете [[targetPackage]]
 и вызов в них дефолтного конструктора c параметрами [[args]]. В результате получаются инстансы интерфейса из пакета.
 По одному на каждую реализацию"
tagged("hasTests")
throws(`class InvocationException`, "если не получилось инстанциировать объекты")
shared [T*] implementationsWithArgsInPackage<T>(
        Package targetPackage,
        Interface<T> targetInterface,
        Anything* args) =>
        [for (declar in targetPackage.members<ClassDeclaration>())
            if (declar.satisfiedTypes.contains(targetInterface.declaration.openType),
                exists CallableConstructorDeclaration defaultConstructor = declar.defaultConstructor,
                is T obj = defaultConstructor.invoke([], *args)
                )
                    obj
        ];

"находит все реализаций интерфейса [[targetInterface]] в пакете [[targetPackage]]
 и вызов в них дефолтного конструктора c параметрами [[args]]. В результате получаются инстансы интерфейса из пакета.
 По одному на каждую реализацию"
tagged("hasTests")
throws(`class InvocationException`, "если не получилось инстанциировать объекты")
shared [T*] implementationsWithArgs<T>(
        Module|Package packageOrModule,
        Interface<T> targetInterface,
        Anything* args) =>
        [for(classDeclaration in classDeclarationsByInterface(packageOrModule, targetInterface))
            getImplementation<T>(classDeclaration, targetInterface, *args)
        ];

shared [ClassDeclaration*] classDeclarationsByInterface<T>(Module|Package packageOrModule, Interface<T> targetInterface)=>
    switch (packageOrModule)
    case (is Module) concatenate(for(curPackage in packageOrModule.members) classDeclarationsByInterface(curPackage, targetInterface))
    case (is Package) [for (classDeclaration in packageOrModule.members<ClassDeclaration>())
            if (classDeclaration.satisfiedTypes.contains(targetInterface.declaration.openType))
                classDeclaration
            ];


shared T getImplementation<T>(ClassDeclaration classDeclaration, Interface<T> targetInterface, Anything* args){
    if(exists CallableConstructorDeclaration defaultConstructor = classDeclaration.defaultConstructor){
        try{
           assert(is T obj = defaultConstructor.invoke([], *args));
           return obj;
        } catch (InvocationException e){
            throw e;
        } catch (Throwable e){
            //если сломалось пытамся запустить другие конструторы
            print(e.message);
            return getImplementationWithAnyConstructor(classDeclaration, targetInterface, *args);
        }
    }
    return getImplementationWithAnyConstructor(classDeclaration, targetInterface, *args);
}

shared T getImplementationWithAnyConstructor<T>(ClassDeclaration classDeclaration, Interface<T> targetInterface, Anything* args){
    value constructors = classDeclaration.constructorDeclarations();
    print("we hace ``constructors.size``");
    if(!nonempty constructors){
        throw InvocationException("No constructors");
    }
    for(constructor in constructors){
        print("processing constructor " + constructor.string);
        try {
            switch (constructor)
            case (is CallableConstructorDeclaration) {
                print(constructor.parameterDeclarations);
                assert(is T obj = constructor.invoke([], "fgf", "fgfg", now().dateTime()));
                return obj;
            }
            case (is ValueConstructorDeclaration) {
                if(!nonempty args){
                    assert(is T obj = constructor.get());
                    return obj;
                }
            }
        } catch(Throwable e){
            e.printStackTrace();
            continue;
        }
    }
    throw InvocationException("No good constructor for args");
}