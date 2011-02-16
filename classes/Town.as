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
		
		//The GraphNode this town belongs too for starting BFS
		private var graphNode:GraphNode;

		
		//How many workers are allocated to this town for resource production
		private var workers:int;
		//How much wood this town produces per tick
		private var woodProduction:int;
		//The unmodified version of how much this town produces
		private var realWood:int;
		//How much total wood this town is capable of producing
		private var woodCap:int;
		//How much extra capacity this town gives to your city
		private var extraWoodCap:int;
		//How much population this town produces
		private var populationProduction:int;
		//The unmodified population value
		private var realPopulation:int;
		//How much population this town is capable of producing
		private var populationCap:int;
		//How much extra population capacity this town gives a city
		private var extraPopCap:int;
		//How much iron this town produces
		private var ironProduction:int;
		//The unmodified version of how much iron this town produces
		private var realIron:int;
		//How much iron this town is capable of producing
		private var ironCap:int;
		//How much extra iron capacity this town provides your city
		private var extraIronCap:int;
		//How much food this town produces
		private var foodProduction:int;
		//The unmodified version of how much food this town produces
		private var realFood:int;
		//How much food this town is capable of producing
		private var foodCap:int;
		//How much extra food capacity this town gives you
		private var extraFoodCap:int;
		//How much money in taxes this town produces
		private var moneyProduction:int;
		//The unmodified version of how much money this town produces
		private var realMoney:int;
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
		
		//The towns reachable from this town, for the BFS!
		private var neighbors:Array;
		
		private var id:int;	// Townid
		
		
		//wood, money, pop,iron,food
		public function Town(woodIn:int=0,moneyIn:int=0,popIn:int=0,ironIn:int=0,foodIn:int=0,locationIn:Point=null,nameIn:String="None",ownerIn:String="Renegade")
		{
			workers=0;
			woodProduction=woodIn;
			realWood=woodIn;
			moneyProduction=moneyIn;
			realMoney=moneyIn;
			populationProduction=popIn;
			realPopulation=popIn;
			ironProduction=ironIn;
			realIron=ironIn;
			foodProduction=foodIn;
			realFood=foodIn;
			
			//Need to set the caps in constructor!
			foodCap=15;
			ironCap=15;
			woodCap=15;
			
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
			if(woodProduction+Workers>woodCap)
			{
				return woodCap;
			}
			else
			{
				return woodProduction+Workers;
			}
		}
		public function get WoodCap():int{	return woodCap;}
		public function get ExtraWoodCap():int{	return extraWoodCap;}
		public function get Money():int{	return moneyProduction;}
		public function get Population():int{	return populationProduction;}
		public function get ExtraPopulationCap():int{	return extraPopCap;}

		public function get ID():int{ return id;}
		public function set ID(value:int):void{	id=value;}
		public function get Food():int
		{
			if(foodProduction+Workers>foodCap)
			{
				return foodCap;
			}
			else
			{
				return foodProduction+Workers;
			}
		}
		public function get ExtraFoodCap():int{	return extraFoodCap;}
		public function get Iron():int{	
			if(ironProduction+Workers>ironCap)
			{
				return ironCap;
			}
			else
			{
				
				return ironProduction+Workers;
			}
		}
		public function get IronCap():int { return ironCap; }
		public function get ExtraIronCap():int{	return extraIronCap;}
		//The current owner of this Town.  What is the player key for the database going to be, names?
		public function get Owner():String{	return owner;}
		public function set Owner(value:String):void{	owner=value;}
		public function get Side():int{	return side;}
		public function set Side(value:int){ side=value;}
		public function get Name():String{	return myName;}
		public function get Occupier():Regiment{	return occupier;}
		public function set Occupier(value:Regiment):void{	occupier=value;
															occupier.TownId=id;}
		
		public function get Workers():int
		{	
			if(occupier!=null)
			{
				return occupier.totalType(SoldierType.WORKER);
			}
			else
			{
		
				return 0;
			}
		}
		public function set Workers(value:int):void{	workers=value;}
		public function get Agents():int{	return agents;}
		public function set Agents(value:int):void{	agents=value;}
		public function get Location():Point{	return myLocation;}
		public function get Politicians():int{	return politicians;}
		public function set Politicians(value:int):void{	politicians=value;}
		public function get MyDistrict():District{	return myDistrict;}
		public function set MyDistrict(value:District):void{	myDistrict=value;}
		public function set Node(value:GraphNode):void{	graphNode=value;}
		public function get Node():GraphNode{	return graphNode;}
		
		public function modifyWorkers(change:int=0):void
		{
			workers+=change;
		}		
		
		public function removeOccupationAmount(reg:Regiment):void
		{
			if(occupier!=null)
			{
				occupier.removeRegiment(reg);
			}
		}
		
		public function setGraphic(frameIn:int):void
		{
			gotoAndStop(frameIn);
		}
		
		
		public function modifyAgents(value:int):void
		{
			if(agents==0)
			{
				underAgent();
			}
			agents+=value;
			if(agents==0)
			{
				removeAgent();
			}
		}
		
		public function removeAgent():void
		{
			woodProduction=realWood;
			ironProduction=realIron;
			moneyProduction=realMoney;
			populationProduction=realPopulation;
		}
		
		public function underAgent():void
		{
			woodProduction=woodProduction/2;
			ironProduction=ironProduction/2;
			moneyProduction=moneyProduction/2;
			populationProduction=populationProduction/2;
		}
		public function modifyPoliticians(value:int):void
		{
			politicians+=value;
		}
			
		public function conquer(owner:String,sideIn:int):void
		{
			this.owner=owner;
			side=sideIn;
			occupationGraphic();
			trace(side);
			//myDistrict.checkOwnership();
			
		}
		
		//Changes the graphic to be whatever side is occupying this town
		public function occupationGraphic():void
		{
			if(side==GameConfig.BRITISH)
			{
				gotoAndStop(WorldConfig.BRITISH_OCCUPANCY);

			}
			else if(side==GameConfig.AMERICAN)
			{
				gotoAndStop(WorldConfig.AMERICAN_OCCUPANCY);

			}
			else
			{
				gotoAndStop(0);
			}
		}
		
		public function cityGraphic():void
		{
			if(side==GameConfig.BRITISH)
			{
				gotoAndStop(WorldConfig.BRITISH_CITY);

			}
			else if(side==GameConfig.AMERICAN)
			{
				gotoAndStop(WorldConfig.AMERICAN_CITY);

			}
			else
			{
				gotoAndStop(0);
			}
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
		
		//Adds a reference of a town to the neighbors list
		public function addNeighbor(town:Town):void
		{
			neighbors.add(town);
		}
		
		
		
	}
	
	
}
