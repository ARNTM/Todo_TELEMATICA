
package trt.year201516.p7;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.jom.OptimizationProblem;
import com.net2plan.interfaces.networkDesign.IAlgorithm;
import com.net2plan.interfaces.networkDesign.Link;
import com.net2plan.interfaces.networkDesign.Net2PlanException;
import com.net2plan.interfaces.networkDesign.NetPlan;
import com.net2plan.interfaces.networkDesign.Node;
import com.net2plan.utils.Triple;

import cern.colt.matrix.tdouble.DoubleMatrix1D;
import cern.colt.matrix.tdouble.DoubleMatrix2D;

/** This is a template to be used in the lab work, a starting point for the students to develop their programs
 * 
 */
public class Quiz3 implements IAlgorithm
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
		final double capacityModule = Double.parseDouble (algorithmParameters.get ("capacityModule")); // if you expect a Double, you have to make the conversion
		
		/* Remove all the carried traffic in the network, whatever the routing type the netPlan object has (source routing or hop-by-hop routing)*/
		netPlan.removeAllUnicastRoutingInformation();

		/* Compute the traffic matrix from the input demands of the design. This matrix has zeros in the diagonal */
		final DoubleMatrix2D trafficMatrix = netPlan.getMatrixNode2NodeOfferedTraffic();
		
		/* Create the optimization problem */
		OptimizationProblem op = new OptimizationProblem ();
		
		/* add the vector of decision variables */
		/* (d,e)-th coordinate in decision variables 2D array, corresponds to the demand of index d and the link of index e in the netPlan object */
		final int N = netPlan.getNumberOfNodes();
		final int E = netPlan.getNumberOfLinks ();
		op.addDecisionVariable("x_te" , false , new int [] {N , E } , 0 , Double.MAX_VALUE);
		op.addDecisionVariable("a_e" , true , new int [] {1 , E } , 0 , Integer.MAX_VALUE);

		/* Set the objective function */
		op.setObjectiveFunction("minimize" , "sum (a_e)"); 
		
		/* Add the flow conservation constraints (means all the traffic is carried, in something compatible with a routing) */
		op.setInputParameter("A_ne", netPlan.getMatrixNodeLinkIncidence()); /* 1 in position (n,e) if link e starts in n, -1 if it ends in n, 0 otherwise */
        final DoubleMatrix1D egressTraffic_t = netPlan.getVectorNodeEgressUnicastTraffic();
        final DoubleMatrix2D trafficMatrixDiagonalNegative = netPlan.getMatrixNode2NodeOfferedTraffic();
        for (int t = 0; t < N ; t ++) trafficMatrixDiagonalNegative.set(t, t, -egressTraffic_t.get(t));
        op.setInputParameter("TM", trafficMatrixDiagonalNegative);
        op.addConstraint("A_ne * (x_te') == TM"); /* the flow-conservation constraints (NxD constraints) */

        /* Add the link capacity constraints (all links carry less or equal traffic than its capacity) */
		op.setInputParameter ("C" , capacityModule);
        op.addConstraint("sum(x_te,1) <= C .* a_e"); /* the capacity constraints (E constraints) */

		/* call the solver to solve the problem */
		op.solve ("glpk" , "maxSolverTimeInSeconds" , 10);
		
		/* An optimal solution was not found */
		if (!op.solutionIsFeasible()) 
			throw new Net2PlanException ("A feasible solution was not found");

		final DoubleMatrix2D x_te = op.getPrimalSolution("x_te").view2D();
		final DoubleMatrix1D a_e = op.getPrimalSolution("a_e").view1D();
		
		/* Set the routing of the traffic according to the x_te variables */
		netPlan.setRoutingFromDestinationLinkCarriedTraffic(x_te , true);

		/* Set the capacity in the links according to the a_e variables */
		for (Link e : netPlan.getLinks())
			e.setCapacity(a_e.get(e.getIndex()) * capacityModule);
		
		return "Ok! Optimal solution found: " + op.solutionIsOptimal() + ". Total capacity in the links: " + netPlan.getVectorLinkCapacity().zSum(); 
	}

	/** Returns a description message that will be shown in the graphical user interface
	 */
	@Override
	public String getDescription()
	{
		return "Here you should return the algorithm description to be printed by Net2Plan graphical user interface";
	}

	
	/** Returns the list of input parameters of the algorithm. For each parameter, you shoudl return a Triple with its name, default value and a description
	 * @return
	 */
	@Override
	public List<Triple<String, String, String>> getParameters()
	{
		final List<Triple<String, String, String>> param = new LinkedList<Triple<String, String, String>> ();
		param.add (Triple.of ("capacityModule" , "10" , "Size of the capacity module measured in the same units as the traffic."));
		return param;
	}
}
