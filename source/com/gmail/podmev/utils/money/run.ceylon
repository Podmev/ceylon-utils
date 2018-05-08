shared void run() {
    Integer moneyPerMonth = 113k;
    print("\n".join{for(aim->payPerMonth in calculateParts1(myRealAims, moneyPerMonth)) [aim, payPerMonth, monthsByPay(aim, payPerMonth)]});
    print("----");
    print("\n".join{for(aim->payPerMonth in calculateParts2(myRealAims, moneyPerMonth)) [aim, payPerMonth, monthsByPay(aim, payPerMonth)]});
    print("----");
    print("\n".join{for(aim->payPerMonth in calculateParts3(myRealAims, moneyPerMonth, 10)) [aim, payPerMonth, monthsByPay(aim, payPerMonth)]});
}

shared void run2() {
    Integer moneyPerMonth = 155k;
    print("\n".join{for(aim->payPerMonth in calculateParts1(myRealAims2, moneyPerMonth)) [aim, payPerMonth, monthsByPay(aim, payPerMonth)]});
    print("----");
    print("\n".join{for(aim->payPerMonth in calculateParts2(myRealAims2, moneyPerMonth)) [aim, payPerMonth, monthsByPay(aim, payPerMonth)]});
    print("----");
    print("\n".join{for(aim->payPerMonth in calculateParts3(myRealAims2, moneyPerMonth, 10)) [aim, payPerMonth, monthsByPay(aim, payPerMonth)]});
    print("----");
    print("\n".join{for(aim->payPerMonth in calculateParts4(myRealAims2, moneyPerMonth, 10)) [aim, payPerMonth, monthsByPay(aim, payPerMonth)]});
}