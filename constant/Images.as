package constant{
	
	/**
	* Images value
	* Defining each set of images/animation corresponding to the game object.
	*
	* For example, Barrack could have 4 images representing it such as
	* default image, underattack animated image, destroyed images, and etc.
	*
	* This is where game constant/configuration value is defined.
	*/
	public class Images {
		/** Default frame value **/
		public static const DEFAULT_INDEX:int = 0;
		public static const DEFAULT_UNDERATTACK:int = 0;
		public static const DEFAULT_DESTROYED:int = 0;
		public static const DEFAULT_RUNNING:int = 0;
		
		/** MENU SYSTEM **/
		public static const WIN_WORLDMENU:int = 2;
		public static const WIN_CITYMENU:int = 1;
		
		/** SUB MENU AND PAGINATION **/
		public static const WIN_MIL_SUB:int = 1;		// Military sub menu
		public static const WIN_CIVIL_SUB:int = 2;		// Civilian sub menu
		public static const MAX_ICON_PER_PAGE:int = 4;
		
		/** STAT WINDOW **/
		public static const POP_STAT:int = 1;
		public static const POP_STAT_MIL:int = 2;
		
		/** NOTIFICATION WINDOW **/
		public static const PANEL_CONFIRM:int = 1;
		public static const PANEL_WINNER:int = 2;
		public static const PANEL_LOSER:int = 3;
		
		
		/** POP UP BUILDING INFO WINDOW **/
		public static const POP_TIME_REMAIN:int = 1;
		public static const POP_NAME:int = 2;
		public static const POP_REQUIRE:int = 3;
		public static const POP_REQUIRE_BUILD:int = 4;
		public static const POP_HELP_BUILD:int = 5;
	}
}