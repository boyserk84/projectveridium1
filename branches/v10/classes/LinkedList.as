package classes
{
	public class LinkedList
	{
		private var head:Node;
		private var tail:Node;
		private var length:int;
		
		public function LinkedList()
		{
			head=new Node(null);
			tail=new Node(null);
			head.next=tail;
			head.prev=null;
			tail.prev=head;
			tail.next=null;
			length=0;
		}
		
		/*
		* Add a node to the end of the list
		* @param1: objIn - The object to be added to the list
		*/
		public function Add(objIn:*):void
		{
			var node:Node=new Node(objIn);
			
			node.prev=tail.prev;
			tail.prev.next=node;
			tail.prev=node;
			node.next=tail;
			length+=1;
		}
		
		
		
		/*
		* Removes and item from the list and returns it, comparison through strict equality
		* @param1: objIn - The object to be removed
		*/
		public function Remove(objIn:*):*
		{
			var node:Node=head;
			trace("Trying to remove from the list");
			while(node!=null)
			{

				if(node.data===objIn)
				{
					trace("Found what were looking for!");
					node.prev.next=node.next;
					node.next.prev=node.prev;
					length-=1;
					return node;
				}
				else
				{
					node=node.next;
				}
			}
			return null;
			
		}

	
		/*
		* Returns the object at a specific index
		* @param1: index - Index to find
		*/
		public function Get(index:int):*
		{
			var currIndex:int=-1;
			var currNode:Node=head;
			while(currIndex!=index&&currNode!=null)
			{
				currNode=currNode.next;
				currIndex+=1;
			}
			return currNode;
		}
		
		/*
		* Length of the list
		*/
		public function get Length():int
		{
			return length;
		}
	
	}
	
	
}