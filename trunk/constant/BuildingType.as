package constant{
	
	/**
	* GameConstant: BuildingType
	* This is where building constant/value is defined.
	*/
	public class BuildingType {
		/*
		* Misc.stuff
		*/
		public static const TILE:int = 100;
		public static const CIVIL_TYPE:String = "CIVIL";
		public static const MIL_TYPE:String = "MIL";
		
		/* Rate of production of buildings within the city
		*/
		public static const IRON_PRODUCT:int = 1;
		public static const FOOD_PRODUCT:int = 1;
		public static const WOOD_PRODUCT:int = 1;
		public static const POP_PRODUCT:int = 1;
		public static const MONEY_PRODUCT:int = 1;
		
		/* Incremental value of max. (cap) storage value per building */
		public static const EXTRA_STORAGE= 5;
		public static const EXTRA_POP_STORAGE = 10;
		
		/* Initial maximum storages of each type of resources */
		public static const IRON_CAP_INIT:int =20;
		public static const FOOD_CAP_INIT:int = 10;
		public static const WOOD_CAP_INIT:int = 20;
		public static const POP_CAP_INIT:int = 15;


		/*
		* Construction building
		*/
		public static const MIL_CONSTRUCT:int = 22;
		public static const CIVIL_CONSTRUCT:int = 23;

		/*
		* Military building 
		*/		
		public static const BARRACK:int = 1;		// Integer represent barrack
		public static const ARMORY:int = 2;
		public static const RANGE:int =3;
		public static const SNIPER_SCHOOL:int = 4;
		public static const FORGE:int = 5;
		public static const WORKSHOP:int = 6;
		public static const FOUNDRY:int=7;
		public static const BOOT_CAMP:int=8;
		public static const STABLES:int = 9;
		public static const OFFICER_SCHOOL:int=10;
		public static const OUTPOST:int=11;
		public static const WATCH_TOWER:int=12;
		public static const WAY_POINT:int=13;
		public static const AMBUSH:int=14;
		
		/* Name corresponding to each miltary building */
		public static const N_BARRACK:String = "Barracks";
		public static const N_ARMORY:String = "Armory";
		public static const N_RANGE:String ="Shooting Range";
		public static const N_SNIPER_SCHOOL:String = "Espionage";
		public static const N_FORGE:String = "Forge";
		public static const N_WORKSHOP:String = "Workshop";
		public static const N_FOUNDRY:String= "Debate School";
		public static const N_BOOT_CAMP:String= "Boot Camp";
		public static const N_STABLES:String = "Stables";
		public static const N_OFFICER_SCHOOL:String= "Officer Academy";
		public static const N_OUTPOST:String="Outpost";
		public static const N_WATCH_TOWER:String="Watch Tower";
		public static const N_WAY_POINT:String="Way Point";
		public static const N_AMBUSH:String="Ambush";
		
		/* Description of each miltary building */
		public static const D_BARRACK:String = "Allows your militia to train minutemen.  Requires a Town Square";
		public static const D_ARMORY:String = "Allows your city to make better weaponry. Requires a Barracks.";
		public static const D_RANGE:String ="Allows your city to train sharpshooters.  Requires an Armory.";
		public static const D_SNIPER_SCHOOL:String = "Allows your city to train Agents.  Requires a Shooting Range.";
		public static const D_FORGE:String = "Allows your city to craft stronger metals.  Requires a Barracks.";
		public static const D_WORKSHOP:String = "Allows your city to create Cannons.  Requires a Forge.";
		public static const D_FOUNDRY:String= "Allows your city to train Politicians.  Requires a Workshop.";
		public static const D_BOOT_CAMP:String= "Allows you to further train your soldiers.  Requires a Barracks.";
		public static const D_STABLES:String = "Allows your city to train Cavalry.  Requires a Boot Camp.";
		public static const D_OFFICER_SCHOOL:String= "Allows your city to train Officers.  Requires a Stables.";
		public static const D_OUTPOST:String="Allows your city to become stronger.";
		public static const D_WATCH_TOWER:String="Allows your city to see enemies coming a mile away.";
		public static const D_WAY_POINT:String="Invites commoners to stop at your city.";
		public static const D_AMBUSH:String="Reminds your soldiers what ambush means.";
		
		
		/* Time it takes to build each military building */
		public static const SEC_BARRACK:int = 60;
		public static const SEC_ARMORY:int = 150;
		public static const SEC_RANGE:int = 180;
		public static const SEC_SNIPER_SCHOOL:int = 240;
		public static const SEC_FORGE:int = 240;
		public static const SEC_WORKSHOP:int = 300;
		public static const SEC_FOUNDRY:int = 300;
		public static const SEC_BOOT_CAMP:int = 300;
		public static const SEC_STABLES:int = 300;
		public static const SEC_OFFICER_SCHOOL:int = 360;
		public static const SEC_OUTPOST:int = 120;
		public static const SEC_WATCH_TOWER:int = 120;
		public static const SEC_WAY_POINT:int = 180;
		public static const SEC_AMBUSH:int = 120;
		
		public static const TOTAL_MIL_TYPE:int = 14;
		
		/**
		* Civilian building
		*/

		public static const TOWN_SQUARE:int=0;
		public static const FARM:int = 15;
		public static const SAWMILL:int=16;
		public static const BLACKSMITH:int=17;
		public static const WAREHOUSE:int=18;
		public static const STOCKPILE:int=19;
		public static const MARKET:int=20;
		public static const HOUSE:int=21;
		
		/* Time it takes to build each civilian building*/
		public static const SEC_TOWN_SQUARE:int = 5;
		public static const SEC_FARM:int = 120;
		public static const SEC_SAWMILL:int = 120;
		public static const SEC_BLACKSMITH:int = 120;
		public static const SEC_WAREHOUSE:int = 300;
		public static const SEC_STOCKPILE:int = 240;
		public static const SEC_MARKET:int = 180;
		public static const SEC_HOUSE:int = 120;
		
		/* Name corresponding to each civilian building */
		public static const N_TOWN_SQUARE:String = "Town Square";
		public static const N_FARM:String = "Farm";
		public static const N_SAWMILL:String = "Sawmill";
		public static const N_BLACKSMITH:String = "Blacksmith";
		public static const N_WAREHOUSE:String = "Warehouse";
		public static const N_STOCKPILE:String = "Stockpile";
		public static const N_MARKET:String = "Market";
		public static const N_HOUSE:String = "House";
		
		/* Description corresponding to each civilian building */
		public static const D_TOWN_SQUARE:String = "Your capital city.";
		public static const D_FARM:String = "Provides food for your city.";
		public static const D_SAWMILL:String = "Provides wood for your city.";
		public static const D_BLACKSMITH:String = "Provides iron for your city";
		public static const D_WAREHOUSE:String = "Increases overall capacity of your city's resources.";
		public static const D_STOCKPILE:String = "Increases economics of cities.";
		public static const D_MARKET:String = "Exchange and trade with your neighbors. More money.";
		public static const D_HOUSE:String = "Provide housing for your people to prevent overcrowding.";
		
		public static const TOTAL_CIVIL_TYPE:int = 8;
		
		public static const TOTAL_BUILD_TYPE:int = 22;
		
		
		
	}

}