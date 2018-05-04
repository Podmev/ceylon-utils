shared Boolean equalsWithNull (Anything one, Anything that) {
    if (exists one, exists that) {
        return one.equals(that);
    }
    return one exists == that exists;
}