package constant{
	
	/**
	* Game Configuration value
	* This is where game constant/configuration value is defined.
	*/
	public class GameConfig {
		public static const SCREEN_WIDTH:int = 471;
		public static const SCREEN_HEIGHT:int = 343;
		
		public static const WORLD_INIT_X:int=0;
		public static const WORLD_INIT_Y:int=0;

/*		public static const SCREEN_WIDTH:int = 550;
		public static const SCREEN_HEIGHT:int = 440;
		*/
		public static const TILE_INIT_X:int = 350;
		public static const TILE_INIT_Y:int = 60;
		/*
		public static const TILE_INIT_X:int = 260;
		public static const TILE_INIT_Y:int = 100;
		*/
		
		// Tile dimension
		public static const TILE_WIDTH:int = 64;
		public static const TILE_HEIGHT:int = 32;
		
		// Display value
		public static const FULL_TRANSPARENT = 0;
		public static const HALF_TRANSPARENT = 0.50;
		public static const OPAQUE = 1;
		
		// Game Map value
		public static const MAX_CITY_COL = 5;
		public static const MAX_CITY_ROW = 5;
		
		// Mouse click commands and buttons
		public static const COMM_ADD = 1;
		public static const COMM_REMOVE = 2;
		public static const CHANGE_WORLD = 3;
		public static const COMM_SELECT = 99;
		public static const COMM_NEXT = 4;
		public static const COMM_PREV = 5;
		public static const COMM_MIL_LIST = 6;
		public static const COMM_CIV_LIST = 7;
		public static const COMM_CANCEL = 8;
		public static const COMM_STAT_POP = 9;
		
		//Frame for World Map
		public static const WORLD_FRAME=2;
		
		//Frame for City Map
		public static const CITY_FRAME=1;

		
	
	}
}