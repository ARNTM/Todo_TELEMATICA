

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.net2plan.interfaces.networkDesign.Demand;
import com.net2plan.interfaces.networkDesign.IAlgorithm;
import com.net2plan.interfaces.networkDesign.Link;
import com.net2plan.interfaces.networkDesign.NetPlan;
import com.net2plan.interfaces.networkDesign.Node;
import com.net2plan.libraries.GraphUtils;
import com.net2plan.utils.Constants.RoutingType;
import com.net2plan.utils.Triple;

/** This is a template to be used in the lab work, a starting point for the students to develop their programs
 * 
 */
public class LabSession3_cfa implements IAlgorithm
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
		double cg = Double.parseDouble (algorithmParameters.get ("cg")); 
		
		/* Set the routing type as source-routing */
		netPlan.setRoutingType (RoutingType.SOURCE_ROUTING);
		
		/* Remove any input route or protection segment. */
		netPlan.removeAllRoutes ();
		
		/* For each demand, the traffic should be carried using a single Route, where the link capacity occupied by the route is the same as 
		 * the traffic carried, and the route path is the shortest path in number of hops (number of traversed links) between the demand end nodes. */
		for (Demand d : netPlan.getDemands ())
		{
			Node demandOriginNode = d.getIngressNode();
			Node demandEndNode = d.getEgressNode();
			double demandOfferedTraffic = d.getOfferedTraffic();

			/* Computes the shortest path in number of hops between the demand end nodes. 
			 * Passing "null" in the link weight cost, means that all the links have the same cost, and the shortest path in number of hops is then returned */
			List<Link> shortestPathSeqLinks = GraphUtils.getShortestPath(netPlan.getNodes () , netPlan.getLinks () , demandOriginNode , demandEndNode , null);

			/* if there is no path between the nodes (so the network is NOT CONNECTED), we cannot add a route for this demand => move to the next demand */
			if (shortestPathSeqLinks.isEmpty()) continue;
			
			/* adds the route */
			netPlan.addRoute (d , demandOfferedTraffic , demandOfferedTraffic , shortestPathSeqLinks , null);
		}

		/* After previous point in completed, the network links are carrying the routed traffic. Now, for each link, set its capacity
		 * so that its utilization becomes equal to the input parameter cg.*/
		double totalCapacityInstalled = 0;
		for (Link e : netPlan.getLinks ())
		{
			double capacityInThisLink = e.getOccupiedCapacity() / cg;
			e.setCapacity (capacityInThisLink);
			totalCapacityInstalled += capacityInThisLink;
		}
		
		return "Total capacity in the links: " + totalCapacityInstalled; // this is the message that will be shown in the screen at the end of the algorithm
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
		param.add (Triple.of ("cg" , "0.6" , "Link utilization to be enforced in all the links"));
		return param;
	}
}
