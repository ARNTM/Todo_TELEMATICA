
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
import com.net2plan.utils.Triple;

/** This is a template to be used in the lab work, a starting point for the students to develop their programs
 * 
 */
public class Quiz1 implements IAlgorithm
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
		final double alpha = Double.parseDouble(algorithmParameters.get("alpha"));
		
		/* Set the routing type to source routing */
		netPlan.setRoutingType(RoutingType.SOURCE_ROUTING);

		/* Remove all the routes in the input design */
		netPlan.removeAllRoutes();
		
		/* Create one route for each demand, with the shortest path in number of traversed links */
		for (Demand d : netPlan.getDemands())
		{
			List<Link> shortestPath = GraphUtils.getShortestPath(netPlan.getNodes(), netPlan.getLinks(), d.getIngressNode(), d.getEgressNode(), null);
			if (shortestPath.isEmpty()) throw new Net2PlanException ("A TCP connection cannot be established: the network is not connected");
			netPlan.addRoute(d, 0, 0, shortestPath, null); 
		}
		
		/* Create the OptimizationProblem object */
		OptimizationProblem op = new OptimizationProblem ();
		
		/* Add the decision variables of the problem */
		final int D = netPlan.getNumberOfDemands();
		op.addDecisionVariable("h_d", false ,  new int [] {1 , D} , 0 , Double.MAX_VALUE );

		/* Compute the vector with the z_d coefficients for the objective function */
		op.setInputParameter("a" , alpha);

		/* Set the objective function */
		if (alpha == 1)
			op.setObjectiveFunction("maximize", "sum (ln (h_d))");
		else
			op.setObjectiveFunction("maximize" , "(1/(1-a))* sum(h_d^(1-a))");
		
		/* Add the link capacity constraints */
		for (Link e : netPlan.getLinks())
		{
			op.setInputParameter("P_e", NetPlan.getIndexes(e.getTraversingRoutes()) , "row");
			op.setInputParameter("u_e", e.getCapacity());
			op.addConstraint("sum(h_d(P_e)) <= u_e");
		}

		/* Call the solver */
		op.solve("ipopt", "solverLibraryName", "C:\\Ipopt38_32.dll");

		/* If the solver could not find an optimal solution, raise an exception */
		if (!op.solutionIsOptimal()) throw new Net2PlanException ("An optimal solution was not found");

		double [] h_d = op.getPrimalSolution("h_d").to1DArray();
		
		/* Save the solution in the netPlan object */
		for (Route r : netPlan.getRoutes())
		{
			final double traf = h_d [r.getIndex()];
			r.setCarriedTraffic(traf , traf);
			r.getDemand().setOfferedTraffic(traf);
		}
		
		/* Compute the Jain fairness index */
		double sumSquareHd = 0; double sumHd = 0; 
		for (Demand d : netPlan.getDemands()) 
		{ 
			sumSquareHd += Math.pow(d.getOfferedTraffic(),2); 
			sumHd += d.getOfferedTraffic(); 
		}  
		final double jainFactor =  Math.pow(sumHd,2) / (D * sumSquareHd);
		
		double totalCarriedTraffic = netPlan.getVectorDemandCarriedTraffic().zSum();
		double totalOfferedTraffic = netPlan.getVectorDemandOfferedTraffic().zSum();
		
		if(totalCarriedTraffic != totalOfferedTraffic)
			throw new Net2PlanException ("There is an error. All offered traffic must be carried");
			
		System.out.println("Jain fairness index: " + jainFactor + ", network throughput: " + totalOfferedTraffic);
		
		return "Ok! Jain fairness index: " + jainFactor + ", network throughput: " + totalOfferedTraffic;
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
		param.add (Triple.of ("alpha" , "1" , "Value for the alpha fairness."));
		return param;
	}
}
