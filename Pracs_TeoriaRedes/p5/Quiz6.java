// example7ndes, U=50 SP, U=15 peor, U=10 no solucion

package trt.year201516.p5;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.jom.OptimizationProblem;
import com.net2plan.interfaces.networkDesign.Demand;
import com.net2plan.interfaces.networkDesign.IAlgorithm;
import com.net2plan.interfaces.networkDesign.Link;
import com.net2plan.interfaces.networkDesign.Net2PlanException;
import com.net2plan.interfaces.networkDesign.NetPlan;
import com.net2plan.interfaces.networkDesign.Route;
import com.net2plan.libraries.GraphUtils;
import com.net2plan.utils.Constants.RoutingType;
import com.net2plan.utils.DoubleUtils;
import com.net2plan.utils.Triple;

/** This is a template to be used in the lab work, a starting point for the students to develop their programs
 * 
 */
public class Quiz6 implements IAlgorithm
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
		/* The link capacity input parameter is the capacity of the two links in the three node design */
		final int k = Integer.parseInt (algorithmParameters.get ("k")); // if you expect a Double, you have to make the conversion
	
		/* Fix the routing type as source routing */
		netPlan.setRoutingType (RoutingType.SOURCE_ROUTING);
		
		/* Remove any routes (carried traffic) in the input design  */
		netPlan.removeAllRoutes();
		
		/* For each demand, create up to k admissible routes, the k shortest in number of hops */
		for (Demand d : netPlan.getDemands ())
		{
			List<List<Link>> kShortestPaths = GraphUtils.getKLooplessShortestPaths(netPlan.getNodes () , netPlan.getLinks () , d.getIngressNode() , d.getEgressNode() , null , k , -1 , -1 , -1 , -1, -1, -1);
			if (kShortestPaths.isEmpty()) throw new Net2PlanException ("There are no admissible routes for a demand");
			for (List<Link> sp : kShortestPaths)
				netPlan.addRoute (d , 0 , 0 , sp , null);
		}
		
		/* Create the optimization problem */
		OptimizationProblem op = new OptimizationProblem ();
		
		/* add the vector of decision variables */
		/* i-th coordinate in decision variables array, corresponds to the route of index i in the netPlan object */
		op.addDecisionVariable("x_p" , false , new int [] {1 , netPlan.getNumberOfRoutes () } , 0 , Double.MAX_VALUE);

		/* Set the objective function */
		op.setInputParameter("l_p" , netPlan.getVectorRouteNumberOfLinks() , "row");
		op.setObjectiveFunction("minimize" , "l_p * x_p'"); // equivalent to "sum (l_p .* x_p)";
		
		
		op.setInputParameter("h_d" , netPlan.getVectorDemandOfferedTraffic() , "row");
		op.setInputParameter("u_e" , netPlan.getVectorLinkCapacity() , "row");
		op.setInputParameter("A_dp" , netPlan.getMatrixDemand2RouteAssignment());
		op.setInputParameter("A_ep" , netPlan.getMatrixLink2RouteAssignment());

		/* Add the flow satisfaction constraints (all the traffic is carried) */
		op.addConstraint("A_dp * x_p' == h_d'"); // demand satisfaction constraints (one per demand)
		/* Add the link capacity constraints (all links carry less or equal traffic than its capacity) */
		op.addConstraint("A_ep * x_p' <= u_e'"); // link capacity constraints (one per link)

		/* call the solver to solve the problem */
		op.solve ("glpk");
		
		/* An optimal solution was not found */
		if (!op.solutionIsOptimal()) 
			throw new Net2PlanException ("An optimal solution was not found");

		final double [] x_p = op.getPrimalSolution("x_p").to1DArray();
		
		for (Route r : netPlan.getRoutes())
			r.setCarriedTraffic(x_p [r.getIndex ()] , x_p [r.getIndex ()]);
		
		netPlan.removeAllRoutesUnused(0.001);
		
		return "Ok! Total bandwidth consumed in the links: " + op.getOptimalCost(); 
	}

	/** Returns a description message that will be shown in the graphical user interface
	 */
	@Override
	public String getDescription()
	{
		return "Routing optimization example";
	}

	
	/** Returns the list of input parameters of the algorithm. For each parameter, you shoudl return a Triple with its name, default value and a description
	 * @return
	 */
	@Override
	public List<Triple<String, String, String>> getParameters()
	{
		final List<Triple<String, String, String>> param = new LinkedList<Triple<String, String, String>> ();
		param.add (Triple.of ("k" , "10" , "Maximum number of loopless admissible paths per demand"));
		return param;
	}
}
