"Композиция нескольких функций"
shared T(T) composeFunctions<T>({T(T)+} functions) given T satisfies Object =>
		functions.reduce(compose);
