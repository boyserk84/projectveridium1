package classes
{
	public class BFSTree
	{
		private var myRoot:GraphNode;
		private var currNode:GraphNode;
		private var nodes:Queue;
		private var currChild:int;
		
		public function BFSTree(rootIn:GraphNode,nodesIn:Queue)
		{
			myRoot=rootIn;
			myRoot.Parent=null;
			currNode=rootIn;
			nodes=nodesIn;
		}
		
		public function get Root():GraphNode
		{
			return myRoot;
		}
		
		public function addChildren(nodeIn:GraphNode):void
		{
			currNode.Children.push(nodeIn);
			trace(nodeIn.MyTown.Name);
			nodeIn.Parent=currNode;
		}
		
		public function updateCurrent():void
		{
			currNode=nodes.Peek();
		}
		
		//Returns a backwards traversal from this node to the root returns the data, i.e. the towns
		public function backwardsTraversal(nodeIn:GraphNode):Array
		{
			var resultArray:Array=new Array();
			while(nodeIn!==myRoot)
			{
				trace("Finding path!");
				resultArray.push(nodeIn.MyTown);
				nodeIn=nodeIn.Parent;
			}
			resultArray.push(myRoot.MyTown);
			return resultArray.reverse();
		}
		
		
	}
	
}