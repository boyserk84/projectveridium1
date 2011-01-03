package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import classes.*;
	import constant.*;
	
	/**
	* IOHandler
	* This class acts as an invisible mask, wrapping around gamecanvas to listen
	* for all control, input device such as mouse and keyboard.
	*/
	public class IOHandler extends MovieClip
	{
		private var click_coordinate:Point;
		
		/**
		* Constructor
		* @param x,y (X,Y) starting position
		* @param width, height area to be masked
		*/
		public function IOHandler(x:int, y:int, width:int, height:int)
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.addEventListener(MouseEvent.CLICK,listener);
			this.alpha = GameConfig.FULL_TRANSPARENT;
			this.click_coordinate = new Point(0,0);
		}
		
		/**
		* Event listener to input device when specified event is triggered
		* @return (X,Y) coordinate of mouse click
		*/
		public function listener(event:MouseEvent)
		{
			trace(event.stageX + "," + event.stageY);
			//trace(event.target);
			this.click_coordinate.x = event.stageX;
			this.click_coordinate.y = event.stageY;
		}
		
		/**
		* return X-coordinate when click is triggered.
		*/
		public function get X_click():int
		{
			return this.click_coordinate.x;
		}
		
		/**
		* return Y-coordinate when click is triggered.
		*/
		public function get Y_click():int
		{
			return this.click_coordinate.y;
		}
		
	}
}