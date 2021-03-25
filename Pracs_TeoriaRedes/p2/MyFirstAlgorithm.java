
package trt.year201516.p2;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.net2plan.interfaces.networkDesign.Demand;
import com.net2plan.interfaces.networkDesign.IAlgorithm;
import com.net2plan.interfaces.networkDesign.Link;
import com.net2plan.interfaces.networkDesign.NetPlan;
import com.net2plan.interfaces.networkDesign.Node;
import com.net2plan.utils.Constants.RoutingType;
import com.net2plan.utils.Triple;

/** This is a template to be used in the lab work, a starting point for the students to develop their programs
 * 
 */
public class MyFirstAlgorithm implements IAlgorithm
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
		double linkCapacity = Double.parseDouble (algorithmParameters.get ("linkCapacity")); // if you expect a Double, you have to make the conversion
		
		/* Now you make the things here that modify the NetPlan object: the state of the NetPlan object at the end of this method, is the new network design */

		/* remove all the nodes in the input design */
		netPlan.removeAllNodes ();
		
		/* add nodes to the design */
		Node nodeA = netPlan.addNode(0 , 0, "nodeA" , null);
		Node nodeB = netPlan.addNode(10 , 0, "nodeB" , null);
		Node nodeC = netPlan.addNode(5 , 5, "nodeC" , null);
		
		/* add the links to the design */
		Link linkAB = netPlan.addLink (nodeA , nodeB , linkCapacity , 10 , 200000 , null);
		Link linkBA = netPlan.addLink (nodeB , nodeA , linkCapacity , 10 , 200000 , null);
		Link linkAC = netPlan.addLink (nodeA , nodeC , linkCapacity , 10 , 200000 , null);
		Link linkCA = netPlan.addLink (nodeC , nodeA , linkCapacity , 10 , 200000 , null);
		Link linkBC = netPlan.addLink (nodeB , nodeC , linkCapacity , 10 , 200000 , null);
		Link linkCB = netPlan.addLink (nodeC , nodeB , linkCapacity , 10 , 200000 , null);
		
		/* Print in the Java console the index and identier (Id) of all the created links */
		for (Link e : netPlan.getLinks ())
			System.out.println ("The link of index: " + e.getIndex () + ", and Id = " + e.getId () + ", is the link between node " + e.getOriginNode ().getName () + " and node " + e.getDestinationNode ().getName ());
		
		/* Add one trac demand starting in nodeA and ending in nodeB, with 5 trac units */
		Demand newDemand = netPlan.addDemand (nodeA , nodeB , 5 , null);
		
		/* Set the trac routing type to SOURCE ROUTING, specifying that the traffic will be carried using Route objects (instead of forwarding rules). */
		netPlan.setRoutingType (RoutingType.SOURCE_ROUTING);
		
		/* Add a route to the design, associated to the demand that was just created. The route should carry 2 units of trac, occupying 2 units 
		 * of capacity in each link traversed. The path is composed of just the direct link between the nodes. */
		List<Link> seqLinksOneHop = new LinkedList<Link> ();
		seqLinksOneHop.add (linkAB);
		netPlan.addRoute (newDemand , 2 , 2 , seqLinksOneHop , null);
		
		/* Add a second route to the design, associated to the same demand. The route should carry 3 units of trac, occupying 3 units of 
		 * capacity in each link traversed. The path is composed of the two links nodeA ! nodeC ! nodeB.  */ 
		List<Link> seqLinksTwoHops = new LinkedList<Link> ();
		seqLinksTwoHops.add (linkAC);
		seqLinksTwoHops.add (linkCB);
		netPlan.addRoute (newDemand , 3 , 3 , seqLinksTwoHops , null);

		/* Modify the previous algorithm to print in the Java console all the network nodes, with its index and its name. */
		/* A possible form is as follows */
		for (Node n : netPlan.getNodes ())
			System.out.println ("Node of name: " + n.getName () + ", has index: " + n.getIndex ());
		/* A second form to make the same thing is as follows */
		for (int nodeIndex = 0 ; nodeIndex < netPlan.getNumberOfNodes () ; nodeIndex ++)
			System.out.println ("Node of name: " + netPlan.getNode (nodeIndex).getName () + ", has index: " + nodeIndex);
		
		
		
		return "Ok!"; // this is the message that will be shown in the screen at the end of the algorithm
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
		param.add (Triple.of ("linkCapacity" , "1.0" , "This is the capacity to place in all the links"));
		return param;
	}
}
