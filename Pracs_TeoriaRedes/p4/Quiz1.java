

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.jom.OptimizationProblem;
import com.net2plan.interfaces.networkDesign.Demand;
import com.net2plan.interfaces.networkDesign.IAlgorithm;
import com.net2plan.interfaces.networkDesign.Link;
import com.net2plan.interfaces.networkDesign.Net2PlanException;
import com.net2plan.interfaces.networkDesign.NetPlan;
import com.net2plan.interfaces.networkDesign.Node;
import com.net2plan.interfaces.networkDesign.Route;
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
		/* The link capacity input parameter is the capacity of the two links in the three node design */
		double linkCapacity = Double.parseDouble (algorithmParameters.get ("linkCapacity")); // if you expect a Double, you have to make the conversion
		
		/* We first remove everythign of the input design: nodes, links etc. Then, set the routing type as SOURCE ROUTING */
		netPlan.reset();
		netPlan.setRoutingType (RoutingType.SOURCE_ROUTING);
		
		/* Create the three nodes */
		final Node node1 = netPlan.addNode (0 , 0 , "Node 1" , null);
		final Node node2 = netPlan.addNode (200 , 1 , "Node 2" , null);
		final Node node3 = netPlan.addNode (400 , 0 , "Node 3" , null);
		
		/* Create the links from node1 to node2, and from node2 to node3 */
		final Link e12 = netPlan.addLink (node1 , node2 , linkCapacity , 1 , 200000 , null);
		final Link e23 = netPlan.addLink (node2 , node3 , linkCapacity , 1 , 200000 , null);
		
		/* Create the three demands, 1-->2, 2-->3, and 1-->3, all with zero offered traffic */
		final Demand d12 = netPlan.addDemand (node1 , node2 , 0 , null);
		final Demand d23 = netPlan.addDemand (node2 , node3 , 0 , null);
		final Demand d13 = netPlan.addDemand (node1 , node3 , 0 , null);
		
		/* Create the routes for the demands, with zero carried traffic and occupied link capacity */
		List<Link> path12 = new LinkedList<Link> (); path12.add (e12);
		List<Link> path23 = new LinkedList<Link> (); path23.add (e23);
		List<Link> path13 = new LinkedList<Link> (); path13.add (e12); path13.add (e23); 
		final Route r12 = netPlan.addRoute (d12 , 0 , 0, path12 , null);
		final Route r23 = netPlan.addRoute (d23 , 0 , 0, path23 , null);
		final Route r13 = netPlan.addRoute (d13 , 0 , 0, path13 , null);
		
		/* The optimization of the offered/carried traffic should start here */
		
		/* Create an OptimizationProblem object to handle the optimization */
		OptimizationProblem op = new OptimizationProblem ();
		
		/* Set the input parameter U */
		op.setInputParameter("U" , linkCapacity);

		/* Add the decision variables */
		op.addDecisionVariable("h12" , true , new int [] {1 , 1} , 0 , Double.MAX_VALUE);
		op.addDecisionVariable("h23" , true , new int [] {1 , 1} , 0 , Double.MAX_VALUE);
		op.addDecisionVariable("h13" , false , new int [] {1 , 1} , 0 , Double.MAX_VALUE);
		
		/* Set the objective function */
		op.setObjectiveFunction("maximize" , "2*h12 + 2*h23 + h13");
		
		/* Add the constraints, excepting the non-negativity which are already enforced */
		op.addConstraint("2*h12 + h13 <= U");
		op.addConstraint("2*h23 + h13 <= U");
		
		/* call the solver to solve the problem */
		op.solve ("glpk");
		
		/* If an optimum solution was not found, raise an exception */
		if (!op.solutionIsOptimal()) 
			throw new Net2PlanException ("An optimal solution was not found");
		
		/* Retrieve the optimum value of the decision variables */
		final double h12 = op.getPrimalSolution("h12").toValue();
		final double h23 = op.getPrimalSolution("h23").toValue();
		final double h13 = op.getPrimalSolution("h13").toValue();
		
		/* Set the demands offered traffic, and their routes carried traffic and occupied link capacity */
		d12.setOfferedTraffic(2*h12);
		d23.setOfferedTraffic(2*h23);
		d13.setOfferedTraffic(h13);
		r12.setCarriedTraffic(2*h12 , 2*h12);
		r23.setCarriedTraffic(2*h23 , 2*h23);
		r13.setCarriedTraffic(h13 , h13);
		
		/* Check that the offered traffic is equal (up to a precision, to avoid numerical problems) to the carried traffic */
		if ((Math.abs (d12.getOfferedTraffic() - r12.getCarriedTraffic()) > 1e-3) || 
				(Math.abs (d23.getOfferedTraffic() - r23.getCarriedTraffic()) > 1e-3) || 
				(Math.abs (d13.getOfferedTraffic() - r13.getCarriedTraffic()) > 1e-3) )
			throw new Net2PlanException ("All the offered traffic should be carried: make the demand offered traffic be equal to the carried traffic of the associated route");

		return "Ok! Traffic d12: " + d12.getOfferedTraffic() + ", d23: " + d23.getOfferedTraffic() + ", d13: " + d13.getOfferedTraffic() + ". The total offered and carried traffic is: " + netPlan.getVectorDemandOfferedTraffic().zSum(); 
	}

	/** Returns a description message that will be shown in the graphical user interface
	 */
	@Override
	public String getDescription()
	{
		return "Optimization of injected traffic in a 3 node example";
	}

	
	/** Returns the list of input parameters of the algorithm. For each parameter, you shoudl return a Triple with its name, default value and a description
	 * @return
	 */
	@Override
	public List<Triple<String, String, String>> getParameters()
	{
		final List<Triple<String, String, String>> param = new LinkedList<Triple<String, String, String>> ();
		param.add (Triple.of ("linkCapacity" , "1.0" , "Capacity of the links"));
		return param;
	}
}
