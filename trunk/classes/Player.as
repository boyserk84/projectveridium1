package classes {
	
	public class Player
	{
		//The "username" of this player
		private var username:String;
		//The actual name of this player
		private var myName:String;
		//The city belonging to this player
		private var city:City;
		
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
		
		//The regiment this player has
		private var regiments:LinkedList;
		
		public function Player(nameIn:String="",usernameIn:String="")
		{
			username=usernameIn;
			myName=nameIn;
			regiments=new LinkedList();
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
		
		public function set Wood(value:int)
		{
			wood = value;
		}
		public function set WoodCap(value:int)
		{
			woodCap = value;
		}
		
		public function set Iron(value:int)
		{
			iron=value;
		}
		
		public function set IronCap(value:int)
		{
			ironCap=value;
		}
		
		public function set ExtraIronCap(value:int)
		{
			extraIronCap=value;
		}
		
		public function set Money(value:int)
		{
			 money=value;
		}
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
		public function set Food(value:int)
		{
			 food=value;
		}
		
		public function set FoodCap(value:int)
		{
			 foodCap=value;
		}
		
		public function set ExtraFoodCap(value:int)
		{
			 extraFoodCap=value;
		}
		
		public function set Population(value:int)
		{
			 population=value;
		}
		
		public function set PopulationCap(value:int)
		{
			 populationCap=value;
		}
		
		public function set ExtraPopulationCap(value:int)
		{
			 extraPopulationCap=value;
		}
		
		public function get AmountSoldiers():int
		{
			return soldiers;
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
		
		public function changeWood(value:int)
		{
			wood += value;
		}
		
		public function changeIron(value:int)
		{
			iron += value;
		}
		
		public function changeMoney(value:int)
		{
			money += value;
		}
		
		public function changePop(value:int)
		{
			population += value;
		}
		
		public function changeFood(value:int)
		{
			food += value;
		}
		


	}
}