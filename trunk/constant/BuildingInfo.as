package constant{
	
	
	//A function to has a building type into its requirements
	public class BuildingInfo
	{
		public static function getInfo(buildingType:int):BuildingInfoNode
		{
			var wood:int,iron:int,money:int,population:int, requirement:int;
			var main_type:String;
			//trace("bbbbbbb" + buildingType);
			switch(buildingType)
			{
				case BuildingType.BARRACK:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.TOWN_SQUARE;
					main_type=BuildingType.MIL_TYPE;
				break;
				
				case BuildingType.ARMORY:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.BARRACK;
					main_type=BuildingType.MIL_TYPE;
				break;
				
				case BuildingType.RANGE:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.ARMORY;
					main_type=BuildingType.MIL_TYPE;
				break;
				
				case BuildingType.SNIPER_SCHOOL:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.RANGE;
					main_type=BuildingType.MIL_TYPE;

				break;
				
				case BuildingType.FORGE:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.BARRACK;
					main_type=BuildingType.MIL_TYPE;
				break;
				
				case BuildingType.WORKSHOP:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.FORGE;
					main_type=BuildingType.MIL_TYPE;
				break;
				
				case BuildingType.FOUNDRY:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.WORKSHOP;
					main_type=BuildingType.MIL_TYPE;
				break;
				
				case BuildingType.BOOT_CAMP:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.BARRACK;
					main_type=BuildingType.MIL_TYPE;
				break;
				
				case BuildingType.STABLES:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.BOOT_CAMP;
					main_type=BuildingType.MIL_TYPE;
				break;
				
				case BuildingType.OFFICER_SCHOOL:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.STABLES;
					main_type=BuildingType.MIL_TYPE;
				break;
				
				case BuildingType.OUTPOST:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.BARRACK;
					main_type=BuildingType.MIL_TYPE;
				break;
				
				case BuildingType.WATCH_TOWER:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.RANGE;
					main_type=BuildingType.MIL_TYPE;
				break;
				
				case BuildingType.AMBUSH:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.SNIPER_SCHOOL;
					main_type=BuildingType.MIL_TYPE;
				break;
				
				case BuildingType.WAY_POINT:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.STABLES;
					main_type=BuildingType.MIL_TYPE;
				break;
				
				case BuildingType.HOUSE:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.TOWN_SQUARE;
					main_type=BuildingType.CIVIL_TYPE;
				break;
				
				case BuildingType.FARM:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.TOWN_SQUARE;
					main_type=BuildingType.CIVIL_TYPE;
				break;
				case BuildingType.SAWMILL:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.TOWN_SQUARE;
					main_type=BuildingType.CIVIL_TYPE;
				break;
				case BuildingType.BLACKSMITH:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.TOWN_SQUARE;
					main_type=BuildingType.CIVIL_TYPE;
				break;
				case BuildingType.WAREHOUSE:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.FARM;
					main_type=BuildingType.CIVIL_TYPE;
				break;
				case BuildingType.STOCKPILE:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.WAREHOUSE;
					main_type=BuildingType.CIVIL_TYPE;
				break;
				case BuildingType.MARKET:
					wood=10;
					iron=0;
					money=0;
					population=0;
					requirement=BuildingType.WAREHOUSE;
					main_type=BuildingType.CIVIL_TYPE;
				break; 
				
				default:
					wood=0;
					iron=0;
					money=0;
					population=0;
					requirement=0;
					main_type=BuildingType.CIVIL_TYPE;
				break;
			} //End of the giant switch statement
			
			//trace("ddd" + requirement);
			return new BuildingInfoNode(wood,iron,population,money,requirement,main_type);
		} //End of getInfo() function
		
		
	}
}