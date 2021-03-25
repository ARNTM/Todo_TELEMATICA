

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
		/* Create an algorithm that removes all the existing demands in the network, and then creates one demand between each node pair, 
		 * with a constant offered traffic traf, an input parameter of the algorithm with default value 1. */
		
		/* Read the algorithm input parameter */
		double traf = Double.parseDouble (algorithmParameters.get ("traf")); 
		
		/* Remove all existing demands */
		netPlan.removeAllDemands();
		
		/* Create a demand between each node pair (this is, (n1,n2), where n1 is different to n2) */
		for (Node n1 : netPlan.getNodes ())
			for (Node n2 : netPlan.getNodes ())
			{
				if (n1 == n2) continue; // if n1 == n2, do not create a demand 
				netPlan.addDemand (n1 , n2 , traf , null);
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
		param.add (Triple.of ("traf" , "1" , "Offered traffic for all the demands"));
		return param;
	}
}
