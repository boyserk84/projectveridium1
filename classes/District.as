package classes
{ 
	import flash.display.MovieClip;
	import flash.geom.Point;
	import constant.WorldConfig;
	import constant.GameConfig;
	
	public class District extends MovieClip
	{
		//The name of this District
		private var myName:String;
		//How many buildings that can be placed into this District
		private var capacity:int;
		//The neighbors of this District, maybe useful? 
		private var neighbors:LinkedList;
		//The cities already in this District
		private var towns:Array;
		//The side that currently owns this district
		private var side:int;
		
		//The current owner of this District
		//private var owner:Player;
		
		//The size of the District, to determine time to pass through?
		private var size:int;
		//The location of the District in world? coordinates
		private var location:Point;
		

		//Constructor
		public function District(capacityIn:int=0,nameIn:String="",locationIn:Point=null,sizeIn:int=0)
		{
			capacity=capacityIn;
			name=nameIn;
			location=locationIn;
			size=sizeIn;
			towns=new Array();
		}
		
		
		public function get Towns():Array
		{
			return towns;
		}
		
		public function set Towns(value:Array):void
		{
			towns=value;
		}
		
		public function addTown(townIn:Town):void
		{
			towns.push(townIn);
		}
		//Property for the name of this District
		public function get Name():String
		{
			return name;
		}
		
		public function get Side():int
		{
			return side;
		}
		
		public function checkOwnership():void
		{
			var currSide=towns[0].Side;
			for(var i:int=1;i<towns.length;++i)
			{

				if(towns[i].side!=currSide)
				{
					gotoAndStop(0);
					return;
				}
				
			}		
			if(currSide==GameConfig.AMERICAN)
			{
				gotoAndStop(WorldConfig.AMERICAN_OCCUPANCY);
				side=GameConfig.AMERICAN;
			}
			else if(currSide==GameConfig.BRITISH)
			{
				gotoAndStop(WorldConfig.BRITISH_OCCUPANCY);
				side=GameConfig.BRITISH;
			}
			else
			{
				gotoAndStop(GameConfig.RENEGADE);
				side=GameConfig.RENEGADE;
			}
		}
		
		
		//Property for the capacity of this District
		public function get Capacity():int
		{
			return capacity;
		}
	}
	
}