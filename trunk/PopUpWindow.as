package{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import classes.*;
	import constant.*;
	
	/**
	* PopUpWindow GUI
	* This class will handle and process information to display on the popup-screen.
	*/
	public class PopUpWindow extends MovieClip
	{
		private var win_type:int;		// Type of window
		
		
		/*
		* Default Constructor
		*/
		public function PopUpWindow()
		{
			
		}
		
		/**
		* Constructor
		*/
		public function PopUpWindow(x:int,y:int,width:int, height:int)
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
		
		
	}
}