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
		
		private var theView:View;
		var mcity:City;
		var mbuilding:Building;
		var mbuilding2:Building;
		/**
		* Load all contents to the canvas
		*/
		public function loadContents():void
		{
			trace("loadContents"); 
 			var curr:SpriteSheet = new SpriteSheet(0,100,200);
			
			this.theView = new View(this.stage);
			
			//this.stage.addChild(curr.drawIndex(0));
			
			mcity=new City(0,0,100,100);
			mbuilding=new Building(new Rectangle(0,0,1,1),1);
			mbuilding2=new Building(new Rectangle(1,0,10,10),1);
			
			mcity.addBuilding(mbuilding);
			mcity.addBuilding(mbuilding2);
			
			this.theView.addBuildingList(mcity.Buildings);
			
			this.theView.Update();
			//this.addEventListener(MouseEvent.CLICK,mouseEventListener);
			//this.stage.addChild(/* Add entity here */);
			
		}
		
		/** 
		* GameLoop: this is where things get updated!
		*/
		public function gameLoop():void
		{
			trace("gameLoop");
		}
		
		
		/**
		* eventListner: I/O input and event listener.
		*/
		public function mouseEventListener(event:MouseEvent):void
		{
			//var building:Building=new Building(new Rectangle(event.localX,event.localY,10,10));
			//mcity.addBuilding(building);
			//var buildingimage:TestSymbol=new TestSymbol();
			//buildingimage.x=event.localX;
			//buildingimage.y=event.localY;
			//this.addChild(buildingimage);
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
			this.gameLoop();
		}
		
		
	}
}