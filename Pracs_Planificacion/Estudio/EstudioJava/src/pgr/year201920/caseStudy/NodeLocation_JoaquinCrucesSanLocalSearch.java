package pgr.year201920.caseStudy;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;
import java.util.SortedSet;

import com.net2plan.interfaces.networkDesign.IAlgorithm;
import com.net2plan.interfaces.networkDesign.Link;
import com.net2plan.interfaces.networkDesign.Net2PlanException;
import com.net2plan.interfaces.networkDesign.NetPlan;
import com.net2plan.interfaces.networkDesign.Node;
import com.net2plan.utils.Pair;
import com.net2plan.utils.Triple;
/* See in this template recommendations for a well structured code:
 * 
 * NAMES OF CLASSES AND VARIABLES: 
 * 1) Java best practices mandate that classes start with capital letters (e.g. NodeLocation_TEMPLATE), while variable names start with lowercase letters.
 * 2) Variable and class names can be long. They are recommended to express in its name, exactly what they do, 
 * e.g. a name like 'numberOfAccessNodesConnectedToThisLocation' is preferred to 'n'.
 * 3) Use the so-called CAMEL CASE for the class and variable names: writing phrases such that each word or abbreviation in the middle of the 
 * phrase begins with a capital letter, with no intervening spaces or punctuation. E.g. numberOfAccessNodesConnectedToThisLocation. In Java it is less common 
 * to use underscore (e.g. number_of_access_nodes_connected_to_this_location is not within best practices in Java naming conventions) 
 * 4) It is in general accepted that global constants that are very heavily used, can be an exception to the Java naming conventions, using short (1 letter or two) variable names in capital letters. 
 * In this template, constants M and C are used in that form. Some people accept as a good practice also long constant names, all upercase letters, and words separated with underscore (e.g MAX_NUMBER_CONNECTED_ACCESS_NODES).
 * 
 * VARIABLES THAT ARE CONSTANTS:
 * - Use the "final" keyword when a created variable is actually a constant that will not change during its existence in the code. This informs 
 * other developers looking t your code that they are constants, and makes the code more readable (additionally, the Java compiler can make some optimizations that can make your code to be a little bit faster)
 * 
 * USE LESS LINES OF CODE:
 * - A code that makes the job with less lines of code, is more readable, simpler to maintain, better. This can be achieved by structuring the code well. 
 * Also, by re-using the built-in libraries that Java provides, instead of writing ourselves a code for simple things that typically are already implemented there. 
 * Reusing code of these libraries is always better than "re-invent the wheel", coding again what is already there. E.g. use intelligently the 
 * functionalities of the List, Set and Map containers of Java:
 * - A Java List (of type ArrayList, LinkedList,...) is an ordered sequence of elements, same element can appear more than once.
 * - A Java Set (a HashSet, a TreeSet...) is an unordered set of elements, if any element is added twice, the second addition is ignored
 * - A Java Map (HashMap, TreeMap,...) is a set of entries [key , value]. When adding two entries with the same key, the last removes any previous one.   
 * 
 * COMMENTING THE CODE:
 * - By using a structured code, with expressive variable names, your code can be read "like a book". Therefore, it should not need many comments. 
 * Just add the right amount of comments. For this, google "best practices commenting code" and read a bit
 * 
 * REFACTORING:
 * - Use Eclipse options for code refactoring. Read about this NOW!! (e.g https://www.baeldung.com/eclipse-refactoring).
 *  The more you use these options, the more time you save. This saves tons of time. No serious coding can be done without this.
 *  
 * INDENTATION AND CODE FORMATTING:
 * - Eclipse (and other IDEs) provide powerful tools to reindent and reformat the code, so it follows Java conventions. USE THEM! READ NOW ABOUT THEM!
 * (e.g. Google "eclipse java code formatting"). No serious coding can be done without this.
 * 
 * FINAL LEMMA, THE BEST ADVICE I CAN GIVE: There are different opinions on how a well-structured code is, well documented, etc etc. 
 * You are encouraged to read about this in Internet sources, and accept what experienced programmers suggest about this. Please, also 
 * read about what your IDE (e.g. Eclipse) can make for you, to make your life simpler, your code better. Will save you TONS of time. 
 * 
 * 
 * 
 * */



/** This is a template for the students, with an skeleton for solving the node location problem of the use case 2019-20.
 */
public class NodeLocation_JoaquinCrucesSanLocalSearch implements IAlgorithm
{

	@Override
	public String executeAlgorithm(NetPlan np, Map<String, String> algorithmParams, Map<String, String> n2pParams)
	{
		/* Initialize algorithm parameters  */
		final int M = Integer.parseInt(algorithmParams.get("M"));
		final double C = Double.parseDouble(algorithmParams.get("C"));
		final double maxExecTimeSecs = Double.parseDouble(algorithmParams.get("maxExecTimeSecs"));
		final int debugMode = Integer.parseInt(algorithmParams.get("debugMode"));
		double costBestSolutionReachedByDev = Double.parseDouble(algorithmParams.get("costBestSolutionReachedByDev")); 
		
		final long algorithmStartTime = System.nanoTime();
		
		
		int N = np.getNumberOfNodes(); 
		
		// Some parameters for the SAN Algorithm. Depends of the number of nodes present 
		/*final int san_numOuterIterations = N*N;
		final int san_numInnerIterations = 2*N+N;*/
		
		final int san_numOuterIterations = 3000;
		final int san_numInnerIterations = 2*N;
		
		final int san_maxFrozenIteations=  (int) (san_numOuterIterations*san_numInnerIterations*0.015);
		
		
		
		np.removeAllLinks(); // remove all links of the input design
		
		/* Typically, the algorithm stores the best solution find so far, 
		 * which is the one to return when the running time reaches the user-defined limit */
		NetPlan bestSolutioFoundByTheAlgorithm = np.copy(); // Working with a copy of the design
		double costBestSolutionFoundByTheAlgorithm = Double.MAX_VALUE;

		/* Students code go here. It should leave the best solution found in the variable: bestSolutioFoundByTheAlgorithm */
		
		// Other useful parameters
		
		int maxHeatingAttempts=2; // Number of heatting attemps at SAN befor try another iteration of the main loop 
		double runningTimeInSeconds = (System.nanoTime() - algorithmStartTime) / 1e9; 
		
		int iterations=0;
		while (runningTimeInSeconds<maxExecTimeSecs) {
			iterations++;
			
			/* Throughout the code, the algorithm will use a Random object for shuffle the node lists*/
			Random rnd = new Random();
			NetPlan npInitial = np.copy();
			
			if((debugMode==1) || (debugMode==2)){
				System.out.println("Starting iteration number "+iterations+". Coste de inicio "+costBestSolutionFoundByTheAlgorithm+". Tiempo ejecucion"+runningTimeInSeconds);
			}
			 
			/*1. Find a full random initial solution. It is an access point for the next steps of the algorithm that needs am initial solution*/
			npInitial=getInitialSolution(npInitial, rnd);			
			double costByInitialSolution=evaluateDesign(npInitial, M, C).getFirst();
			
			if((debugMode==1) || (debugMode==2)){
				System.out.println("Initial solution at iteration number "+iterations+":"+costByInitialSolution);
			}
			
			// It is difficult but maybe a full-random solution is the best, lets check
			if(costByInitialSolution<costBestSolutionFoundByTheAlgorithm) {
				bestSolutioFoundByTheAlgorithm=npInitial.copy();
				costBestSolutionFoundByTheAlgorithm=costByInitialSolution;
				
				if((debugMode==1) || (debugMode==2)){
					System.out.println("Cost improved by the initial solution at iteration number "+iterations+". New best cost "+costBestSolutionFoundByTheAlgorithm);
				}
			}
			
			// Usually, we are going to have a very heavy cost from the initial solution. Local Search is a quick algorithm that gives a good starting point for SAN
			NetPlan npLocalSearch =  localSearchFirstFit(costByInitialSolution, rnd, npInitial, M, C, debugMode);
			double costByLocalSearch=evaluateDesign(npLocalSearch, M, C).getFirst();
			
			// Let see if LocalSeach improves our best cost solution (it will happens specially al first iteration)
			if(costByLocalSearch<costBestSolutionFoundByTheAlgorithm) {
				bestSolutioFoundByTheAlgorithm=npLocalSearch.copy();
				costBestSolutionFoundByTheAlgorithm=costByLocalSearch;
				
				if((debugMode==1) || (debugMode==2)){
					System.out.println("Best Solution improved by LocalSearch at iteration number "+iterations+". New cost: "+costBestSolutionFoundByTheAlgorithm);
				}
			}
			
			// 2. Once we have an starting point, SAN Algorithm will take over the problem intensification phase. 
			rnd = new Random();
			NetPlan sanNp = simulatedAnnealingAlgorithm (san_numOuterIterations, san_numInnerIterations, san_maxFrozenIteations, npLocalSearch, costByLocalSearch, costBestSolutionFoundByTheAlgorithm, rnd, M, C, maxHeatingAttempts, algorithmStartTime, maxExecTimeSecs, debugMode );
			double costBySAN=evaluateDesign(sanNp, M, C).getFirst();
			
			if(costBySAN<costBestSolutionFoundByTheAlgorithm) {
				bestSolutioFoundByTheAlgorithm=sanNp.copy();
				costBestSolutionFoundByTheAlgorithm=costBySAN;
				
				if((debugMode==1) || (debugMode==2)){
					System.out.println("Best Solution improved by Simulated Anniding al iteration number "+iterations+". New cost: "+costBestSolutionFoundByTheAlgorithm);
				}				
			}
			
			runningTimeInSeconds = (System.nanoTime() - algorithmStartTime) / 1e9;
			/* If debug enabled, lets report about this iteration */
			if((debugMode==1) || (debugMode==2)){
				Pair <Double, Integer> iterationEvaluale = evaluateDesign(bestSolutioFoundByTheAlgorithm, M, C);
				System.out.println("End of iteration number "+iterations+". Current cost: "+iterationEvaluale.getFirst()+". Number of corenodes: "+iterationEvaluale.getSecond());
				System.out.println("Running time: "+runningTimeInSeconds+" seconds");
				System.out.println();
				System.out.println();
			}	
			
			if (runningTimeInSeconds>=maxExecTimeSecs) break;
			
		} // End of the main loop
		
		double differenceBetweenCosts =0.0;
		if(costBestSolutionReachedByDev!=0) {
			differenceBetweenCosts = ((1-(costBestSolutionFoundByTheAlgorithm/costBestSolutionReachedByDev))*100);
		}
		else {
			differenceBetweenCosts=Double.MAX_VALUE;
		}
		
				
		/* Return the solution in bestSolutioFoundByTheAlgorithm */
		final double totalRunningTimeInSeconds = (System.nanoTime() - algorithmStartTime) / 1e9;
		np.assignFrom(bestSolutioFoundByTheAlgorithm); // this line is for storing in the np variable (the design to return), the best solution found 
		final Pair<Double,Integer> returnedDesignInfo = evaluateDesign(np, M, C); // compute the cost and number of core nodes, to return it, and check the design validity
		final double returnedDesignCost = returnedDesignInfo.getFirst();
		final int returnedDesignNumCoreNodes = returnedDesignInfo.getSecond();
		if (returnedDesignCost == Double.MAX_VALUE)
			return "Wrong solution. Does not pass the validation";
		else
			if(differenceBetweenCosts!=0.0) {
				if(differenceBetweenCosts>=0) {
					return "Ok. Cost: " + returnedDesignCost + ". Num core nodes: " + returnedDesignNumCoreNodes + ". Total running time (seconds): " + totalRunningTimeInSeconds+ ". Your solution is : " + differenceBetweenCosts+"% better than the best ever reached";
				}
				else {
					differenceBetweenCosts=Math.abs(differenceBetweenCosts);
					return "Ok. Cost: " + returnedDesignCost + ". Num core nodes: " + returnedDesignNumCoreNodes + ". Total running time (seconds): " + totalRunningTimeInSeconds+ ". Your solution is : " + differenceBetweenCosts+"% worse than the best ever reached";
				}
			}
			else {
				return "Ok. Cost: " + returnedDesignCost + ". Num core nodes: " + returnedDesignNumCoreNodes + ". Total running time (seconds): " + totalRunningTimeInSeconds;
			}
			
	}

	/** Help function to evaluate the validity of a design (returns a cost of Double.MAX_VALUE if not valid)
	 * Returns a pair of two numbers: 
	 * 1) the total network cost, 
	 * 2) the total number of core nodes in the design (this information may help the algorithm to make decisions).
	 * IMPORTANT: If the design violates the constraints: every access node is not connected to two core nodes, it returns a cost of Double.MAX_VALUE */
	public static Pair<Double,Integer> evaluateDesign (NetPlan np , int M , double C)
	{
		int numCoreNodes = 0;
		double totalDistanceOfAccessLinks = 0;
		for (Node location : np.getNodes())
		{
			final SortedSet<Link> outgoingAccessLinks = location.getOutgoingLinks();
			if (outgoingAccessLinks.size() > 2) 
			{
				System.out.println("Wrong design. A location " + location + " cannot have more than two outgoing links, since this would mean an access node connected to more than two core nodes");
				return Pair.of(Double.MAX_VALUE, 0);
			}
			if (outgoingAccessLinks.size() == 0)
			{
				System.out.println("Wrong design. A location "+ location + " cannot have zero outgoing links, since this would mean an access node connected to only one core node");
				return Pair.of(Double.MAX_VALUE, 0);
			}
			if (outgoingAccessLinks.size() == 2) 
			{
				if (outgoingAccessLinks.first().getDestinationNode().equals(outgoingAccessLinks.last().getDestinationNode()))
				{
					System.out.println("Wrong design. A location " + location + " cannot be connected twice to the same location: the connected core nodes must be in different locations");
					return Pair.of(Double.MAX_VALUE, 0);
				}
			}
			final boolean theAccessNodeInThisLocationIsConnectedToThisLocation = (outgoingAccessLinks.size() == 1);
			final int numAccessNodesConnectedToThisLocationCoreNodes = location.getIncomingLinks().size() + (theAccessNodeInThisLocationIsConnectedToThisLocation ? 1 : 0);
			final int numCoreNodesThisLocation = (int) Math.ceil(((double) numAccessNodesConnectedToThisLocationCoreNodes) / (double) M);
			numCoreNodes += numCoreNodesThisLocation;
			for (Link outLink : outgoingAccessLinks)
				totalDistanceOfAccessLinks += getCostAccessLink (outLink);
		}
		final double networkTotalCost = C * numCoreNodes +  totalDistanceOfAccessLinks;
		//System.out.println ("Evaluation - Total network cost: " + networkTotalCost + ". Num core nodes: " + numCoreNodes + " (cost core nodes: " + (C * numCoreNodes) + "). Total distance access links: " + totalDistanceOfAccessLinks);
		return Pair.of(networkTotalCost , numCoreNodes);
	}
	
	
	/** Help function to compute the cost of an access link from its end locations */
	private static double getCostAccessLink (Node a , Node b)
	{
		return a.getNetPlan().getNodePairEuclideanDistance(a, b);
	}
	/** Help function to compute the cost of an access link between two locations  */
	private static double getCostAccessLink (Link link)
	{
		return link.getNetPlan().getNodePairEuclideanDistance(link.getOriginNode(), link.getDestinationNode());
	}
	
	@Override
	public String getDescription() 
	{
		return "This Algorithm is for the study case o June 2020. Developed by Joaquin Cruces Adrados and Manuel Paredez Ruiz - Planificacion y Gestion de Redes. Best result reached found a topology with 21 core nodes and 3115.8813060624307 of cost. As an Heuristic algorithm execution time offer more attempts to get a better solution (more random iterations)";
	}

	@Override
	public List<Triple<String, String, String>> getParameters() 
	{
		final List<Triple<String, String, String>> res = new ArrayList<> ();
		res.add(Triple.of("M", "5", "Maximum number of access nodes that can be connceted to a single core node."));
		res.add(Triple.of("C", "100", "The cost of a core node."));
		res.add(Triple.of("maxExecTimeSecs", "60", "Maximum running time of the algorithm."));
		res.add(Triple.of("debugMode", "0", "Debug mode will show some information about he advance of the algorithm. Showing messagess needs time, please reconsider maxExecTimeSecs value if enabled. 0 --> Disabled, 1-->Short-Enabled, 2-->Verbouse. Other values are considered as Disabled"));
		res.add(Triple.of("costBestSolutionReachedByDev", "3115.8813060624307", "If != 0 will compare the cost with your best cost. By default, the best cost for C=100, M=5 (reached after 270 secs)"));

		return res;
	}

	/**
	 * Help function for create links over the algorithms. Requires two nodes in the same NetPlan
	 * @param accessNodeLocation: Node access of NP topology
	 * @param coreNodeLocation: Node from NP that acts as core node
	 * @return Optional<link> Empty if cannot add a link or a link between accessNodeLocation and coreNodeLocation
	 */
	private Optional<Link> addLink (Node accessNodeLocation, Node coreNodeLocation) {
		
		// Defensive: Check that the two nodes comes from the same netPlan Object
		final NetPlan thisNetPlan = accessNodeLocation.getNetPlan();
		
		if(!thisNetPlan.equals(coreNodeLocation.getNetPlan())) {
			throw new Net2PlanException("Cannot add link. Diferent NetPlan Objets at nodes");
		}
		
		// Check that the two nodes are not the same nodes
		if(accessNodeLocation.equals(coreNodeLocation)) {
			return Optional.empty(); // Not returns null, only empty
		}
		
		// If we are here, no exceptions shown, lets create the link
		final Link createdLink = thisNetPlan.addLink(accessNodeLocation, coreNodeLocation, 1, 1, 200000, null);
		return Optional.of(createdLink);
		
	}
	
	/**
	 * @param nodePair: Pair objects of nodes
	 * @param rnd: Random Object
	 * @return Node: A random Node selected between the two nodes os nodePair
	 */
	private Node getRandomNodeOfPair (Pair<Node, Node> nodePair, Random rnd) {
		
		int throwTheCoin = rnd.nextInt(100); // Gets integer between 0 and 99 (percent of prob)
		
		if(throwTheCoin<50) {
			return nodePair.getFirst();
		}
		else {
			return nodePair.getSecond();
		}
		
	}
	
	
	/**
	 * Simulated annealing criteria for accept (true) or dismiss (false) a given solution that do not improve the Algorithm solution
	 * @param current_cost
	 * @param new_cost
	 * @param temperature
	 * @param rnd
	 * @return
	 */
	private static boolean acceptSolution(double current_cost, double new_cost, double temperature, Random rnd)
	{
		if (new_cost < current_cost) return true;

		final double probThreshold = Math.exp(-(new_cost - current_cost) / temperature);
		return rnd.nextDouble() < probThreshold;
	}
	


	/**
	 * This function is a Simulated Annealing Algorith implementation that combines
	 * SAN philosophy with adaptative algorithms. The idea is implement SAN as a
	 * part of the main algorithm and as an intermedium part between full-random
	 * solution (diversification) and intensification. This implementation starts
	 * from a solution and trys to improve it quickly. If the algorithm is frozen,
	 * heating maxHeatingAttempts times or ends. But, adaptative instructions can adapt
	 * (increase) maxHeatingAttempts if the algorithm is having success and finding good
	 * solutions (intensify the search). As an intensification part, it have a local 
	 * search implementation that, having a better solution, trys to find another better 
	 * between the neighbors
	 * 
	 * @param san_numOuterIterations: SAN outer loop iterations
	 * @param san_numInnerIterations: SAN inner loop iterations
	 * @param san_maxFrozenIteations: Number of iterations for consider that SAN is Frozen
	 * @param sanNp: Net2Plan object on which the algorithm is applied
	 * @param costBestSolutionFoundByTheAlgorithm: Best solution reached on this iteration of the main loop algorith
	 * @param costBestSolution: Best solution reached in all of the iterations
	 * @param rnd: Random Object
	 * @param M: M Value (algorithm parameter)
	 * @param C: C Value (algorithm parameter)
	 * @param maxHeatingAttempts: Max heating attempts before leave the function. Can be modified by adaptative operations
	 * @param algorithmStartTime: Time of start 
	 * @param maxExecTimeSecs: Max time execution 
	 * @param debugMode: (algorithm parameter) 
	 * @return
	 */
	private NetPlan simulatedAnnealingAlgorithm (int san_numOuterIterations, int san_numInnerIterations, int san_maxFrozenIteations, NetPlan sanNp, double costBestSolutionFoundByTheAlgorithm, double costBestSolution, Random rnd, int M, double C, double maxHeatingAttempts, long algorithmStartTime, double maxExecTimeSecs, int debugMode ) {
		
		// Need to preserve original object that will be returned
		NetPlan copyOfnp = sanNp.copy();
		double limitOfMaxHeatingIncrement = 3*maxHeatingAttempts;
		int numberOfHittsWithTheSameCost=0;
		double lastCostCausedHitt=0.0;
	
		int N = sanNp.getNumberOfNodes();
		
		// SAN Temperatures. Based on OSPF weighs problem and adapted for this case 
		
		final double san_initialTemperature = -((0.05/500)*C*M) / Math.log(0.99);
		final double san_finalTemperature = -((0.05/500)*C*M) / Math.log(0.0015);
		/* Alpha factor so that starting in the initial temp, after exactly san_numOuterIterations we have a temperature equal to the final temp  */
		/* In each outer iteration, the new temperature t(i+1) = alpha*t(i) */
		final double san_alpha = Math.pow(san_finalTemperature / san_initialTemperature, 1.0 / (san_numOuterIterations - 1)); // Same schema as OSPF (empirical)
		
		// We have jet the initial solution, so do not create again. If not, please insert it
		
		double temp = san_initialTemperature; // Set the initial temperature 
		
		// As we can assume possible worse solutions, we are going to work with a copy of the original NP object
		
		
		double costSolutionFoundBySan = costBestSolutionFoundByTheAlgorithm;
		int FrozenIterations=0;
		for (int outerItCount = 0; outerItCount<san_numOuterIterations; outerItCount++) { // Outer SAN Loop
			
			for (int innerItCount = 0; innerItCount<san_numInnerIterations; innerItCount++) { // Inner SAN Loop
				
				/*
				 * SAN's inner loops represents a local iteration with a prob. of assume worse costs. As higher is the temperature, more random
				 * Over an iteration inside the inner loop, temperature is constant,
				 */
				
				// Find random neighbor
				
				// Get and shuffle the node list
				List <Node> shuffledNodes = new ArrayList<> (copyOfnp.getNodes());
				Collections.shuffle(shuffledNodes, rnd); 
				
				int thisNodeIndex=rnd.nextInt(N); // Remember N declared for the initial solution, is number of total nodes
				Node sanNodeAccessEvaluation = shuffledNodes.get(thisNodeIndex);
				
				// Lets Construct our neighbor solution
								
				// Just need to change one of the links so make an array with them and try
				
				final Node firstOriginalCoreLocation = sanNodeAccessEvaluation.getOutgoingLinks().first().getDestinationNode(); // getOutgoingLinks() devuelve un shortedSet, cojo el primero.
				final Node secondOriginalCoreLocation = sanNodeAccessEvaluation.getOutgoingLinks().size()==1 ? sanNodeAccessEvaluation : sanNodeAccessEvaluation.getOutgoingLinks().last().getDestinationNode();

				Pair <Node, Node> pairOfOriginalNodeLocation = Pair.of(firstOriginalCoreLocation, secondOriginalCoreLocation);
				Node originalCoreLocation = getRandomNodeOfPair (pairOfOriginalNodeLocation, rnd);
				
				// Now we have our two nodes, lets check the link
				final boolean isSelfLink =  sanNodeAccessEvaluation.equals(originalCoreLocation); // If sanNodeAccessEvaluation = originalCoreLocation , it is a self Link
				final Optional<Link> linkToRemove = isSelfLink ? Optional.empty() : Optional.of(copyOfnp.getNodePairLinks(sanNodeAccessEvaluation, originalCoreLocation, false).first());
				if (linkToRemove.isPresent()) linkToRemove.get().remove(); // If it is not a self link, remove it. 
				
				// Make a new valid combination of nodes
				boolean isValidCombination = false;
				Node newCoreNode = originalCoreLocation; // just for avoid problems
				while (!isValidCombination) {
					isValidCombination=true; // Prevent infinite loops
					// Get the nodeList, shuffled again, and choose one random node
					List <Node> shuffledCoreNodes = new ArrayList<> (shuffledNodes); // For fun, lets shuffle a shuffled list (random level ++)
					Collections.shuffle(shuffledCoreNodes, rnd); 
					
					// Get a random node from the randomized random list of nodes
					int newCoreNodeIndex=rnd.nextInt(N);
					newCoreNode = shuffledCoreNodes.get(newCoreNodeIndex);
					
					// Some rules... we cannot use the original nodes!!
					if (newCoreNode.equals(firstOriginalCoreLocation) || newCoreNode.equals(secondOriginalCoreLocation)) {
						isValidCombination=false;
					}
				}
				
				// Here we have our winner couple!! Lets check the results:
				final Optional<Link> newLinkCreated = addLink(sanNodeAccessEvaluation, newCoreNode); // add a new link			
				final double costNeighborSolution = evaluateDesign(copyOfnp, M, C).getFirst(); // find the costs 
							
				// Is better than out best solution??
				if(costNeighborSolution<costSolutionFoundBySan) {
					costSolutionFoundBySan=costNeighborSolution; // Update costs 
					if(costSolutionFoundBySan<costBestSolutionFoundByTheAlgorithm) {
						// If is better than our better solution, update the Net2Plan Object
						sanNp=copyOfnp.copy();
						costBestSolutionFoundByTheAlgorithm=costSolutionFoundBySan;
						FrozenIterations=0; // As we have improved the solution, restart the counter
						continue; 
					}
				}
				else {
					FrozenIterations++;
					// Need to check if it is an accepted solution for jump
					boolean isAnAcceptedSolution = acceptSolution(costSolutionFoundBySan, costNeighborSolution, temp, rnd);
					
					if(isAnAcceptedSolution) {
						costSolutionFoundBySan=costNeighborSolution; // Update the cost, even is worse
						// No changes needed over the copy of NP
						continue;
					}
					
					// Else we do not agree with the solution, so need to undo the steps
					
					if(newLinkCreated.isPresent()) newLinkCreated.get().remove(); // remove the created link
					addLink(sanNodeAccessEvaluation, originalCoreLocation); // create again the original link
					
				}				
			} // End of the inner loop
			
			/*
			 * Once the inner loop have finished, we will have a solution, maby better, that can be improved by 
			 * increasing the seach with neighbords solutions, so use Local Search as a full-intensification operation
			 */
			
			NetPlan npLocalSeach=localSearchFirstFit(costBestSolutionFoundByTheAlgorithm, rnd, copyOfnp, M, C, debugMode);
			double costLocalSearchSolution = evaluateDesign(npLocalSeach, M, C).getFirst(); // find the costs 
			
			//This is our adaptative implementation. Local Search result is, at least, as good as the input, but if LS improves, maby we shuld give the 
			// operations a chance. 
			if(costLocalSearchSolution<costSolutionFoundBySan) {
				// 1. If Local Search improves SAN, lets save the results
				costSolutionFoundBySan=costLocalSearchSolution;
				copyOfnp=npLocalSeach.copy();
				
				// If we are working in the good way:
				if(costLocalSearchSolution<=costBestSolutionFoundByTheAlgorithm) {
					// Agree the solution as an improvement of the algorithm
					costBestSolutionFoundByTheAlgorithm=costLocalSearchSolution;
					sanNp=npLocalSeach.copy();
					
					// Need to control the max attempts because it can kill the random component of the global algorithm. Max 4*maxHeatingAttempts
					// The adaptation weights the margin given based on the general benefit of the algorithm
					if(maxHeatingAttempts<limitOfMaxHeatingIncrement) {
						if(costLocalSearchSolution<costBestSolution) {
							// If our working line improves the global solution, we have to intensificate the local actions.
							maxHeatingAttempts+=0.66; // More intensive, maybe we have a good option here
							san_maxFrozenIteations=(int) (san_maxFrozenIteations+san_maxFrozenIteations*0.030);
							costBestSolution=costLocalSearchSolution;
						}
						else {
							// If not improves the global solution but improves the local solution, there is a chance of finish improving the global solution
							// so lets give a chance but thinner than if it is improving the global solution.
							maxHeatingAttempts+=0.33; // More incisive, maybe we have a good option here
							san_maxFrozenIteations=(int) (san_maxFrozenIteations+san_maxFrozenIteations*0.015);
						}
						
						if(debugMode==2) { //Verbouse
							final double runningTimeInSeconds = (System.nanoTime() - algorithmStartTime) / 1e9;
							System.out.println("--- Values updated according to an improvement. maxHeatingAttempts: "+maxHeatingAttempts+". Max Frozen Iterations: "+san_maxFrozenIteations+" execution time: "+runningTimeInSeconds+" secs");
							System.out.println("--- Current cost value: "+costLocalSearchSolution);
						}
						
					}
					
					FrozenIterations=0;
				}
			}
			
			/* Finally, for each inner iteration, need to update the temperature according to SANs procedure an the limits of adaptative implementation */
			
			// But before... need to check if we are on time
			final double runningTimeInSeconds = (System.nanoTime() - algorithmStartTime) / 1e9;
			if(runningTimeInSeconds>=maxExecTimeSecs) {
				if(debugMode==2) {
					System.out.println("--- Max time reached, aborting...");
				}
				break;
			}
						
			if(FrozenIterations<san_maxFrozenIteations) { // Decrease temp
				temp*=san_alpha;
			}
			else {
				if(lastCostCausedHitt==costBestSolutionFoundByTheAlgorithm) {
					numberOfHittsWithTheSameCost++;
					if(debugMode==2) {
						System.out.println("--- Heating... This iteration have been heated "+numberOfHittsWithTheSameCost+" times with the same cost");
					}
					
				}
				else {
					lastCostCausedHitt=costBestSolutionFoundByTheAlgorithm;
					numberOfHittsWithTheSameCost=0;
				}
				
				if(numberOfHittsWithTheSameCost>=maxHeatingAttempts) {
					if(debugMode==2) {
						System.out.println("--- maxHeatingAttempts Attempts reached... Time to look everything with another perspective");
					}
					break;
				}
				temp=san_initialTemperature; // Heat to max
				FrozenIterations=0;
			}
		} // End of the outer loop
		
	
		return sanNp;

	}
	
	/**
	 * This function is an implementation given by Pablo Pavon (pablo.pavon@upct.es) for the Local Search algorith. Have been modified 
	 * for get better results shuffling the node list with different random objects
	 * @param costBestSolutionFoundByTheAlgorithm: Best solution reached
	 * @param rnd: Random object for shuffle the node lists
	 * @param np: Net2Plan object
	 * @param M
	 * @param C
	 * @param debugMode: 0 Disabled, 1 Enabled, 2 Verbouse
	 * @return
	 */
	private NetPlan localSearchFirstFit(double costBestSolutionFoundByTheAlgorithm, Random rnd, NetPlan np, int M, double C, int debugMode) {
		boolean solutionWasImproved=true;
		
		mainLocalSearchLoop:
		while (solutionWasImproved) { //Each one of the localSearch iterations
		
			solutionWasImproved=false;
						
			List <Node> shuffledNodes = new ArrayList<> (np.getNodes()); 
			Collections.shuffle(shuffledNodes, rnd); // Shuffle the node list will change the options of getting better solutions
						
			for(Node accessLocation : shuffledNodes) {
				
				final Node firstOriginalCoreLocation = accessLocation.getOutgoingLinks().first().getDestinationNode(); // getOutgoingLinks() devuelve un shortedSet, cojo el primero.
				
				// If second size 1, we hace a self link
				final Node secondOriginalCoreLocation = accessLocation.getOutgoingLinks().size()==1 ? accessLocation : accessLocation.getOutgoingLinks().last().getDestinationNode();
				
				// Unlink the accessNode and try other options
				for (Node originalCoreNode : new Node [] { firstOriginalCoreLocation, secondOriginalCoreLocation}) {
					
					final boolean isSelfLink =  accessLocation.equals(originalCoreNode); // If self link, we do not have to unlink
					
					final Optional<Link> linkToRemove = isSelfLink ? Optional.empty() : Optional.of(np.getNodePairLinks(accessLocation, originalCoreNode, false).first());
				
					if (linkToRemove.isPresent()) linkToRemove.get().remove(); 
					
					List <Node> shuffledNodes2 = new ArrayList<> (np.getNodes()); 
					Collections.shuffle(shuffledNodes2, rnd); // Use a different shuffled list improve the optiones
					
					for (Node differentCoreNodeLocation : shuffledNodes2) {
						if (differentCoreNodeLocation.equals(firstOriginalCoreLocation)) continue; 
						if (differentCoreNodeLocation.equals(secondOriginalCoreLocation)) continue; 
						
						final Optional<Link> newLinkCreated = addLink(accessLocation, differentCoreNodeLocation); 
						
						// Let see if its better, evaluate the result
						final double costNeighborSolution = evaluateDesign(np, M, C).getFirst(); 
						
						// It is local search first fit, if a better solution found we accept it
						if(costNeighborSolution<costBestSolutionFoundByTheAlgorithm) { 
							costBestSolutionFoundByTheAlgorithm=costNeighborSolution;  
							solutionWasImproved=true; 
							continue mainLocalSearchLoop; // First FIT, agree the solution and continue
						}
						
						if(newLinkCreated.isPresent()) newLinkCreated.get().remove(); // Not a better solution? If we have created a link, remove it for the next iteration
					}
					
					if(linkToRemove.isPresent()) addLink(accessLocation, originalCoreNode); // There is not a better option, then set the original situation
				}
				
			}
				
		}

		return np;
	}
	
	
	/**
	 * This is a full-random function for get a first connection of the nodes. No good costs expected  
	 * @param startTopology: Net2Plan topology
	 * @param rnd: Random Object
	 * @return Net2Plan topology with the nodes connected
	 */
	private NetPlan getInitialSolution(NetPlan startTopology, Random rnd) {
		startTopology.removeAllLinks(); // We needn't links, we are breaking with all
		final int N = startTopology.getNumberOfNodes(); // Need to know the number of nodes for the random setup
		for (Node accessNodeLocation : startTopology.getNodes()) {
			// We are going to set the nodes full random (diversification)
			final int firstNodeLocationOfCoreNodeIndex = rnd.nextInt(N); // A number between 0 and N			
		    int secondNodeLocationOfCoreNodeIndex = rnd.nextInt(N); // A number between 0 and N	
			
		    // It is mandatory to have different nodeIndexs so lets generate random values until the second one is different
			while (firstNodeLocationOfCoreNodeIndex==secondNodeLocationOfCoreNodeIndex) {
				secondNodeLocationOfCoreNodeIndex = rnd.nextInt(N);
			}
			
			// Add links
			addLink (accessNodeLocation, startTopology.getNode(firstNodeLocationOfCoreNodeIndex));
			addLink (accessNodeLocation, startTopology.getNode(secondNodeLocationOfCoreNodeIndex));
		}
		
		return startTopology;
	}
}