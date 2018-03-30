import ceylon.collection {
    MutableMap,
    HashMap
}
class AimSumConatiner([Aim+] aims){
    MutableMap<Aim, Integer> sumsByAims = HashMap<Aim, Integer>{entries ={for (aim in aims) aim->0};};

    shared void addSum(Aim aim, Integer sum){
        assert(exists oldSum = sumsByAims[aim]);
        sumsByAims.put(aim, oldSum + sum);
    }

    shared Integer getSum(Aim aim){
        assert(exists sum = sumsByAims[aim]);
        return sum;
    }

    shared Integer allSum =>  sum{0, *sumsByAims.items};

}