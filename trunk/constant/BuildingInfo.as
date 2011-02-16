package constant{
	
	
	//A function to has a building type into its requirements
	public class BuildingInfo
	{
		
		/**
		* get a building's name in String format
		* @param type: Building Type
		* @return Name in string format corresponding to the building type
		*/
		public static function getBuildingName(type:int):String
		{
			switch (type)
			{
				case BuildingType.BARRACK:
					return BuildingType.N_BARRACK;
				break;
				
				case BuildingType.ARMORY:
					return BuildingType.N_ARMORY;
				break;
				
				case BuildingType.RANGE:
					return BuildingType.N_RANGE;
				break;
				
				case BuildingType.SNIPER_SCHOOL:
					return BuildingType.N_SNIPER_SCHOOL
				break;
				
				case BuildingType.FORGE:
					return BuildingType.N_FORGE;
				break;
				
				case BuildingType.WORKSHOP:
					return BuildingType.N_WORKSHOP;
				break;
				
				case BuildingType.FOUNDRY:
					return BuildingType.N_FOUNDRY;
				break;
				
				case BuildingType.BOOT_CAMP:
					return BuildingType.N_BOOT_CAMP;
				break;
				
				case BuildingType.STABLES:
					return BuildingType.N_STABLES;
				break;
				
				case BuildingType.OFFICER_SCHOOL:
					return BuildingType.N_OFFICER_SCHOOL;
				break;
				
				case BuildingType.OUTPOST:
					return BuildingType.N_OUTPOST;
				break;
				
				case BuildingType.WATCH_TOWER:
					return BuildingType.N_WATCH_TOWER;
				break;
				
				case BuildingType.AMBUSH:
					return BuildingType.N_AMBUSH;
				break;
				
				case BuildingType.WAY_POINT:
					return BuildingType.N_WAY_POINT;
				break;
				
				case BuildingType.HOUSE:
					return BuildingType.N_HOUSE;
				break;
				
				case BuildingType.FARM:
					return BuildingType.N_FARM;
				break;
				case BuildingType.SAWMILL:
					return BuildingType.N_SAWMILL;
				break;
				case BuildingType.BLACKSMITH:
					return BuildingType.N_BLACKSMITH;
				break;
				case BuildingType.WAREHOUSE:
					return BuildingType.N_WAREHOUSE;
				break;
				case BuildingType.STOCKPILE:
					return BuildingType.N_STOCKPILE;
				break;
				case BuildingType.MARKET:
					return BuildingType.N_MARKET;
				break; 
				
				case BuildingType.TOWN_SQUARE:
					return BuildingType.N_TOWN_SQUARE;
				break;
				
				default:
					return "NONE";
				break;
			}
		}
		
		/**
		* get a building's description of what it does
		* @param type: Building Type
		* @return description of building
		*/
		public static function getDescription(type:int):String
		{
			switch (type)
			{
				case BuildingType.BARRACK:
					return BuildingType.D_BARRACK;
				break;
				
				case BuildingType.ARMORY:
					return BuildingType.D_ARMORY;
				break;
				
				case BuildingType.RANGE:
					return BuildingType.D_RANGE;
				break;
				
				case BuildingType.SNIPER_SCHOOL:
					return BuildingType.D_SNIPER_SCHOOL
				break;
				
				case BuildingType.FORGE:
					return BuildingType.D_FORGE;
				break;
				
				case BuildingType.WORKSHOP:
					return BuildingType.D_WORKSHOP;
				break;
				
				case BuildingType.FOUNDRY:
					return BuildingType.D_FOUNDRY;
				break;
				
				case BuildingType.BOOT_CAMP:
					return BuildingType.D_BOOT_CAMP;
				break;
				
				case BuildingType.STABLES:
					return BuildingType.D_STABLES;
				break;
				
				case BuildingType.OFFICER_SCHOOL:
					return BuildingType.D_OFFICER_SCHOOL;
				break;
				
				case BuildingType.OUTPOST:
					return BuildingType.D_OUTPOST;
				break;
				
				case BuildingType.WATCH_TOWER:
					return BuildingType.D_WATCH_TOWER;
				break;
				
				case BuildingType.AMBUSH:
					return BuildingType.D_AMBUSH;
				break;
				
				case BuildingType.WAY_POINT:
					return BuildingType.D_WAY_POINT;
				break;
				
				case BuildingType.HOUSE:
					return BuildingType.D_HOUSE;
				break;
				
				case BuildingType.FARM:
					return BuildingType.D_FARM;
				break;
				case BuildingType.SAWMILL:
					return BuildingType.D_SAWMILL;
				break;
				case BuildingType.BLACKSMITH:
					return BuildingType.D_BLACKSMITH;
				break;
				case BuildingType.WAREHOUSE:
					return BuildingType.D_WAREHOUSE;
				break;
				case BuildingType.STOCKPILE:
					return BuildingType.D_STOCKPILE;
				break;
				case BuildingType.MARKET:
					return BuildingType.D_MARKET;
				break; 
				
				case BuildingType.TOWN_SQUARE:
					return BuildingType.D_TOWN_SQUARE;
				break;
				
				default:
					return "NO DESCRIPTION";
				break;
			}
		}
	
	
	
		/**
		* get Information about building type
		* @param buildingType: Type of building (int)
		* @return BuildingInfo Node with information about the specific building type
		*/
		public static function getInfo(buildingType:int):BuildingInfoNode
		{
			var wood:int,iron:int,money:int,population:int, requirement:int;
			var main_type:String;
			var time_sec_build:int; 
			//trace("bbbbbbb" + buildingType);
			switch(buildingType)
			{
				case BuildingType.BARRACK:
					wood=10;
					iron=10;
					money=0;
					population=3;
					requirement=BuildingType.TOWN_SQUARE;
					main_type=BuildingType.MIL_TYPE;
					time_sec_build = BuildingType.SEC_BARRACK;
				break;
				
				case BuildingType.ARMORY:
					wood=20;
					iron=20;
					money=0;
					population=6;
					requirement=BuildingType.BARRACK;
					main_type=BuildingType.MIL_TYPE;
					time_sec_build = BuildingType.SEC_ARMORY;
				break;
				
				case BuildingType.RANGE:
					wood=30;
					iron=30;
					money=0;
					population=18;
					requirement=BuildingType.ARMORY;
					main_type=BuildingType.MIL_TYPE;
					time_sec_build = BuildingType.SEC_RANGE;
				break;
				
				case BuildingType.SNIPER_SCHOOL:
					wood=40;
					iron=40;
					money=0;
					population=23;
					requirement=BuildingType.RANGE;
					main_type=BuildingType.MIL_TYPE;
					time_sec_build = BuildingType.SEC_SNIPER_SCHOOL;
				break;
				
				case BuildingType.FORGE:
					wood=20;
					iron=30;
					money=0;
					population=6;
					requirement=BuildingType.BARRACK;
					main_type=BuildingType.MIL_TYPE;
					time_sec_build = BuildingType.SEC_FORGE;
				break;
				
				case BuildingType.WORKSHOP:
					wood=30;
					iron=40;
					money=0;
					population=18;
					requirement=BuildingType.FORGE;
					main_type=BuildingType.MIL_TYPE;
					time_sec_build = BuildingType.SEC_WORKSHOP;
				break;
				
				case BuildingType.FOUNDRY:
					wood=40;
					iron=45;
					money=0;
					population=23;
					requirement=BuildingType.WORKSHOP;
					main_type=BuildingType.MIL_TYPE;
					time_sec_build = BuildingType.SEC_FOUNDRY;
				break;
				
				case BuildingType.BOOT_CAMP:
					wood=25;
					iron=20;
					money=0;
					population=6;
					requirement=BuildingType.BARRACK;
					main_type=BuildingType.MIL_TYPE;
					time_sec_build = BuildingType.SEC_BOOT_CAMP;
				break;
				
				case BuildingType.STABLES:
					wood=35;
					iron=30;
					money=0;
					population=18;
					requirement=BuildingType.BOOT_CAMP;
					main_type=BuildingType.MIL_TYPE;
					time_sec_build = BuildingType.SEC_STABLES;
				break;
				
				case BuildingType.OFFICER_SCHOOL:
					wood=50;
					iron=40;
					money=0;
					population=23;
					requirement=BuildingType.STABLES;
					main_type=BuildingType.MIL_TYPE;
					time_sec_build = BuildingType.SEC_OFFICER_SCHOOL;
				break;
				
				case BuildingType.OUTPOST:
					wood=30;
					iron=30;
					money=0;
					population=18;
					requirement=BuildingType.BARRACK;
					main_type=BuildingType.MIL_TYPE;
					time_sec_build = BuildingType.SEC_OUTPOST;
				break;
				
				case BuildingType.WATCH_TOWER:
					wood=40;
					iron=40;
					money=0;
					population=18;
					requirement=BuildingType.RANGE;
					main_type=BuildingType.MIL_TYPE;
					time_sec_build = BuildingType.SEC_WATCH_TOWER;
				break;
				
				case BuildingType.AMBUSH:
					wood=40;
					iron=40;
					money=0;
					population=18;
					requirement=BuildingType.SNIPER_SCHOOL;
					main_type=BuildingType.MIL_TYPE;
					time_sec_build = BuildingType.SEC_AMBUSH;
				break;
				
				case BuildingType.WAY_POINT:
					wood=40;
					iron=40;
					money=0;
					population=18;
					requirement=BuildingType.STABLES;
					main_type=BuildingType.MIL_TYPE;
					time_sec_build = BuildingType.SEC_WAY_POINT;
				break;
				
				case BuildingType.HOUSE:
					wood=30;
					iron=20;
					money=0;
					population=3;
					requirement=BuildingType.TOWN_SQUARE;
					main_type=BuildingType.CIVIL_TYPE;
					time_sec_build = BuildingType.SEC_HOUSE;
				break;
				
				case BuildingType.FARM:
					wood=30;
					iron=10;
					money=0;
					population=3;
					requirement=BuildingType.TOWN_SQUARE;
					main_type=BuildingType.CIVIL_TYPE;
					time_sec_build = BuildingType.SEC_FARM;
				break;
				case BuildingType.SAWMILL:
					wood=5;
					iron=20;
					money=0;
					population=3;
					requirement=BuildingType.TOWN_SQUARE;
					main_type=BuildingType.CIVIL_TYPE;
					time_sec_build = BuildingType.SEC_SAWMILL;
				break;
				case BuildingType.BLACKSMITH:
					wood=20;
					iron=5;
					money=0;
					population=3;
					requirement=BuildingType.TOWN_SQUARE;
					main_type=BuildingType.CIVIL_TYPE;
					time_sec_build = BuildingType.SEC_BLACKSMITH;
				break;
				case BuildingType.WAREHOUSE:
					wood=20;
					iron=20;
					money=0;
					population=3;
					requirement=BuildingType.FARM;
					main_type=BuildingType.CIVIL_TYPE;
					time_sec_build = BuildingType.SEC_WAREHOUSE;
				break;
				case BuildingType.STOCKPILE:
					wood=10;
					iron=10;
					money=0;
					population=3;
					requirement=BuildingType.WAREHOUSE;
					main_type=BuildingType.CIVIL_TYPE;
					time_sec_build = BuildingType.SEC_STOCKPILE;
				break;
				case BuildingType.MARKET:
					wood=35;
					iron=30;
					money=0;
					population=6;
					requirement=BuildingType.WAREHOUSE;
					main_type=BuildingType.CIVIL_TYPE;
					time_sec_build = BuildingType.SEC_MARKET;
				break; 
				
				default:
					wood=0;
					iron=0;
					money=0;
					population=0;
					requirement=0;
					main_type=BuildingType.CIVIL_TYPE;
					time_sec_build = 0;
				break;
			} //End of the giant switch statement
			
			//trace("ddd" + requirement);
			return new BuildingInfoNode(wood,iron,population,money,requirement,main_type,time_sec_build);
		} //End of getInfo() function
		
		
	}
}