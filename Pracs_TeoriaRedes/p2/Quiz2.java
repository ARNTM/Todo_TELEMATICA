
package trt.year201516.p2;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.net2plan.interfaces.networkDesign.IAlgorithm;
import com.net2plan.interfaces.networkDesign.NetPlan;
import com.net2plan.interfaces.networkDesign.Node;
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
		/* Typically, you start reading the input parameters */
		double linkCapacity = Double.parseDouble (algorithmParameters.get ("linkCapacity")); // if you expect a Double, you have to make the conversion
		
		/* Create an algorithm that receives an input design, removes all the links in it, and adds one link between each node pair. 
		 * All the links will have the same capacity, given by the input parameter of the algorithm linkCapacity */
		
		/* remove all the network links */
		netPlan.removeAllLinks ();
		
		/* add one link between each node pair. I will assume a length equal to the euclidean distance between the two nodes, and a propagation speed of 200000  */
		for (Node n1 : netPlan.getNodes ())
			for (Node n2 : netPlan.getNodes ())
			{
				if (n1 == n2) continue;
				netPlan.addLink (n1 , n2 , linkCapacity , netPlan.getNodePairEuclideanDistance(n1 , n2) , 200000 , null);
			}
		
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
