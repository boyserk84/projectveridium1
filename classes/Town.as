package classes
{
	import flash.geom.Point;
	import flash.display.MovieClip;
	
	public class Town extends MovieClip
	{
		
		//District this Town belongs too
		private var myDistrict:District;
		
		
		
		
		
		//The player who owns this town
	//		private var owner:Player;
		
		
		//How are we going to do battle?
		
		//How many workers are allocated to this town for resource production
		private var workers:int;
		//How much wood this town produces per tick
		private var woodProduction:int;
		//How much stone this town produces per tick
		private var stoneProduction:int;
		//How much population this town produces
		private var populationProduction:int;
		//How much iron this town produces?
		private var ironProduction:int;
		//How much food this town produces
		private var foodProduction:int;
		//How much money in taxes this town produces
		private var moneyProduction:int;
		//The name of this town for identification purposes
		private var myName:String;
		
		//The original Location of this town
		private var myLocation:Point;
		
		public function Town(woodIn:int=0,moneyIn:int=0,popIn:int=0,ironIn:int=0,foodIn:int=0,locationIn:Point=null,nameIn:String="None")
		{
			workers=0;
			woodProduction=woodIn;
			moneyProduction=moneyIn;
			populationProduction=popIn;
			ironProduction=ironIn;
			foodProduction=foodIn;
			this.x=locationIn.x;
			this.y=locationIn.y;
			myLocation=locationIn;
			myName=nameIn;
			
		}
		
		public function get Wood():int
		{
			return woodProduction;
		}
		
		public function get Money():int
		{
			return moneyProduction;			
		}
		
		public function get Population():int
		{
			return populationProduction;
		}
		public function get Food():int
		{
			return foodProduction;
		}
		public function get Iron():int
		{
			return ironProduction;
		}
		
		public function modifyWorkers(change:int=0):void
		{
			workers+=change;
		}		
		
		public function get Location():Point
		{
			return myLocation;
		}
		
		public function get Name():String
		{
			return myName;
		}
			
		
	}
	
	
}
