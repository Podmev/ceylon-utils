"в случая успеха передавать в результат ключ
 Тоже самое

        shared
        <<Element->Result>|ErrorType>(Element)
        convertFuncWithKey2<Element,Result,ErrorType>
                (<Result|ErrorType>(Element) func)
                given Element satisfies Object {

            value newFunc = (Element element) {
                Result|ErrorType res = func(element);
                if (is ErrorType res){
                    return res;
                }
                return element->res;
            };
            return newFunc;
        }
 "
shared
<<Element->Result>|ErrorType>(Element)
convertFuncWithKey<Element,Result,ErrorType>
        (<Result|ErrorType>(Element) func)
        //given ExceptionType satisfies Exception
        given Element satisfies Object =>
        ((Element element) =>
        let(Result|ErrorType res = func(element))
        (if(is ErrorType res)
        then res
        else (element->res)));