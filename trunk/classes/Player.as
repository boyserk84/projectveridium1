package
{
	
	public class Player
	{
		//The "username" of this player
		private var username:String;
		//The actual name of this player
		private var name:String;
		
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
		private var extraPopCap:int;
		//How many soldiers this player has on hand
		private var soldiers:int;
		//How many workers this player has on hand
		private var workers:int;
		
		//The regiment this player has
		private var regiments:LinkedList;
		
		public Player(var nameIn:String="",var usernameIn:String="")
		{
			username=usernameIn;
			name=nameIn;
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
		
		public function get MoneyCap():int
		{
			return moneyCap;
		}
		
		public function get ExtraMoneyCap():int
		{
			return extraMoneyCap;
		}
		
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
		
		public function get AmountSoldiers():int
		{
			return soldiers;
		}
		
		public function get AmountWorkers():int
		{
			return workers;
		}
		
		public function Regiments():LinkedList
		{
			return regiments;
		}
		
		
		


	}
}