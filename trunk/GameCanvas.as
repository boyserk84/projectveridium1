package {
	import flash.display.MovieClip;
	import flash.display.Stage;

	/**
	* gameCavas object
	*	- handle all game logic and game contents
	*/
	public class GameCanvas extends MovieClip
	{
		
		/**
		* Load all contents to the canvas
		*/
		public function loadContents():void
		{
			trace("loadContents");
			//this.stage.addChild(/* Add entity here */);
		}
		
		/** 
		* GameLoop: this is where things get updated!
		*/
		public function gameLoop():void
		{
			
		}
		
		
		/**
		* eventListner: I/O input and event listener.
		*/
		public function eventListener():void
		{
			
		}
		
		/**
		*	Constructor
		*   This is the first thing that gets called when start a game.
		*/
		public function GameCanvas():void
		{
			trace("gameCanvas contructor is loaded!");
			this.loadContents();
		}
		
		
	}
}