shared void run() {
    Integer moneyPerMonth = 113k;
    print("\n".join{for(aim->payPerMonth in calculateParts1(myRealAims, moneyPerMonth)) [aim, payPerMonth, monthsByPay(aim, payPerMonth)]});
    print("----");
    print("\n".join{for(aim->payPerMonth in calculateParts2(myRealAims, moneyPerMonth)) [aim, payPerMonth, monthsByPay(aim, payPerMonth)]});
    print("----");
    print("\n".join{for(aim->payPerMonth in calculateParts3(myRealAims, moneyPerMonth, 10)) [aim, payPerMonth, monthsByPay(aim, payPerMonth)]});
}