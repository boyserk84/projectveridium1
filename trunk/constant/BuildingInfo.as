package constant{
	
	//A function to has a building type into its requirements
	public class BuildingInfo
	{
		public static function getInfo(buildingType:int):BuildingInfoNode
		{
			private var wood,iron,money,population;
			
			switch(buildingType)
			{
				case BuildingType.BARRACK:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.TOWN_SQUARE;
				break;
				
				case BuildingType.ARMORY:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.BARRACK;
				break;
				
				case BuildingType.RANGE:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.ARMORY;
				break;
				
				case BuildingType.SNIPER_SCHOOL:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.RANGE;

				break;
				
				case BuildingType.FORGE:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.BARRACK;
				break;
				
				case BuildingType.WORKSHOP:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.FORGE;
				break;
				
				case BuildingType.FOUNDRY:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.WORKSHOP;
				break;
				
				case BuildingType.BOOT_CAMP:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.BARRACK;
				break;
				
				case BuildingType.STABLES:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.BOOT_CAMP;
				break;
				
				case BuildingType.OFFICER_SCHOOL:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.STABLES;
				break;
				
				case BuildingType.OUTPOST:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.BARRACK;
				break;
				
				case BuildingType.WATCH_TOWER:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.RANGE;
				break;
				
				case BuildingType.AMBUSH:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.SNIPER_SCHOOL;
				break;
				
				case BuildingType.WAY_POINT:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.STABLES;
				break;
				
				case BuildingType.HOUSE:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.TOWN_SQUARE;
				break;
				
				case BuildingType.FARM:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.TOWN_SQUARE;
				break;
				case BuildingType.SAWMILL:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.TOWN_SQUARE;
				break;
				case BuildingType.BLACKSMITH:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.TOWN_SQUARE;
				break;
				case BuildingType.WAREHOUSE:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.FARM;
				break;
				case BuildingType.STOCKPILE:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.WAREHOUSE;
				break;
				case BuildingType.MARKET:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.WAREHOUSE;
				break; 
				
				default:
					wood=0;
					iron=0;
					money=0;
					population=0;
					requirement=0;
				break;
			} //End of the giant switch statement
			
			return new BuildingInfoNode(wood,iron,population,money);
		} //End of getInfo() function
		
		
	}
}