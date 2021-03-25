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
import com.net2plan.utils.Triple;
import com.net2plan.utils.Constants.RoutingType;

import cern.colt.matrix.tdouble.DoubleMatrix1D;
import cern.colt.matrix.tdouble.DoubleMatrix2D;

/** This is a template to be used in the lab work, a starting point for the students to develop their programs
 * 
 */
public class p10Quiz2 implements IAlgorithm
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
		final double maximumLinkCapacity = Double.parseDouble (algorithmParameters.get ("maximumLinkCapacity")); 
		final double capacityModule = Double.parseDouble (algorithmParameters.get ("capacityModule")); 
		final double costPerGbps = Double.parseDouble (algorithmParameters.get ("costPerGbps")); 
		final double costPerKm = Double.parseDouble (algorithmParameters.get ("costPerKm")); 
		
		/* Remove all the network links */
		netPlan.removeAllLinks ();

		/* Set the routing type as source routing */
		netPlan.setRoutingType(RoutingType.SOURCE_ROUTING);
		
		/* Create a full-mesh of links between all nodes, of capacity 0 */
		for (Node n1 : netPlan.getNodes())
			for (Node n2 : netPlan.getNodes())
				if (n1 != n2)
					netPlan.addLink(n1,n2,0,netPlan.getNodePairEuclideanDistance(n1,n2),200000,null);
		
		final int D = netPlan.getNumberOfDemands();
		final int Efm = netPlan.getNumberOfLinks ();

		/* Create the optimization problem */
		OptimizationProblem op = new OptimizationProblem ();
		
		op.addDecisionVariable("x_de" , false , new int [] {D , Efm } , 0 , Double.MAX_VALUE);
		op.addDecisionVariable("a_e" , true , new int [] {1 , Efm } , 0 , maximumLinkCapacity / capacityModule);
		op.addDecisionVariable("z_e" , true , new int [] {1 , Efm } , 0 , 1);

		op.setInputParameter("d_e" , netPlan.getVectorLinkLengthInKm() , "row");
		op.setInputParameter("c_km" , costPerKm);
		op.setInputParameter("c_Gbps" , costPerGbps);
		
		/* Set the objective function */
		op.setInputParameter("C" , capacityModule);
		op.setObjectiveFunction("minimize" , "c_km * d_e * z_e' + c_Gbps * C * sum(a_e)"); 
		
		/* Add the constraints that make the capacity of a link be zero if it does not exist, and be limited to U 
		 * if it exists */
		op.setInputParameter("U" , maximumLinkCapacity);
		for (Link e  : netPlan.getLinks())
		{
			op.setInputParameter("e" , e.getIndex());
			op.addConstraint("C * a_e(e) <= U * z_e(e)");
		}
		
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
			op.addConstraint ("sum(x_de(all,e)) <= C * a_e(e)");
		}

		/* call the solver to solve the problem */
//		op.solve ("glpk" , "maxSolverTimeInSeconds" , 10);
		op.solve ("glpk" , "solverLibraryName" , "c:\\glpk.dll" , "maxSolverTimeInSeconds" , 10);
		
		/* An optimal solution was not found */
		if (!op.solutionIsFeasible()) 
			throw new Net2PlanException ("A feasible solution was not found");

		/* Set the routing according to the optimum solutions */
		final DoubleMatrix2D x_de = op.getPrimalSolution("x_de").view2D();
		netPlan.setRoutingFromDemandLinkCarriedTraffic(x_de , false , false);

		/* Set the capacity in the links according to the a_e variables */
		final double [] a_e = op.getPrimalSolution("a_e").to1DArray();
		for (Link e : netPlan.getLinks())
			e.setCapacity(capacityModule * a_e [e.getIndex()]);
		
		/* Remove all the links that have not capacity */
		netPlan.removeAllLinksUnused(0.01);
		
		return "Ok! Optimal solution found: " + op.solutionIsOptimal() + ", Number of links " + netPlan.getNumberOfLinks() + ", total capacity installed: " + netPlan.getVectorLinkCapacity().zSum(); 
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
		param.add (Triple.of ("maximumLinkCapacity" , "1000" , "The maximum capacity allowed for a link between two nodes."));
		param.add (Triple.of ("capacityModule" , "10" , "The capacity of one capacity module (link capacities have to be a multiple of this)."));
		param.add (Triple.of ("costPerGbps" , "1" , "The cost per Gbps of capacity in any link."));
		param.add (Triple.of ("costPerKm" , "1" , "The cost per km in any link."));
		return param;
	}
}
