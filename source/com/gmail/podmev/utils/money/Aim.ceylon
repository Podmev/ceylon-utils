shared class Aim(
        shared String englishDescription,
        shared String description,
        shared Integer finalSum,
        shared Integer basePriority
        ) satisfies Comparable<Aim>{

    shared actual Comparison compare(Aim other) =>
        orderedComparisons(other).find((e)=>e!=equal) else equal;

    shared {Comparison*} orderedComparisons(Aim other) =>
            {
                basePriority<=>other.basePriority,
                (finalSum<=>other.finalSum).reversed, //приоритетно с большей суммой
                description<=>other.description,
                englishDescription<=>other.englishDescription
            };



    shared actual Boolean equals(Object that) {
        if (is Aim that) {
            return englishDescription==that.englishDescription &&
                description==that.description &&
                finalSum==that.finalSum &&
                basePriority==that.basePriority;
        }
        else {
            return false;
        }
    }

    shared actual Integer hash {
        variable value hash = 1;
        hash = 31*hash + englishDescription.hash;
        hash = 31*hash + description.hash;
        hash = 31*hash + finalSum;
        hash = 31*hash + basePriority;
        return hash;
    }


    shared actual String string => "Aim(``englishDescription``, priority=``basePriority``, sum=``finalSum``)";
}