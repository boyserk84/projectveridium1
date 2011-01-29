﻿package classes {
	import constant.BuildingType;
	
	public class Player
	{
		//The "username" of this player
		private var username:String;
		//The actual name of this player
		private var myName:String;
		//The city belonging to this player
		private var city:City;
		
		//The side this player is on
		private var side:int;
		
		//How much wood this player has on hand
		private var wood:int;
		//The current wood capacity this player's tech level allows
		private var woodCap:int;
		//The extra wood capacity this player's towns provide
		private var extraWoodCap:int;
		
		//How much iron this player has on hand
		private var iron:int;
		//The current iron capacity this player's tech level allows
		private var ironCap:int;
		//The extra iron capacity this player's towns provide
		private var extraIronCap:int;
		
		
		//How much food this player has on hand
		private var food:int;
		//The current food capacity this player's tech level allows
		private var foodCap:int;
		//The extra food capacity this player's towns provide
		private var extraFoodCap:int;
		
		//How much money this player has on hand, there is no cap on money
		private var money:int;

		
		
		//How much population this player has on hand
		private var population:int;
		//The current population capacity this player's housing provides
		private var populationCap:int;
		//The extra population capacity this player's towns provide
		private var extraPopulationCap:int;
		
		
		//How many soldiers this player has on hand
		private var soldiers:int;
		//How many workers this player has on hand
		private var workers:int;
		
		//The towns you own
		private var towns:LinkedList;
		private var total_towns:int;		// Number of towns you currently have
		
		//The regiment this player has
		private var regiments:LinkedList;
		
		public function Player(nameIn:String="",usernameIn:String="",sideIn:int=1)
		{
			username=usernameIn;
			myName=nameIn;
			regiments=new LinkedList();
			regiments.Add(new Regiment("",nameIn,sideIn));
			side=sideIn;
			total_towns = 0;
			towns = new LinkedList();
			populationCap = BuildingType.POP_CAP_INIT;
			foodCap = BuildingType.FOOD_CAP_INIT;
			ironCap = BuildingType.IRON_CAP_INIT;
			woodCap = BuildingType.WOOD_CAP_INIT;
		}
		
		public function get Name():String
		{
			return username;
		}
		
		public function addCity(city:City):void
		{
			this.city = city;
		}
		
		public function get Wood():int
		{
			return wood;
		}
		
		public function get WoodCap():int
		{
			return woodCap;
		}
		
		public function get ExtraWoodCap():int
		{
			return extraWoodCap;
		}
		
		
		public function get Iron():int
		{
			return iron;
		}
		
		public function get IronCap():int
		{
			return ironCap;
		}
		
		public function get ExtraIronCap():int
		{
			return extraIronCap;
		}
		
		public function get Money():int
		{
			return money;
		}
		
		public function getCity():City
		{
			return city;
		}
		/*
		public function get MoneyCap():int
		{
			return moneyCap;
		}
		
		public function get ExtraMoneyCap():int
		{
			return extraMoneyCap;
		}
		*/
		public function get Food():int
		{
			return food;
		}
		
		public function get FoodCap():int
		{
			return foodCap;
		}
		
		public function get ExtraFoodCap():int
		{
			return extraFoodCap;
		}
		
		public function get Population():int
		{
			return population;
		}
		
		public function get PopulationCap():int
		{
			return populationCap;
		}
		
		public function get ExtraPopulationCap():int
		{
			return extraPopulationCap;
		}
		
		public function set Wood(value:int) { wood = value; }
		public function set WoodCap(value:int){ woodCap = value;}
		public function set Iron(value:int) { iron=value; }
		public function set IronCap(value:int) { ironCap=value;}
		public function set ExtraIronCap(value:int){ extraIronCap=value; }
		public function set Money(value:int) { money=value;}
		/*
		public function set MoneyCap(value:int)
		{
			 moneyCap=value;
		}
		
		public function set ExtraMoneyCap(value:int)
		{
			 extraMoneyCap=value;
		}
		*/
		public function set Food(value:int) { food = value;}
		public function set FoodCap(value:int) { foodCap=value;}
		public function set ExtraFoodCap(value:int) { extraFoodCap=value; }
		public function set Population(value:int){ population=value; }
		public function set PopulationCap(value:int){ populationCap=value; }
		public function set ExtraPopulationCap(value:int){ extraPopulationCap=value;}
		
		public function get AmountSoldiers():int
		{
			return soldiers;
		}
		
		public function changeSoldiers(value:int):void
		{
			if (soldiers+value >= 0 && soldiers+value+population <= populationCap){
				soldiers += value;
			} 
		}
		
		public function changeWorkers(value:int):void
		{
			if (value+workers >= 0 && value+workers+population <= populationCap){
				workers +=value;
			}
		}
		
		public function get AmountWorkers():int
		{
			return workers;
		}
		
		public function get Regiments():LinkedList
		{
			return regiments;
		}
		
		public function addRegiment(regimentIn:Regiment):void
		{
			regiments.Add(regimentIn);
		}
		
		public function removeRegiment(regimentIn:Regiment):Regiment
		{
			return regiments.Remove(regimentIn);
			
		}
		
		/**
		* Add and reclaim town
		*/
		public function addTown(newTown:Town):void
		{
			towns.Add(newTown);
			towns.Get(towns.Length-1).data.conquer(username,side);
		}
		
		/**
		* Remove/Pop Town from the LinkedLiist
		* @return the town to be reclaimed by other who conquered it
		*/
		public function removeTown(removeTown:Town):Town
		{
			return towns.Remove(removeTown);
		}
		
		/**
		* Add a soldier to main regiment
		* @param: unit Soldier object
		*/
		public function addSoldierToRegiment(unit:Soldier):void
		{
			Regiments.Get(0).data.addUnit(unit);
		}
		
		/**
		* Remove a soldier from main regiment
		* @param unit Soldier to be removed
		*/
		public function removeSoldierFromRegiment(unit:Soldier):void
		{
			Regiments.Get(0).data.removeUnit(unit);
		}
		
		public function changeWood(value:int)
		{
			if (wood + value < WoodCap)
			wood += value;
			else wood = WoodCap;
		}
		
		public function changeIron(value:int)
		{
			if (iron + value < IronCap)
			iron += value;
			else iron = IronCap;
		}
		
		public function changeMoney(value:int)
		{
			money += value;
		}
		
		public function changePop(value:int)
		{
			if (population + value < PopulationCap)
			population += value;
			else population = PopulationCap;
		}
		
		public function changeFood(value:int)
		{
			if (food + value < FoodCap)
			food += value;
			else food = FoodCap;
		}
		
		public function changeExtraFoodCap(value:int)
		{
			if (extraFoodCap + value >=0) extraFoodCap += value;
		}
		
		public function changeExtraWoodCap(value:int)
		{ 
			if (extraWoodCap + value >=0) extraWoodCap += value;
		}
		
		public function changeExtraIronCap(value:int)
		{ 
			if (extraIronCap + value >=0) extraIronCap += value;
		}
		
		public function changeExtraPop(value:int)
		{ 
			if (extraPopulationCap + value >=0) extraPopulationCap += value;
		}
		
		public function get Side():int
		{
			return side;
		}
		
		/**
		* return available population (Commoners)
		*/
		public function get AvailablePop():int
		{
			return Population - (AmountSoldiers + AmountWorkers);
		}
		
		/**
		* Update maximum capacity of all resources
		*/
		public function updateResourcesCapacity()
		{
			updateAllTownCapacity();
			FoodCap = BuildingType.FOOD_CAP_INIT + city.ExtraStorage + extraFoodCap;
			WoodCap = BuildingType.WOOD_CAP_INIT + city.ExtraStorage + extraWoodCap; 
			IronCap = BuildingType.IRON_CAP_INIT + city.ExtraStorage + extraIronCap;
			populationCap = BuildingType.POP_CAP_INIT + city.ExtraPop + extraPopulationCap;
		}
		
		/*
		* Returns the total amount of a certain type of unit this player has
		*/
		public function soldierAmount(type:int):int
		{
			var total:int=0;
			for(var i:int=0;i<regiments.Length;++i)
			{
				total+=regiments.Get(i).data.totalType(type);
			}
			return total;
		}
		
		/**
		* Update all towns' capacity
		*/
		private function updateAllTownCapacity():void
		{
			var w_cap:int, i_cap:int, f_cap:int, p_cap:int;
			for (var i:int = 0; i < towns.Length ;++i)
			{
				w_cap += towns.Get(i).data.WoodCap;
				i_cap += towns.Get(i).data.IronCap;
				f_cap += towns.Get(i).data.FoodCap;
				p_cap += towns.Get(i).data.ExtraPopulationCap;
			}
			extraWoodCap = w_cap;
			extraIronCap = i_cap;
			extraFoodCap = f_cap;
			extraPopulationCap = p_cap;
		}
		
		/**
		* Update all towns' resources
		*/
		private function updateAllTownResources():void
		{
			var w:int,i:int,f:int,p:int;
			for (var i:int = 0; i < towns.Length ;++i)
			{
				w += towns.Get(i).data.Wood;
				i += towns.Get(i).data.Iron;
				f += towns.Get(i).data.Food;
				p += towns.Get(i).data.Population;
			}
			changeWood(w);
			changeIron(i);
			changeFood(f);
			changePop(p);
		}
		
		


	}
}