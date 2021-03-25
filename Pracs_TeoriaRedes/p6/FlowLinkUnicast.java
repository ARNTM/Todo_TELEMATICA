

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
import com.net2plan.utils.Constants.RoutingType;
import com.net2plan.utils.Triple;

import cern.colt.matrix.tdouble.DoubleMatrix2D;

/** This is a template to be used in the lab work, a starting point for the students to develop their programs
 * 
 */
public class FlowLinkUnicast implements IAlgorithm
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
		/* Remove all the carried traffic in the network, whatever the routing type the netPlan object has (source routing or hop-by-hop routing)*/
		netPlan.removeAllUnicastRoutingInformation();
		
		/* Create the optimization problem */
		OptimizationProblem op = new OptimizationProblem ();
		
		/* add the vector of decision variables */
		/* (d,e)-th coordinate in decision variables 2D array, corresponds to the demand of index d and the link of index e in the netPlan object */
		final int D = netPlan.getNumberOfDemands();
		final int E = netPlan.getNumberOfLinks ();
		op.addDecisionVariable("x_de" , false , new int [] {D , E } , 0 , Double.MAX_VALUE);

		/* Set the objective function */
		op.setObjectiveFunction("minimize" , "sum (x_de)"); 
		
		/* Add the flow conservation constraints (means all the traffic is carried, in something compatible with a routing) */
		for (Node n : netPlan.getNodes ())
		{
			op.setInputParameter ("deltaPlus" , NetPlan.getIndexes (n.getOutgoingLinks()) , "row");
			op.setInputParameter ("deltaMinus" , NetPlan.getIndexes (n.getIncomingLinks()) , "row");
			for (Demand d : netPlan.getDemands ())
			{
				op.setInputParameter ("d" , d.getIndex ());
				op.setInputParameter ("h_d" , d.getOfferedTraffic());
				if (n == d.getIngressNode())
					op.addConstraint ("sum(x_de(d,deltaPlus)) - sum(x_de(d,deltaMinus)) == h_d");
				else if (n == d.getEgressNode())
					op.addConstraint ("sum(x_de(d,deltaPlus)) - sum(x_de(d,deltaMinus)) == -h_d");
				else
					op.addConstraint ("sum(x_de(d,deltaPlus)) - sum(x_de(d,deltaMinus)) == 0");
			}
		}


		/* Add the link capacity constraints (all links carry less or equal traffic than its capacity) */
		for (Link e : netPlan.getLinks ())
		{
			op.setInputParameter("e" , e.getIndex ());
			op.setInputParameter("u_e" , e.getCapacity ());
			op.addConstraint ("sum(x_de(all,e)) <= u_e");
		}

		/* call the solver to solve the problem */
		op.solve ("glpk");
		
		/* An optimal solution was not found */
		if (!op.solutionIsOptimal()) 
			throw new Net2PlanException ("An optimal solution was not found");

		final DoubleMatrix2D x_de = op.getPrimalSolution("x_de").view2D();
		netPlan.setRoutingFromDemandLinkCarriedTraffic(x_de , false , false);

		return "Ok! Total bandwidth consumed in the links: " + netPlan.getVectorLinkCarriedTraffic().zSum(); 
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
