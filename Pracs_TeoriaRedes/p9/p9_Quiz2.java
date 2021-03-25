import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.jom.OptimizationProblem;
import com.net2plan.interfaces.networkDesign.IAlgorithm;
import com.net2plan.interfaces.networkDesign.Net2PlanException;
import com.net2plan.interfaces.networkDesign.NetPlan;
import com.net2plan.interfaces.networkDesign.Node;
import com.net2plan.utils.Triple;

/** This is a template to be used in the lab work, a starting point for the students to develop their programs
 * 
 */
public class p9_Quiz2 implements IAlgorithm
{
	
	/** The method called by Net2Plan to run the algorithm (when the user presses the "Execute" button)
	 * @param netPlan The input network design. The developed algorithm should modify it: it is the way the new design is returned
	 * @param algorithmParameters Pair name-value for the current value of the input parameters
	 * @param net2planParameters Pair name-value for some general parameters of Net2Plan
	 * @return
	 */
	@Override
	public String executeAlgorithm(NetPlan netPlan, Map<String, String> algorithmParameters, Map<String, String> net2planParameters)
	{
		/* Typically, you start reading the input parameters */
		final double C = Double.parseDouble(algorithmParameters.get ("C")); 
		final int K = Integer.parseInt (algorithmParameters.get ("K")); 
		final int M = Integer.parseInt (algorithmParameters.get ("M")); 
		
		/* remove all the network links */
		netPlan.removeAllLinks();
		
		/* Create the optimization object */
		OptimizationProblem op = new OptimizationProblem();
		
		/* Add the decision variables */
		final int N = netPlan.getNumberOfNodes();
		op.addDecisionVariable("z_j" , true , new int [] {1,N} , 0 , 1); // 1 if location j has a core node
		op.addDecisionVariable("e_ij" , true , new int [] {N,N} , 0 , 1); // 1f access node at location i, is connected to a core node in j
		
		/* Add the input parameters */
		op.setInputParameter("C" , C);
		op.setInputParameter("K" , K);
		op.setInputParameter("c_ij" , netPlan.getMatrixNode2NodeEuclideanDistance());
		
		op.setObjectiveFunction("minimize" , "C * sum(z_j) + sum(c_ij .* e_ij)");

		/* The constraints that each access node is connected to exactly one core node */
		for (Node i : netPlan.getNodes())
		{
			op.setInputParameter("i" , i.getIndex());
			op.addConstraint("sum(e_ij(i,all)) == 1");
		}

		/* The constraint that each potential core node can receive 0 links from access nodes (if it does not exist), 
		 * and at most K access nodes if it exists */
		for (Node j : netPlan.getNodes ())
		{
			op.setInputParameter("j" , j.getIndex());
			op.addConstraint("sum(e_ij(all,j)) <= K * z_j(j)");
		}

		op.setInputParameter("M" , M);
		op.addConstraint("sum(z_j) <= M");
		
		/* Call the solver to solve the problem */
		op.solve("glpk", "solverLibraryName", "C:\\glpk.dll");
		if (!op.solutionIsOptimal()) throw new Net2PlanException ("The solution is not optimal");

		/* Retrieve the optimal solution found */
		final double [] z_j = op.getPrimalSolution("z_j").to1DArray();
		final double [][] e_ij = (double [][]) op.getPrimalSolution("e_ij").toArray();
				
		/* Save the access-to-node links in the design (links are not bidirectional) */
		for (Node i : netPlan.getNodes ()) 
			for (Node j : netPlan.getNodes ())
				if ((i != j) && (e_ij[i.getIndex()][j.getIndex()] == 1))
					netPlan.addLink(i, j, 1, netPlan.getNodePairEuclideanDistance(i,j) , 200000 , null);

		/* Compute the total number of core nodes */
		int numCoreNodes = 0; for (int n = 0; n < N ; n ++) numCoreNodes += z_j [n];


		return "Ok! Number of core nodes: " + numCoreNodes + ", total cost: " + op.getOptimalCost(); 
	}

	/** Returns a description message that will be shown in the graphical user interface
	 */
	@Override
	public String getDescription()
	{
		return "";
	}

	
	/** Returns the list of input parameters of the algorithm. For each parameter, you shoudl return a Triple with its name, default value and a description
	 * @return
	 */
	@Override
	public List<Triple<String, String, String>> getParameters()
	{
		final List<Triple<String, String, String>> param = new LinkedList<Triple<String, String, String>> ();
		param.add (Triple.of ("K" , "5" , "Core node maximum number of connected access nodes"));
		param.add (Triple.of ("C" , "10" , "Core node cost"));
		param.add (Triple.of ("M" , "15" , "Maximum number of core nodes"));
		return param;
	}
}
