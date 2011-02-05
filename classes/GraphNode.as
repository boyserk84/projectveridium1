package classes
{
	
	//A utility class for the usage of the BFS and making it fast
	public class GraphNode
	{
		private var neighbors:Array;
		private var myTown:Town;
		private var visited:Boolean;
		private var myParent:GraphNode;
		private var children:Array;
		
		public function GraphNode()
		{
			neighbors=new Array();
		}
		
		public function set MyTown(value:Town):void
		{
			myTown=value;
		}
		
		public function get MyTown():Town
		{
			return myTown;
		}
		
		public function pushNeighbor(nodeIn:GraphNode):void
		{
			neighbors.push(nodeIn);
		}
		
		public function popNeighbor():GraphNode
		{
			return neighbors.pop();
		}
		
		public function get Neighbors():Array
		{
			return neighbors;
		}
		
		public function get Visited():Boolean
		{
			return visited;
		}
		public function set Visited(value:Boolean):void
		{
			visited=value;
		}
		
		public function get Children():Array
		{
			return children;
		}
		
		public function set Children(value:Array):void
		{
			children=value;
		}
		
		public function get Parent():GraphNode
		{
			return myParent;
		}
		
		public function set Parent(value:GraphNode)
		{
			myParent=value;
		}
		
		
		
		
	}
}