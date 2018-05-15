import ceylon.test {
    assertAll,
    assertEquals,
    assertNotEquals,
    createTestRunner,
    test
}

import com.gmail.podmev.utils.reflection {
    MetaEqualable,
    fieldsInObject
}

see(`interface MetaEqualable`)
class MetaEqualableTest() {
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
    shared void positiveEqualsTest() =>
            assertAll(
                [
                    ()=>assertEquals(Person1(1,"abc", true), Person1(1,"abc", true))
                    ,()=>assertNotEquals(Person1(1,"abc", null), Person1(1,"abc", true))
                    ,()=>assertNotEquals(Person1(1,"abc", true), Person2(1,"abc",154.0, true))
                ]
            );

    test
    shared void positiveHashTest() =>
            assertAll(
                [
                            ()=>assertEquals(Person1(1,"abc", true).hash, Person1(1,"abc", true).hash),
                            ()=>assertNotEquals(Person1(1,"abc", null).hash, Person1(1,"abc", true).hash),
                            ()=>assertNotEquals(Person1(1,"abc", true).hash, Person2(1,"abc",154.0, true).hash)
                ]
            );

    test
    shared void positiveAllFieldsTest() =>
            assertAll(
                [
                    ()=>assertEquals(Person1(1, "abc", true).allFields, ["abc", true, 1]),
                    ()=>assertEquals(Person1(1, "abc", null).allFields, ["abc", null, 1]),
                    ()=>assertEquals(Person2(1, "abc", 154.0, null).allFields, ["abc", null, 1, 154.0])
                ]
            );
}

shared void runMetaEqualableTest() {
    print(createTestRunner([`MetaEqualableTest`]).run());
}