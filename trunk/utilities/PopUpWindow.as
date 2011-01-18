package utilities{
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
		
		/**
		* Constructor
		*/
		public function PopUpWindow(x:int,y:int, type:int)
		{
			this.x = x;
			this.y = y;
			gotoAndStop(type);
			deactivate();
		}
		
		/**
		* update information to be displayed
		* @param profile: Player's profile
		*/
		public function updateInfo(profile:Player):void
		{
			this.soldiersInfo.text = profile.AmountSoldiers.toString();
			this.workersInfo.text = profile.AmountWorkers.toString();
			this.comInfo.text = (profile.Population - (profile.AmountSoldiers + profile.AmountWorkers)).toString();
			this.popInfo.text = profile.Population.toString();;
		}
		
		
		/**
		* Switch to a specific type of pop up windows
		* @param type: Type of pop-up windows
		*/
		public function switchToWin(type:int):void
		{
			gotoAndStop(type);
		}
		
		/**
		* Activate Pop up windows to be displayed
		*/
		public function activate():void
		{
			this.visible = true;
		}
		
		/**
		* Deactive pop up windows (disappear)
		*/
		public function deactivate():void
		{
			this.visible = false;
		}
		
		/**
		* check if window is being displayed
		*/
		public function isWindowsUp():Boolean
		{
			return this.visible;
		}
		
		/**
		* Auto switch between display and disappear
		*/
		public function autoSwitch():void
		{
			this.visible = !this.visible;
		}
		
		/**
		* return type of pop up windows
		*/
		public function get Type():int
		{
			return currentFrame;
		}
		
		
	}
}