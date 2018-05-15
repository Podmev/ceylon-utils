import ceylon.test {
    assertAll,
    assertEquals,
    createTestRunner,
    test
}

import com.gmail.podmev.utils.reflection {
    MetaEqualable,
    fieldsInObject
}
class FieldsInObjectTest() {
    class Person1(
            shared Integer age,
            shared String name,
            shared Boolean? married) satisfies MetaEqualable<Person1> {}

    class Person2(
            shared Integer age,
            shared String name,
            shared Float height,
            shared Boolean? married) satisfies MetaEqualable<Person2> {

    }

    test
    shared void positiveTest()=>
        assertAll(
            [
                ()=>assertEquals(fieldsInObject(Person1(1, "abc", true)), ["abc", true, 1]),
                ()=>assertEquals(fieldsInObject(Person1(1, "abc", null)), ["abc", null, 1]),
                ()=>assertEquals(fieldsInObject(Person2(1, "abc", 154.0, null)), ["abc", null, 1, 154.0])
            ]
        );
}

shared void runFieldsInObjectTest()=>
        print(createTestRunner([`FieldsInObjectTest`]).run());