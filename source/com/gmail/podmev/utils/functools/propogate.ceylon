
import ceylon.collection {
    ArrayList,
    MutableList
}

"Возвращает первую ошибку из stream'а, или же возвращает весь sequence, по этому стриму уже точно без ошибок.
 Ошибка здесь - просто тип, функция им параметризуется."
shared Element[]|ErrorType propagateFirstError<Element, ErrorType>({<Element|ErrorType>*} vals) {
    value seenElements = ArrayList<Element>();
    for (val in vals) {
        if (is Element val) {
            seenElements.add(val);
        }
        else {
            return val;
        }
    }
    return seenElements.sequence();
}
//TODO придумать название
"найти первую ошибку при преобразовании или выдать поток преобразованных значений вместе с оригинальным(в качестве [[Entry]])"
see(`function Iterable.map`)
shared <Element->Result>[]|ErrorType propagateMapFirstErrorAsEntry<Element, Result, ErrorType>(
        "входные значения"
        {<Element>*} vals,
        "метод преобразования из Element в Result или в ошибку ErrorType"
        Result|ErrorType transform(Element element))
        given Element satisfies Object{

    "преобразование вместе с оригинальными значениями"
    <<Element->Result>|ErrorType>(Element) transformWithKey = convertFuncWithKey<Element, Result, ErrorType> {
        func = transform;
    };
    return propagateFirstError<<Element->Result>,ErrorType> {
        vals = vals.map(transformWithKey);
    };
}

shared Element[]|ErrorType[] propagateAllErrors<Element, ErrorType>({Element|ErrorType*} vals) {
    MutableList<Element> elements = ArrayList<Element>();
    MutableList<ErrorType> errors = ArrayList<ErrorType>();
    vals.each((val) => if (is Element val) then elements.add(val) else errors.add(val));
    if (nonempty errseq = errors.sequence()) {
        return errseq;
    }
    return elements.sequence();
}
