package classes
{
	public class Queue
	{
		
		private var head:Node;
		private var tail:Node;
		private var length:int;
		
		public function Queue()
		{
			head=new Node(null);
			tail=new Node(null);
			tail.prev=head;
			head.prev=null;
			head.next=tail;
			length=0;
		}
		
		public function Enqueue(dataIn:*):void
		{
			var newNode:Node=new Node(dataIn);
			newNode.next=tail;
			tail.prev.next=newNode;
			
			newNode.prev=tail.prev;
			tail.prev=newNode;
			length+=1;
			
		}
		
		public function Dequeue():*
		{
			if(head.next!=null)
			{
				var node=head.next;
				head.next=node.next;
				length-=1;
				return node.data;
			}
			return null;
		}
		
		public function get Length():int
		{
			return length;
		}
		
	}
}