package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.events.*;
	import classes.*;
	import constant.*;

	/**
	* gameCavas object
	*	- handle all game logic and game contents
	*/
	public class GameCanvas extends MovieClip
	{
		
		private var theView:View;			// View
		private var input:IOHandler;		// IO Handler (receiving input)
		
		private var command:int;			// Current command of the mouse-click
		
		var mcity:City;
		var mbuilding:Building;
		var mbuilding2:Building;
		/**
		* Load all contents to the canvas
		*/
		public function loadContents():void
		{
			trace("loadContents"); 
			
			this.theView = new View(this.stage);			
			this.input = new IOHandler(this.stage.x,this.stage.y,GameConfig.SCREEN_WIDTH, GameConfig.SCREEN_HEIGHT);
			this.command = GameConfig.COMM_REMOVE;
			
			//this.stage.addChild(curr.drawIndex(0));
			
			mcity=new City(0,0,100,100);
			mbuilding=new Building(new Rectangle(1,0,1,1),1);
			mbuilding2=new Building(new Rectangle(0,0,1,1),1);
			var mbuilding3=new Building(new Rectangle(3,3,2,2),BuildingType.FARM);
			
			mcity.addBuilding(mbuilding);
			mcity.addBuilding(mbuilding2);
			mcity.addBuilding(mbuilding3);
			
			// update Building List everytime add or remove in the game object occurs
			this.theView.addBuildingList(mcity.Buildings);
			
			
			
			this.theView.Update();
			this.addEventListener("enterFrame",gameLoop);
			
			// Add Layer of I/O input device
			this.stage.addChild(this.input);

			
			
			//this.stage.addChild(/* Add entity here */);
			
		}
		
		/** 
		* GameLoop: this is where things get updated!
		*/
		public function gameLoop(event:Event):void
		{
			theView.Update();
			if (this.command == GameConfig.COMM_REMOVE)
			{
				var xloc:int = input.X_click;
				var yloc:int = input.Y_click;
				if (theView.checkClickedBuilding(xloc, yloc)!=null)
				{
					
					// CITY IS NOT ACTUALLY REMOVING BUILDINGS!!!!
					// (1) (GameObject) Notify city what building to be removed
					mcity.removeBuilding(theView.checkClickedBuilding(xloc, yloc));
					
					// PROB: NEED TO CHECK IF BUILDING IS ACTUALLY REMOVED
					// CHECK LENGTH OF BUILDING INSIDE THE CITY
					
					// (2) Adjust View, delete a building from view
					theView.setClickedBuildingInvisible(xloc,yloc);
					// (3) Add new building list to View
					theView.addBuildingList(mcity.Buildings);
				}
			} else 
			if (this.command == GameConfig.COMM_ADD)
			{
				

			}
		
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
			//this.gameLoop();
		}
		
		
	}
}