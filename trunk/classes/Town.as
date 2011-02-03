package classes
{
	import flash.geom.Point;
	import flash.display.MovieClip;
	import constant.*;
	
	public class Town extends MovieClip
	{
		
		//District this Town belongs too
		private var myDistrict:District;
		
		//The name of the player who owns this town
		private var owner:String;
		
		//The side this town currently is on
		private var side:int;
		
		
		
		//The player who owns this town

		
		
		//How are we going to do battle?
		
		//How many workers are allocated to this town for resource production
		private var workers:int;
		//How much wood this town produces per tick
		private var woodProduction:int;
		//How much total wood this town is capable of producing
		private var woodCap:int;
		//How much extra capacity this town gives to your city
		private var extraWoodCap:int;
		//How much population this town produces
		private var populationProduction:int;
		//How much population this town is capable of producing
		private var populationCap:int;
		//How much extra population capacity this town gives a city
		private var extraPopCap:int;
		//How much iron this town produces
		private var ironProduction:int;
		//How much iron this town is capable of producing
		private var ironCap:int;
		//How much extra iron capacity this town provides your city
		private var extraIronCap:int;
		//How much food this town produces
		private var foodProduction:int;
		//How much food this town is capable of producing
		private var foodCap:int;
		//How much extra food capacity this town gives you
		private var extraFoodCap:int;
		//How much money in taxes this town produces
		private var moneyProduction:int;
		//The name of this town for identification purposes
		private var myName:String;
		
		//The original Location of this town
		private var myLocation:Point;
		
		//The number of agents in this town, can only be one, may allow more
		private var agents:int;
		//The number of politicians in this town, may allow more
		private var politicians:int;
		
		//The occupying force
		private var occupier:Regiment;
		
		
		public function Town(woodIn:int=0,moneyIn:int=0,popIn:int=0,ironIn:int=0,foodIn:int=0,locationIn:Point=null,nameIn:String="None",ownerIn:String="Renegade")
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
			owner=ownerIn;
			occupier=null;
			side=0;
			agents=0;
			politicians=0;
			this.enabled=false;
			
		}
		
		public function get Wood():int
		{
			return woodProduction;
		}
		public function get WoodCap():int
		{
			return woodCap;
		}
		public function get ExtraWoodCap():int
		{
			return extraWoodCap;
		}
		public function get Money():int
		{
			return moneyProduction;			
		}
		
		public function get Population():int
		{
			return populationProduction;
		}
		
		public function get ExtraPopulationCap():int
		{
			return extraPopCap;
		}
		public function get Food():int
		{
			return foodProduction;
		}
		public function get ExtraFoodCap():int
		{
			return extraFoodCap;
		}
		public function get Iron():int
		{
			return ironProduction;
		}
		public function get ExtraIronCap():int
		{
			return extraIronCap;
		}
		
		public function modifyWorkers(change:int=0):void
		{
			workers+=change;
		}		
		
		public function get Location():Point
		{
			return myLocation;
		}
		
		//The current owner of this Town.  What is the player key for the database going to be, names?
		public function get Owner():String
		{
			return owner;
		}
		
		public function set Owner(value:String):void
		{
			owner=value;
		}
		
		public function get Side():int
		{
			return side;
		}
		
		public function get Name():String
		{
			return myName;
		}
		
		public function get Occupier():Regiment
		{
			return occupier;
		}
		
		public function set Occupier(value:Regiment):void
		{
			occupier=value;
		}
		
		public function removeOccupationAmount(reg:Regiment):void
		{
			if(occupier!=null)
			{
				occupier.removeRegiment(reg);
			}
		}
		
		public function get Workers():int
		{
			return workers;
		}
		
		public function get Agents():int
		{
			return agents;
		}
		public function set Agents(value:int):void
		{
			agents=value;
		}
		public function modifyAgents(value:int):void
		{
			agents+=value;
		}
		public function get Politicians():int
		{
			return politicians;
		}
		public function set Politicians(value:int):void
		{
			politicians=value;
		}
		public function modifyPoliticians(value:int):void
		{
			politicians+=value;
		}
		
		public function get MyDistrict():District
		{
			return myDistrict;
		}
		public function set MyDistrict(value:District):void
		{
			myDistrict=value;
		}
			
		public function conquer(owner:String,sideIn:int):void
		{
			this.owner=owner;
			if(sideIn==GameConfig.BRITISH)
			{
				gotoAndStop(WorldConfig.BRITISH_OCCUPANCY);

			}
			else
			{
				gotoAndStop(WorldConfig.AMERICAN_OCCUPANCY);

			}
			side=sideIn;
			trace(side);
			myDistrict.checkOwnership();
			
		}
		
		public function occupierType(type:int):int
		{
			if(occupier!=null)
			{
				return occupier.totalType(type);
			}
			else
			{
				return 0;
			}
		}
		
		
		
	}
	
	
}
