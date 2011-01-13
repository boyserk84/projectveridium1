package{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import classes.*;
	import constant.*;
	
	/**
	* MenuSystem
	*/
	public class MenuSytem extends MovieClip
	{
		
		private var type:int;		// Menu type (WorldMap vs. City)
		private var sub_type:int;	// Sub-menu type (Within City)
		
		/* Internal GUI */
		private var win_panel:MovieClip
		private var win_
		
		/**
		* Constructor
		* @param x,y (X,Y) Position
		* @param menu_type Menu type
		*/
		public function MenuSystem(x:int, y:int, menu_type:int)
		{
			this.x = x;
			this.y = y;
			this.type = menu_type;
			gotoAndStop(this.type);
			
			switch (this.type)
			{
				case Images.WIN_CITYMENU:
					// Allocate all windows
					break;
				case Images.WIN_WORLDMENU:
					// Allocate all windows
					break;
			}
		}
		
		/**
		*
		*
		*/
		public function ()
		{
			
		}
	}

}