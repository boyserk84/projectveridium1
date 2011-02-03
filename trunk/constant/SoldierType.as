package constant{
	
	/**
	* SoldierType
	* This class handle information related to population unit such as worker and soldier.
	*/
	public class SoldierType
	{
		// Constant Soldier & Worker Type


		public static const NONE:int=0;
		public static const WORKER:int=1;

		public static const MINUTEMAN:int=2;
		public static const SHARPSHOOTER:int=3;
		public static const OFFICER:int=4;
		public static const CALVARY:int=5;
		public static const CANNON:int=6;
		public static const SCOUT:int=7;
		public static const AGENT:int=8;
		public static const POLITICIAN:int=9;
		
		public static const TOTAL_SOLDIERS_TYPE:int = 8;
		
		public static const CITY_REGIMENT_INDEX:int = 0;

		
		/**
		* Check if there are enough resources to train this unit
		* @param money: Money you have
		* @param wood: Wood you have
		* @param iron: Iron you have
		* @param food: Food you have
		* @param soldierType: Type of soldier that needs to be trained
		*/
		public static function enoughToTrain(money:int, wood:int, iron:int, food:int, soldierType:int):Boolean
		{
			var node:SoldierInfoNode = getSoldierInfo(soldierType);
			if (money - node.Money < 0) return false;
			if (wood - node.Wood < 0) return false;
			if (iron - node.Iron < 0) return false;
			if (food - node.Food < 0) return false;
			
			return true;
			
		}
		
		/**
		* return what resource need in case of insufficient resources
		* @param money: Money you have
		* @param wood: Wood you have
		* @param iron: Iron you have
		* @param food: Food you have
		* @return String indicating which resource is insufficient
		*/
		public static function resourceNeed(money:int, wood:int, iron:int, food:int, soldierType:int):String
		{
			var node:SoldierInfoNode = getSoldierInfo(soldierType);
			if (money - node.Money < 0) return "Money";
			if (wood - node.Wood < 0) return "Wood";
			if (iron - node.Iron < 0) return "Iron";
			if (food - node.Food < 0) return "Food";
			
			return "";
		}

		public static function getSoldierInfo(soldierType:int):SoldierInfoNode
		{
			var weapon:int;
			var armor:int;
			var skill:int;
			var requirement:int;	// Building needed to be built before enable
			var type:int;
			var food:int, money:int, wood:int, iron:int;
			
			switch(soldierType)
			{
				case MINUTEMAN:
				{
					weapon=1;
					armor=3;
					skill=1;
					requirement=BuildingType.BARRACK;
					food=1;
					money=1;
					wood=1;
					iron=1;
					break;
				}
				
				case SHARPSHOOTER:
				{
					weapon=10;
					armor=1;
					skill=1;
					requirement=BuildingType.RANGE;
					food=5;
					money=1;
					wood=1;
					iron=1;
					break;
				}
				
				case OFFICER:
				{
					weapon=1;
					armor=1;
					skill=10;
					requirement=BuildingType.OFFICER_SCHOOL;
					food=5;
					money=1;
					wood=1;
					iron=1;
					break;
				}
				case CALVARY:
				{
					weapon=5;
					armor=5;
					skill=3;
					requirement = BuildingType.STABLES;
					food=5;
					money=1;
					wood=1;
					iron=1;
					break;
				}
				case CANNON:
				{
					weapon=10;
					armor=5;
					skill=1;
					requirement = BuildingType.WORKSHOP;
					food=5;
					money=1;
					wood=1;
					iron=1;
					break;
				}
				case SCOUT:
				{
					weapon=10;
					armor=10;
					skill=1;
					requirement = BuildingType.BOOT_CAMP;
					food=5;
					money=1;
					wood=1;
					iron=1;
					break;
				}
				case AGENT:
				{
					weapon=10;
					armor=10;
					skill=10;
					requirement= BuildingType.SNIPER_SCHOOL;
					food=5;
					money=1;
					wood=1;
					iron=1;
					break;
				}
				
				case POLITICIAN:
				{
					weapon=10;
					armor=10;
					skill=10;
					requirement = BuildingType.FOUNDRY;
					food=5;
					money=1;
					wood=1;
					iron=1;
					break;
				}
				
				case WORKER:
				{
					weapon=10;
					armor=10;
					skill=10;
					weapon=0;
					armor=0;
					skill=0;
					requirement=BuildingType.TOWN_SQUARE;
					food=5;
					money=1;
					wood=1;
					iron=1;
					break;
				}
			}
			return new SoldierInfoNode(weapon,armor,skill,requirement,soldierType, food, money, wood, iron);

		}
		
		
		
	}
}