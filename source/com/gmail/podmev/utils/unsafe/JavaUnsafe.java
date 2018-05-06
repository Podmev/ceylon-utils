package com.gmail.podmev.utils.unsafe;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/*
Механизм явного вызова приватного метода через рефлексию, небезопасный, ломает инкапсуляцию
*/
public class JavaUnsafe {
    public static <Entity> void invokeVoidPrivateMethod(Entity entity, String privateMethodName, Class<?>[] argTypes, Object ... args)
            throws InvocationTargetException, IllegalAccessException, NoSuchMethodException {
        Method privateMethod = entity.getClass().getDeclaredMethod(privateMethodName, String.class);
        privateMethod.setAccessible(true);
        privateMethod.invoke(entity, args);
    }
}
