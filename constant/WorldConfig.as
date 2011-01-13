﻿package constant{
	import flash.geom.Point;
	import classes.Town;
	public class WorldConfig
	{
		
		public static const TOWN_WIDTH=32;
		public static const TOWN_HEIGHT=16;
		
		public static function getTownInfo(townIn:int):Town
		{
			//Constructor for town
			//wood,stone,pop,iron,food,location
			switch(townIn)
			{
				case 0:
				return new Town(10,0,10,0,10,new Point(272,71));
				
				case 1:
				return new Town(10,10,4,0,10,new Point(199,144));
				
				case 2:
				return new Town(10,0,0,0,0,new Point(202,223));
				
				case 3:
				return new Town(10,0,30,1,0,new Point(170,444));
				
				case 4:
				return new Town(3,100,5,10,100,new Point(32,522));
				
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