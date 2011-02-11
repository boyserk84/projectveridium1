package constant{
	import flash.geom.Point;
	import classes.Town;
	public class WorldConfig
	{
		
		public static const TOWN_WIDTH=32;
		public static const TOWN_HEIGHT=16;
		
		public static const TOWN_INFO_OFFSET_X=-50;
		public static const TOWN_INFO_OFFSET_Y=-125;
		
		public static const INPUT_WIDTH=766;
		public static const INPUT_HEIGHT=612;
		
		public static const WORLD_INIT_X=382;
		public static const WORLD_INIT_Y=32;
		
		//What frames to goto for towns for either occupancy to illustrate on the world map
		public static const AMERICAN_OCCUPANCY=2;
		public static const BRITISH_OCCUPANCY=3;
		public static const HOME_CITY=5;
		
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
		
		//WorldCanvas Regiment message intentions
		public static const MSG_CREATE=0;
		public static const MSG_REMOVE=1;
		public static const MSG_UPDATE=2;
		
		
		
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
					return 0;
				}
			}
		}
		
		public static function getTownInfo(townIn:int):Town
		{
			//Constructor for town
			//wood,stone,pop,iron,food,location,name
			switch(townIn)
			{
				//Maine
				case 0:
					return new Town(3,100,5,10,100,new Point(2088,550),"0");
				case 1:
					return new Town(3,100,5,10,100,new Point(2023,488),"1");
				case 2:
					return new Town(3,100,5,10,100,new Point(2011,557),"2");
				case 3:
				return new Town(3,100,5,10,100,new Point(1918,592),"3");
				case 4:
				return new Town(3,100,5,10,100,new Point(1972,638),"4");
				
				//NewHampshire/Connnecticut?
				case 5:
				return new Town(3,100,5,10,100,new Point(1883,690),"5");
				case 6:
				return new Town(3,100,5,10,100,new Point(1919,766),"6");
				case 7:
				return new Town(3,100,5,10,100,new Point(1866,766),"7");
				
				//Massachusettes
				case 8:
				return new Town(3,100,5,10,100,new Point(1921,843),"8");
				case 9:
				return new Town(3,100,5,10,100,new Point(1830,871),"9");
				
				//Random place below Mass
				case 10:
				return new Town(3,100,5,10,100,new Point(1890,913),"10");
				case 11:
				return new Town(3,100,5,10,100,new Point(1835,940),"11");
				
				//New York
				case 12:
				return new Town(3,100,5,10,100,new Point(1790,671),"12");
				case 13:
				return new Town(3,100,5,10,100,new Point(1775,779),"13");
				case 14:
				return new Town(3,100,5,10,100,new Point(1739,856),"14");
				case 15:
				return new Town(3,100,5,10,100,new Point(1686,706),"15");
				case 16:
				return new Town(3,100,5,10,100,new Point(1645,806),"16");
				case 17:
				return new Town(3,100,5,10,100,new Point(1736,927),"17");
				case 18:
				return new Town(3,100,5,10,100,new Point(1777,970),"18");
				case 19:
				return new Town(3,100,5,10,100,new Point(1593,893),"19");
				case 20:
				return new Town(3,100,5,10,100,new Point(1469,947),"20");
				
				//Rhode Island
				case 21:
				return new Town(3,100,5,10,100,new Point(1766,1032),"21");
				case 22:
				return new Town(3,100,5,10,100,new Point(1765,1147),"22");
				
				//PEnnsylvania
				case 23:
				return new Town(3,100,5,10,100,new Point(1691,1059),"23");
				case 24:
				return new Town(3,100,5,10,100,new Point(1623,999),"24");
				case 25:
				return new Town(3,100,5,10,100,new Point(1599,1126),"25");
				case 26:
				return new Town(3,100,5,10,100,new Point(1526,1068),"26");
				case 27:
				return new Town(3,100,5,10,100,new Point(1433,1161),"27");
				case 28:
				return new Town(3,100,5,10,100,new Point(1422,1034),"28");
				
				//Maryland
				case 29:
				return new Town(3,100,5,10,100,new Point(1622,1201),"29");
				case 30:
				return new Town(3,100,5,10,100,new Point(1725,1220),"30");
				case 31:
				return new Town(3,100,5,10,100,new Point(1751,1270),"31");
				
				//Virginia
				case 32:
				return new Town(3,100,5,10,100,new Point(1615,1332),"32");
				case 33:
				return new Town(3,100,5,10,100,new Point(1566,1426),"33");
				case 34:
				return new Town(3,100,5,10,100,new Point(1531,1242),"34");
				case 35:
				return new Town(3,100,5,10,100,new Point(1480,1360),"35");
				case 36:
				return new Town(3,100,5,10,100,new Point(1406,1259),"36");
				case 37:
				return new Town(3,100,5,10,100,new Point(1327,1382),"37");
				case 38:
				return new Town(3,100,5,10,100,new Point(1364,1453),"38");
				
				//North Carolina
				case 39:
				return new Town(3,100,5,10,100,new Point(1684,1532),"39");
				case 40:
				return new Town(3,100,5,10,100,new Point(1628,1653),"40");
				case 41:
				return new Town(3,100,5,10,100,new Point(1520,1500),"41");
				case 42:
				return new Town(3,100,5,10,100,new Point(1472,1609),"42");
				case 43:
				return new Town(3,100,5,10,100,new Point(1316,1605),"43");
				
				//South Carolina
				case 44:
				return new Town(3,100,5,10,100,new Point(1497,1687),"44");
				case 45:
				return new Town(3,100,5,10,100,new Point(1549,1730),"45");
				case 46:
				return new Town(3,100,5,10,100,new Point(1482,1784),"46");
				case 47:
				return new Town(3,100,5,10,100,new Point(1370,1712),"47");
				
				//Georgia
				case 48:
				return new Town(3,100,5,10,100,new Point(1315,1801),"48");
				case 49:
				return new Town(3,100,5,10,100,new Point(1400,1907),"49");
				case 50:
				return new Town(3,100,5,10,100,new Point(1251,1858),"50");
				case 51:
				return new Town(3,100,5,10,100,new Point(1367,2017),"51");
				case 52:
				return new Town(3,100,5,10,100,new Point(1229,1970),"52");



				
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
		
		public static function getNeighbors(townIn:int):Array
		{
			
			switch(townIn)
			{
				//Maine
				case 0:
					return new Array(1,2);
				case 1:
					return new Array(0,2);
				case 2:
					return new Array(0,1,3,4);
				case 3:
				return new Array(1,2,4,5);
				case 4:
				return new Array(2,3,5,6);
				
				//NewHampshire/Connnecticut?
				case 5:
				return new Array(3,4,6,7,12);
				case 6:
				return new Array(4,5,7,8);
				case 7:
				return new Array(5,6,8,9,12,13);
				
				//Massachusettes
				case 8:
				return new Array(6,7,9,10);
				case 9:
				return new Array(7,8,10,11,13,14,17);
				
				//Random place below Mass
				case 10:
				return new Array(8,9,11);
				case 11:
				return new Array(9,10,17,18);
				
				//New York
				case 12:
				return new Array(5,7,13,15);
				case 13:
				return new Array(7,9,14,15,16);
				case 14:
				return new Array(9,11,13,17,16,19);
				case 15:
				return new Array(12,13,16);
				case 16:
				return new Array(13,14,15,19);
				case 17:
				return new Array(9,11,14,18,19,24);
				case 18:
				return new Array(11,17,21,23,24);
				case 19:
				return new Array(14,16,17,20,24,26);
				case 20:
				return new Array(19,26,28);
				
				//Rhode Island
				case 21:
				return new Array(18,22,23);
				case 22:
				return new Array(21,23,30);
				
				//PEnnsylvania
				case 23:
				return new Array(18,21,22,24,25,30);
				case 24:
				return new Array(17,18,19,23,25,26);
				case 25:
				return new Array(23,24,26,27,29,30);
				case 26:
				return new Array(19,20,24,25,27,28);
				case 27:
				return new Array(25,26,28,29,36);
				case 28:
				return new Array(20,26,27);
				
				//Maryland
				case 29:
				return new Array(25,27,30,31,32,34,36);
				case 30:
				return new Array(22,23,25,29,31);
				case 31:
				return new Array(30,29,32);
				
				//Virginia
				case 32:
				return new Array(31,29,33,34,35);
				case 33:
				return new Array(32,35,38,39,41);
				case 34:
				return new Array(29,32,35,36);
				case 35:
				return new Array(32,33,34,36,37,38);
				case 36:
				return new Array(27,29,34,35,37);
				case 37:
				return new Array(35,36,38);
				case 38:
				return new Array(33,35,37,41,43);
				
				//North Carolina
				case 39:
				return new Array(33,40,41,42);
				case 40:
				return new Array(39,41,42,44,45);
				case 41:
				return new Array(33,38,39,40,42,43);
				case 42:
				return new Array(39,40,41,43,44,47);
				case 43:
				return new Array(38,41,42,47);
				
				//South Carolina
				case 44:
				return new Array(40,42,45,46,47);
				case 45:
				return new Array(40,46);
				case 46:
				return new Array(44,45,47,48,49);
				case 47:
				return new Array(42,43,44,46,48);
				
				//Georgia
				case 48:
				return new Array(46,47,49,50);
				case 49:
				return new Array(46,48,50,52,51);
				case 50:
				return new Array(48,49,52);
				case 51:
				return new Array(49,52);
				case 52:
				return new Array(49,50,51);



				
				default:
				return null;
			}
			return null;
			
		}
		
	}
}