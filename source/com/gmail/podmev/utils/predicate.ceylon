//Работает не быстро - нужно переписать
shared Boolean(T) multiOr<T>(Boolean(T)* predicates) =>
        predicates.fold((T t)=>false)(or<T>);

shared Boolean(T) multiAnd<T>(Boolean(T)* predicates) =>
        predicates.fold((T t)=>true)(and<T>);
