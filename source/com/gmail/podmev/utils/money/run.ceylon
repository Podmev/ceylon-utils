shared void run() {
    Integer moneyPerMonth = 115k;
    print("\n".join{for(aim->payPerMonth in calculateParts1(myRealAims, moneyPerMonth)) [aim, payPerMonth, monthsByPay(aim, payPerMonth)]});
    print("----");
    print("\n".join{for(aim->payPerMonth in calculateParts2(myRealAims, moneyPerMonth)) [aim, payPerMonth, monthsByPay(aim, payPerMonth)]});
}