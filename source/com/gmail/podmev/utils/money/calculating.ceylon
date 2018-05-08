import ceylon.math.float {
    sqrt
}
"Выделение средств на нужды по количеству вклада в общуюю сумму умноженную остаток. обходим в порядке приоритета"
[<Aim->Integer>+] calculateParts1([Aim+] aims, Integer total) {
    assert(nonempty [Aim+] priotizedAims = sort(aims));
    value container = AimSumContainer(aims);
    Integer totalFinalSum = sum(aims*.finalSum);
    variable Integer restSum = total;

    while(true){
        for(priotizedAim in priotizedAims){
            value currentSum = (restSum*(priotizedAim.finalSum.float / totalFinalSum)).integer;
            if(currentSum < 1){
                container.addSum(priotizedAim, restSum);
                return [ for(aim in aims) aim->container.getSum(aim)];
            }
            container.addSum(priotizedAim, currentSum);
            restSum-=currentSum;
        }
    }
}

"первый приоритет получает n-частей, последний получает 1-часть, где n - количество категорий"
[<Aim->Integer>+] calculateParts2([Aim+] aims, Integer total) {
    assert(nonempty [Aim+] priotizedAims = sort(aims));
    value container = AimSumContainer(aims);
    Integer allParts = (aims.size*(aims.size+1))/2;
    variable Integer restSum = total;
    for(index->priotizedAim in priotizedAims.indexed){
        value currentSum = (total*((priotizedAims.size-index).float / allParts)).integer;
        container.addSum(priotizedAim, currentSum);
        restSum-=currentSum;
    }
    container.addSum(aims.first, restSum);
    return [ for(aim in aims) aim->container.getSum(aim)];
}

"первый приоритет получает [times]-частей, последний получает 1-часть"
[<Aim->Integer>+] calculateParts3(
        [Aim+] aims,
        Integer total,
        "firstToLastTimesDifference"
        Integer times) {
    assert(nonempty [Aim+] priotizedAims = sort(aims));
    value container = AimSumContainer(aims);
    Integer size = aims.size;
    assert(nonempty [Integer+] parts = timesParts(size, times));
    Integer allParts = sum(parts);
    variable Integer restSum = total;
    //обратно-приоритетный порядок
    for([priotizedAim, part] in zipPairs(priotizedAims.reversed, parts)){
        Integer currentSum = (total*(part.float / allParts)).integer;
        container.addSum(priotizedAim, currentSum);
        restSum-=currentSum;
    }
    container.addSum(aims.first, restSum);
    return [ for(aim in aims) aim->container.getSum(aim)];
}

"С учётом выделенных частей [[Aim.fixedPart]]
 первый приоритет получает [times]-частей, последний получает 1-часть"
[<Aim->Integer>+] calculateParts4(
        [Aim+] aims,
        Integer total,
        "firstToLastTimesDifference"
        Integer times) {
    Aim[] fixedPartAims = aims.select((aim)=>aim.fixedPart exists);
    "читаем чтоих не пусто"
    assert(nonempty [Aim+] notFixedPartAims = aims.select((aim)=>!aim.fixedPart exists));
    [<Aim->Integer>*] fixedAimsSum =
        [for(aim in fixedPartAims)
            aim->((total*(aim.fixedPart else 0.0)).integer)
        ];
    Integer totalFixedPart = sum{0, *fixedAimsSum*.item};
    assert (totalFixedPart<total);
    Integer totalRest = total-totalFixedPart;
    [<Aim->Integer>*] otherAimsSum = calculateParts3(notFixedPartAims, totalRest, times);
    assert (nonempty [<Aim->Integer>+] result = concatenate(fixedAimsSum, otherAimsSum));
    assert(sum(result*.item)==total);
    return result;
}

"раздаёт части так что первой достается в [[times]], чем последней"
[Integer*] timesParts(Integer size, Integer times) {
    Integer allParts = ((size * (size - 1) * (times + 1)) / 2);
    Integer diffPart = (times - 1);
    Integer initialPart = size-1;
    Integer[] res = [for (i in 0:size) initialPart + i*(diffPart)];
    assert(sum{0,*res}==allParts);
    return res;
}

[Integer*] sqrtParts(Integer size) =>
    timesParts(size, sqrt(size.float).integer)   ;


shared void runParts(){
//    print(parts(20, 4));
    for(i in 1..36) {
        print(i->sqrtParts(i));
    }
}
