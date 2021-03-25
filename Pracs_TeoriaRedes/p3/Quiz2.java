

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.net2plan.interfaces.networkDesign.Demand;
import com.net2plan.interfaces.networkDesign.IAlgorithm;
import com.net2plan.interfaces.networkDesign.Link;
import com.net2plan.interfaces.networkDesign.NetPlan;
import com.net2plan.interfaces.networkDesign.Node;
import com.net2plan.libraries.GraphUtils;
import com.net2plan.utils.Triple;

/** This is a template to be used in the lab work, a starting point for the students to develop their programs
 * 
 */
public class Quiz2 implements IAlgorithm
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
		/* Create an algorithm that removes all the existing routes in the network. Then, it goes
		 * through all the traffic demands of the design, in increasing order of index (0,1,2,...). For each demand, 
		 * the algorithm should use the method getCapacitatedShortestPath in GraphUtils class, to compute the 
		 * shortest path between the demand end nodes, that has a sufficient unused capacity in the links 
		 * to carry the traffic of the new demand. If no path is returned, the demand is blocked. If a path 
		 * is found, we route all the demand traffic through it. As usual, the link occupied capacity is equal to 
		 * the link carried traffic.*/
		
		/* Remove all existing routes */
		netPlan.removeAllRoutes ();
		
		/* go through all the demands in the design in increasing order of index */
		for (Demand d : netPlan.getDemands ())
		{
			Node demandOriginNode = d.getIngressNode();
			Node demandEndNode = d.getEgressNode();
			double demandOfferedTraffic = d.getOfferedTraffic();

			/* Computes the shortest path in number of hops between the demand end nodes. 
			 * Passing "null" in the link weight cost, means that all the links have the same cost, and the shortest path in number of hops is then returned */
			List<Link> shortestPathWithEnoughCapacitySeqLinks = GraphUtils.getCapacitatedShortestPath(netPlan.getNodes () , netPlan.getLinks () , demandOriginNode , demandEndNode , null , null , demandOfferedTraffic);

			/* if there is no path with available capacity between the nodes, we do not add the route for this demand => move to the next demand */
			if (shortestPathWithEnoughCapacitySeqLinks.isEmpty()) continue;
			
			/* adds the route */
			netPlan.addRoute (d , demandOfferedTraffic , demandOfferedTraffic , shortestPathWithEnoughCapacitySeqLinks , null);
		}
		
		return "Ok!";
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
		return param;
	}
}
