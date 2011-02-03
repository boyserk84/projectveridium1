package constant{
	import flash.geom.Point;
	import classes.Town;
	public class WorldConfig
	{
		
		public static const TOWN_WIDTH=32;
		public static const TOWN_HEIGHT=16;
		
		public static const TOWN_INFO_OFFSET_X=-50;
		public static const TOWN_INFO_OFFSET_Y=-125;
		
		public static const INPUT_WIDTH=766-275;
		public static const INPUT_HEIGHT=612;
		
		public static const WORLD_INIT_X=382;
		public static const WORLD_INIT_Y=32;
		
		//What frames to goto for towns for either occupancy to illustrate on the world map
		public static const AMERICAN_OCCUPANCY=2;
		public static const BRITISH_OCCUPANCY=3;
		
		//Intention of regiments
		public static const NONE=0;
		public static const ATTACK=1;
		public static const REINFORCE=2;
		public static const WORKER=3;
		public static const AGENT=4;
		public static const POLITICIAN=5;
		public static const SCOUT=6;
		
		//Town info bar frame numbers
		public static const TOWN_BAR_BLANK=1;
		public static const TOWN_BAR_ECONOMIC=2;
		public static const TOWN_BAR_MILITARY=3;
		
		//WorldCanvas states
		public static const STATE_NONE=0;
		public static const STATE_REINFORCE=1;
		public static const STATE_ATTACK=2;
		public static const STATE_WORKERS=3;
		public static const STATE_SELECTING=4;
		public static const STATE_AGENTS=5;
		public static const STATE_POLITICIANS=6;
		
		
		
		public static function getTownDistrict(townIn:int):int
		{
			switch(townIn)
			{
				case 0:
				{
					//Maine
					return WorldType.MAINE;
				}
				case 1:
				{
					//New York
					return WorldType.NEWYORK;
				}
				case 2:
				{
					//New Hampshire
					return WorldType.NEWHAMPSHIRE;
				}
				case 3:
				{
					//Virginia
					return WorldType.NORTHCAROLINA;
				}
				case 4:
				{
					//Georgia
					return WorldType.GEORGIA;
				}
				default:
				{
					return townIn;
				}
			}
		}
		
		public static function getTownInfo(townIn:int):Town
		{
			//Constructor for town
			//wood,stone,pop,iron,food,location
			switch(townIn)
			{
				case 0:
				return new Town(10,0,10,0,10,new Point(2117,552),"Bristol");
				
				case 1:
				return new Town(10,10,4,0,10,new Point(1864,874),"Boston");
				
				case 2:
				return new Town(10,0,0,0,0,new Point(1598,1523),"Fairfax");
				
				case 3:
				return new Town(10,0,30,1,0,new Point(1555,1068),"Philadelphia");
				
				case 4:
				return new Town(3,100,5,10,100,new Point(1271,1876),"Atlanta");
				
				default:
				return null;
			}
			return null;
		}
		
		
		public static function getInfo(worldType:int):Point
		{
			switch(worldType)
			{
				case WorldType.MAINE:
				return new Point(243,13);
				break;
				
				case WorldType.MARYLAND:
				return new Point(116,252);
				break;
				case WorldType.MASSACHUSETTS:
				return new Point(244,87);
				break;
				
				case WorldType.GEORGIA:
				return new Point(6,445);
				break;
				
				case WorldType.NEWHAMPSHIRE:
				return new Point(204,177);
				break;
				
				case WorldType.NEWYORK:
				return new Point(142,75);
				break;
				
				case WorldType.NORTHCAROLINA:
				return new Point(37,369);
				break;
				
				case WorldType.PENNSYLVANIA:
				return new Point(125,173);
				break;
				
				case WorldType.RHODEISLAND:
				return new Point(203,250);
				break;
				
				case WorldType.SOUTHCAROLINA:
				return new Point(45,436);
				break;
				
				case WorldType.VIRGINIA:
				return new Point(81,272);
				break;
			}//end of switch
			return null;
		}//end of function
		
	}
}