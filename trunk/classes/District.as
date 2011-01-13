package classes
{ 
	import flash.geom.Point;
	
	public class District
	{
		//The name of this District
		private var name:String;
		//How many buildings that can be placed into this District
		private var capacity:int;
		//The neighbors of this District, maybe useful? 
		private var neighbors:LinkedList;
		//The cities already in this District
		private var towns:LinkedList;
		
		//The current owner of this District
		//private var owner:Player;
		
		//The size of the District, to determine time to pass through?
		private var size:int;
		//The location of the District in world? coordinates
		private var location:Point;
		

		//Constructor
		public function District(capacityIn:int=0,nameIn:String="",locationIn:Point=null,townsIn:LinkedList=null,sizeIn:int=0)
		{
			capacity=capacityIn;
			name=nameIn;
			location=locationIn;
			size=sizeIn;
			towns=townsIn;
		}
		
		
		public function get Towns():LinkedList
		{
			return towns;
		}
		
		public function set Towns(value:LinkedList):void
		{
			towns=value;
		}
		//Property for the name of this District
		public function get Name():String
		{
			return name;
		}
		
		//Property for the capacity of this District
		public function get Capacity():int
		{
			return capacity;
		}
	}
	
}