"Several transformation fuction composition"
shared T(T) composeFunctions<T>({T(T)+} functions) given T satisfies Object =>
		functions.reduce(compose);
shared class Route() {}

interface Heuristic {
	shared formal [Route+] improve([Route+] routes);
}

object twoOptHeuristic satisfies Heuristic {
	improve([Route+] routes) => routes.reversed;
}

object threeOptHeuristic satisfies Heuristic {
	improve([Route+] routes) => routes.reversed;
}

object i2Heuristic satisfies Heuristic {
	improve([Route+] routes) => routes.reversed;
}

object exchangeSubsetsHeuristic satisfies Heuristic {
	improve([Route+] routes) => routes.reversed;
}

Heuristic parseHeuristicName(String name) =>
		switch (name)
	case ("twoOptHeuristic") twoOptHeuristic
	case ("i2Heuristic") i2Heuristic
	case ("threeOptHeuristic") threeOptHeuristic
	case ("exchangeSubsetsHeuristic") exchangeSubsetsHeuristic
	else nothing; //TODO log and use default maybe

object configAD{
	shared [String+] heuristicNames = ["twoOptHeuristic", "i2Heuristic", "threeOptHeuristic", "exchangeSubsetsHeuristic", "i2Heuristic"]; //TODO move to config
}

"composed heuristic from config"
object composedHeuristic satisfies Heuristic {
	[Heuristic+] heuristics = configAD.heuristicNames.collect(parseHeuristicName);
	[[Route+]([Route+])+] heuristicFunctions = heuristics.collect((heuristic)=>heuristic.improve);
	[Route+]([Route+]) composedFunction = composeFunctions(heuristicFunctions);
	
	shared actual [Route+] improve([Route+] routes) => composedFunction(routes);
}

shared void run1() {
		
	
}
