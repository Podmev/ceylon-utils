[<Aim->Integer>+] calculateParts1([Aim+] aims, Integer total) {
    assert(nonempty [Aim+] priotizedAims = sort(aims));
    value container = AimSumConatiner(aims);
    Integer totalFinalSum = sum(aims*.finalSum);
    variable Integer restSum = total;

    while(true){
        for(priotizedAim in priotizedAims){
            value currentSum = (restSum*(priotizedAim.finalSum.float / totalFinalSum)).integer;
            if(currentSum < 1){
                container.addSum(priotizedAim, restSum);
                print(container.allSum);
                return [ for(aim in aims) aim->container.getSum(aim)];
            }
            container.addSum(priotizedAim, currentSum);
            restSum-=currentSum;
        }
    }
}

[<Aim->Integer>+] calculateParts2([Aim+] aims, Integer total) {
    assert(nonempty [Aim+] priotizedAims = sort(aims));
    value container = AimSumConatiner(aims);
    Integer allParts = (aims.size*(aims.size+1))/2;
    print(aims.size);
    print(allParts);
    variable Integer restSum = total;
    for(index->priotizedAim in priotizedAims.indexed){
        value currentSum = (total*((priotizedAims.size-index).float / allParts)).integer;
        container.addSum(priotizedAim, currentSum);
        restSum-=currentSum;
    }
    container.addSum(aims.first, restSum);
    print(container.allSum);
    return [ for(aim in aims) aim->container.getSum(aim)];
}
