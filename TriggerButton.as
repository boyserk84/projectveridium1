package{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import classes.*;
	import constant.*;
	
	/**
	* TriggerButton
	* This class handles and processes of button,which will trigger
	* some certain events.
	*/
	public class TriggerButton extends MovieClip
	{
		
		private var button_type:int;
		
		private var command:int;
		
		private var isMouse_Click:Boolean = false;
		/**
		* Constructor
		* @param x,y (X,Y) Location where button should be
		* @param type Type of button as defined by the game
		*/
		public function TriggerButton(x:int,y:int, type:int)
		{
			this.x = x;
			this.y = y;
			this.button_type = type;
			gotoAndStop(this.button_type);
			//this.addEventListener(MouseEvent.CLICK,click_listener);
			trace("Button Create");
		}
		
		/**
		* event listener for mouse-clicking
		*/
/*		public function click_listener(event:MouseEvent)
		{
			trace("Click TriggerButton: " + this.command);
			if (this.button_type == GameConfig.COMM_ADD)
			{
				this.command = GameConfig.COMM_ADD;
			} else if (this.button_type == GameConfig.COMM_REMOVE){
				this.command = GameConfig.COMM_REMOVE;
			}
			this.isMouse_Click = true;
		}*/
		
		/**
		* return specified command
		*/
		public function get Command()
		{
			return this.command;
		}
		
		/**
		* Check if mouse is clicked.
		*/
		public function isClick()
		{
			return this.isMouse_Click;
		}
		
		/**
		* Set mouse to none-click state (flush)
		*/
		public function setNonClick()
		{
			this.isMouse_Click = false;
		}
		
		
	}
	
}