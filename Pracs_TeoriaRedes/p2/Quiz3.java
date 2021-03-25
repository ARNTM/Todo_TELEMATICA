
package trt.year201516.p2;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.net2plan.interfaces.networkDesign.IAlgorithm;
import com.net2plan.interfaces.networkDesign.Link;
import com.net2plan.interfaces.networkDesign.NetPlan;
import com.net2plan.interfaces.networkDesign.Node;
import com.net2plan.utils.Triple;

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
		int hubIndex = Integer.parseInt (algorithmParameters.get ("hubIndex")); 
		
		/* Create an algorithm that receives an input design, and the index of a node as an input parameter 
		 * (hubIndex parameter, with default value 0). Then, it will remove all the links in the input design, 
		 * but those starting or ending in the hubIndex node. */
		Node hubNode = netPlan.getNode (hubIndex);
		
		/* I create first a copy of the list all the network links. A copy is needed since I will be removing links */
		List<Link> copyOfOriginalListOfLinks = new LinkedList<Link> (netPlan.getLinks ());

		/* Now go through the list, and remove the links that do not enter/leave the hub */
		for (Link e : copyOfOriginalListOfLinks)
			if ((e.getOriginNode () != hubNode) && (e.getDestinationNode () != hubNode))
				e.remove ();

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
		param.add (Triple.of ("hubIndex" , "0" , "The index of the hub node"));
		return param;
	}
}
