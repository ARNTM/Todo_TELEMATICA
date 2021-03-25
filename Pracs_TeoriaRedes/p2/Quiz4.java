
package trt.year201516.p2;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import com.net2plan.interfaces.networkDesign.IAlgorithm;
import com.net2plan.interfaces.networkDesign.NetPlan;
import com.net2plan.utils.Triple;

/** This is a template to be used in the lab work, a starting point for the students to develop their programs
 * 
 */
public class Quiz4 implements IAlgorithm
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
		int numNodes = Integer.parseInt (algorithmParameters.get ("numNodes")); 
		
		/* Create an algorithm that receives an input design, removes all the nodes in it, and then creates a number of nodes given 
		 * by the input parameter numNodes (defaults to 10). The X and the Y positions of each node are chosen randomly using a
		 * uniform distribution between 0 and 10. */
		
		/* remove all the nodes */
		netPlan.removeAllNodes ();
		
		/* Create the nodes, and place them randomly. The method nextDouble () in the random number generator, creates a sample of a uniform [0,1] distribution */
		Random randomNumberGenerator = new Random ();
		for (int cont = 0 ; cont < numNodes ; cont ++)
			netPlan.addNode (randomNumberGenerator.nextDouble() , randomNumberGenerator.nextDouble () , "Node_" + cont , null);
		
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
		param.add (Triple.of ("numNodes" , "10" , "Number of nodes to create"));
		return param;
	}
}
