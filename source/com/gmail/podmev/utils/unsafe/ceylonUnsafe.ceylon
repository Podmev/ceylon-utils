import ceylon.language.meta {
    type
}
import ceylon.language.meta.model {
    Type,
    ClassModel,
    Method,
    Attribute
}

import com.redhat.ceylon.compiler.java.metadata {
    method
}
shared object ceylonUnsafe {
    //TODO добавить обработки исключений
    //TODO обобщить копипасту
    "Вызов приватного или публичного метода [[methodName]] не возвращающего значения (void)
     (этот метод может быть определён только в данном классе, а не в предке)
     у объекта [[entity]] с генериками [[argTypes]] и параметрами [[args]]"
    see(`function ClassModel.getDeclaredMethod`)
    tagged("method", "declared", "void")
    shared void invokeDeclaredVoidMethod<ContainerType, Arguments>(
            ContainerType entity,
            String methodName,
            Type<>[] argTypes,
            Anything* args)
            given Arguments satisfies Anything[]{

        ClassModel<ContainerType,Nothing> classModel = type(entity);
        Method<ContainerType,Anything,Arguments>? method = classModel.getDeclaredMethod<ContainerType,Anything, Arguments> {
            name = methodName;
            types = argTypes;
        };
        assert (exists method);
        method(entity).apply(*args);
    }

    "Вызов приватного или публичного метода [[methodName]] не возвращающего значения (void)
     (этот метод может быть определён как в данном классе, так и в предке)
     у объекта [[entity]] с генериками [[argTypes]] и параметрами [[args]]"
    see(`function ClassModel.getMethod`)
    tagged("method", "void")
    shared void invokeVoidMethod<ContainerType, Arguments>(
            ContainerType entity,
            String methodName,
            Type<>[] argTypes,
            Anything* args)
            given Arguments satisfies Anything[]{

        ClassModel<ContainerType,Nothing> classModel = type(entity);
        Method<ContainerType,Anything,Arguments>? method = classModel.getMethod<ContainerType,Anything, Arguments> {
            name = methodName;
            types = argTypes;
        };
        assert (exists method);
        method(entity).apply(*args);
    }

    "Вызов приватного или публичного метода [[methodName]]
     (этот метод может быть определён только в данном классе, а не в предке)
     у объекта [[entity]] с генериками [[argTypes]] и параметрами [[args]]"
    see(`function ClassModel.getDeclaredMethod`)
    tagged("method", "declared")
    shared ReturnType invokeDeclaredMethod<ContainerType, ReturnType, Arguments>(
            ContainerType entity,
            String methodName,
            "Генерики метода"
            Type<>[] argTypes,
            Anything* args)
            given Arguments satisfies Anything[]{

        ClassModel<ContainerType,Nothing> classModel = type(entity);
        Method<ContainerType,ReturnType,Arguments>? method =
                classModel.getDeclaredMethod<ContainerType, ReturnType, Arguments> {
                    name = methodName;
                    types = argTypes;
                };
        assert (exists method);
        ReturnType result = method(entity).apply(*args);
        return result;
    }

    "Вызов приватного или публичного метода [[methodName]]
     (этот метод может быть определён как в данном классе, так и в предке)
     у объекта [[entity]] с генериками [[argTypes]] и параметрами [[args]]"
    see(`function ClassModel.getMethod`)
    tagged("method")
    shared ReturnType invokeMethod<ContainerType, ReturnType, Arguments>(
            ContainerType entity,
            String methodName,
            "Генерики метода"
            Type<>[] argTypes,
            Anything* args)
            given Arguments satisfies Anything[]{

        ClassModel<ContainerType,Nothing> classModel = type(entity);
        Method<ContainerType,ReturnType,Arguments>? method =
                classModel.getMethod<ContainerType, ReturnType, Arguments> {
                    name = methodName;
                    types = argTypes;
                };
        assert (exists method);
        ReturnType result = method(entity).apply(*args);
        return result;
    }

    "Достать значение атрибута(поля) [[attributeName]] (объявленного в данном классе) из объекта [[entity]]
     Внимание: Если поле приватное и нигде не используется, то оно не достанется
     "
    see(`function ClassModel.getDeclaredAttribute`)
    tagged("attribute", "declared", "getter")
    shared AttributeGetType getDeclaredAttribute<ContainerType, AttributeGetType, AttributeSetType=Nothing>(
            ContainerType entity,
            String attributeName){

        ClassModel<ContainerType,Nothing> classModel = type(entity);
        Attribute<ContainerType,AttributeGetType,AttributeSetType>? attribute =
                classModel.getDeclaredAttribute<ContainerType, AttributeGetType, AttributeSetType>(attributeName);
        assert (exists attribute);
        AttributeGetType result = attribute(entity).get();
        return result;
    }

    "Достать значение атрибута(поля) [[attributeName]] (объявленного в данном классе или предке) из объекта [[entity]]
     Внимание: Если поле приватное и нигде не используется, то оно не достанется"
    see(`function ClassModel.getAttribute`)
    tagged("attribute", "getter")
    shared AttributeGetType getAttribute<ContainerType, AttributeGetType, AttributeSetType=Nothing>(
            ContainerType entity,
            String attributeName){

        ClassModel<ContainerType,Nothing> classModel = type(entity);
        Attribute<ContainerType,AttributeGetType,AttributeSetType>? attribute =
                classModel.getAttribute<ContainerType, AttributeGetType, AttributeSetType>(attributeName);
        assert (exists attribute);
        AttributeGetType result = attribute(entity).get();
        return result;
    }

    //TODO можно написать сеттеры
}

class A(){
    String s = "123";
    void foo() {
        print("private```s``");
    }

    void foo2(Integer i) {
        print("private ``i``");
    }

    Integer bar(Integer a, String c){
        return c.size+a;
    }
}

shared void runCeylonUnsafe(){
    A a = A();
//    ceylonUnsafe.invokeDeclaredVoidMethod(a, "foo", []);
//    ceylonUnsafe.invokeDeclaredVoidMethod(a, "foo2", [], 1);
//    print(ceylonUnsafe.invokeDeclaredMethod<A,Integer,[Integer,String]>(a, "bar", [], 2, "123"));
    print(ceylonUnsafe.getDeclaredAttribute<A, String>(a, "s"));
}