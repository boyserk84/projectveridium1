package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import classes.*;

	/**
	* gameCavas object
	*	- handle all game logic and game contents
	*/
	public class GameCanvas extends MovieClip
	{
		

		var mcity:City;
		var mbuilding:Building;
		/**
		* Load all contents to the canvas
		*/
		public function loadContents():void
		{
			trace("loadContents");
			mcity=new City(0,0,100,100);
			mbuilding=new Building(new Rectangle(0,0,10,10),1);
			this.addEventListener(MouseEvent.CLICK,mouseEventListener);
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
		public function mouseEventListener(event:MouseEvent):void
		{
			var building:Building=new Building(new Rectangle(event.localX,event.localY,10,10));
			mcity.addBuilding(building);
			var buildingimage:TestSymbol=new TestSymbol();
			buildingimage.x=event.localX;
			buildingimage.y=event.localY;
			this.addChild(buildingimage);
		}
		
		/**
		* Passes a list to the view in order to draw all of the entites on the screen
		*/
		public function Draw():void
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