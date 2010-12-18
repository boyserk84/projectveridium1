package classes
{
	public class Node
	{
		public var data:*;
		public var next:Node;
		public var prev:Node;
		
		public function Node(dataIn:*)
		{
			data=dataIn;
		}
	}
}