package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.ui.Mouse;
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
		var test_update:Boolean = true;
		/**
		* Load all contents to the canvas
		*/
		public function loadContents():void
		{
			trace("loadContents"); 
			
			this.theView = new View(this);			
			this.input = new IOHandler(this.stage.x,this.stage.y,GameConfig.SCREEN_WIDTH, GameConfig.SCREEN_HEIGHT);
			this.input.addEventListener(MouseEvent.CLICK,canvasMouseClick);
			this.input.addEventListener(MouseEvent.MOUSE_OVER,canvasMouseOver);
			this.input.addEventListener(MouseEvent.MOUSE_MOVE,canvasMouseMove);
			this.input.addEventListener(MouseEvent.MOUSE_OUT,canvasMouseOut);
			this.command = GameConfig.COMM_REMOVE;
			
			
			//this.stage.addChild(curr.drawIndex(0));
			mcity=new City(0,0,100,100);
			mbuilding=new Building(new Rectangle(1,0,1,1),1);
			mbuilding2=new Building(new Rectangle(0,0,1,1),1);
			var mbuilding3=new Building(new Rectangle(3,3,2,2),BuildingType.FARM);
			
			mcity.addBuilding(mbuilding);
			/*
			mcity.addBuilding(mbuilding2);
			mcity.addBuilding(mbuilding3);
			*/

			
			
			// update Building List everytime add or remove in the game object occurs
			this.theView.addBuildingList(mcity.Buildings);
			
			
			this.theView.Update();
			this.addEventListener("enterFrame",gameLoop);
			
			// Add Layer of I/O input device
			this.stage.addChild(this.input);

			
			
			//this.stage.addChild(/* Add entity here */);
			
		}
		
		public function canvasMouseOut(event:MouseEvent):void
		{

			var xloc:int = event.stageX;
			var yloc:int = event.stageY;
			if (this.command == GameConfig.COMM_REMOVE)
			{
				
			} else 
			if (this.command == GameConfig.COMM_ADD)
			{
				Mouse.show();
				theView.removeSymbol(mcity.Ghost.Location.x,mcity.Ghost.Location.y);
				mcity.removeGhost();

			
			} else 
			if (this.command == GameConfig.COMM_SELECT)
			{
				
			}
		}
		
		public function canvasMouseMove(event:MouseEvent):void
		{
//			trace("Mouse Move!");
			var xloc:int = event.stageX;
			var yloc:int = event.stageY;
			if (this.command == GameConfig.COMM_REMOVE)
			{
				
			} else 
			if (this.command == GameConfig.COMM_ADD)
			{
				
				mcity.updateGhostLocation(xloc,yloc);
				theView.updateBuildingLocation(mcity.Ghost);

			
			} else 
			if (this.command == GameConfig.COMM_SELECT)
			{
				
			}
		}
		
		public function canvasMouseOver(event:MouseEvent):void
		{
			trace("Mouse Over!");
			var xloc:int = event.stageX;
			var yloc:int = event.stageY;
			if (this.command == GameConfig.COMM_REMOVE)
			{
				
			} else 
			if (this.command == GameConfig.COMM_ADD)
			{
				Mouse.hide();
				mcity.updateGhost(new Building(new Rectangle(xloc,yloc,1,1),BuildingType.BARRACK_PLACE));
				theView.addBuildingList(mcity.Buildings);


			
			} else 
			if (this.command == GameConfig.COMM_SELECT)
			{
				
			}
		}
		
		/**
		* Rob changing IOHandler to work off of events!
		**/
		public function canvasMouseClick(event:MouseEvent):void
		{
			var xloc:int = event.stageX;
			var yloc:int = event.stageY;
			if (this.command == GameConfig.COMM_REMOVE)
			{
				if (theView.otherCheck(xloc, yloc)!=null)
				{
					trace("Found on1");
					var temp:Building=theView.otherCheck(xloc, yloc);
					// CITY IS NOT ACTUALLY REMOVING BUILDINGS!!!!
					// (1) (GameObject) Notify city what building to be removed
					mcity.removeBuilding(temp);
					
					// PROB: NEED TO CHECK IF BUILDING IS ACTUALLY REMOVED
					// CHECK LENGTH OF BUILDING INSIDE THE CITY
					
					// (2) Adjust View, delete a building from view
					theView.removeBuildingSymbol(temp);
					
					// (3) Add new building list to View
								theView.addBuildingList(mcity.Buildings);
					
					
					
				}
			} else 
			if (this.command == GameConfig.COMM_ADD)
			{
				trace(xloc+","+yloc);
				if (theView.checkClickedBuilding(xloc, yloc)==null)
				{

					// check with CITY if a particular space is occupied
					var point:Point=theView.convertToGameLoc(xloc,yloc);
					
					//were just using stage cooridanates but we need to turn into game
					mcity.addBuilding(new Building(new Rectangle(mcity.Ghost.Location.x,mcity.Ghost.Location.y,1,1),1));
					// if not occupied, addBuildingList to the game and view
			theView.addBuildingList(mcity.Buildings);

				}
			} else 
			if (this.command == GameConfig.COMM_SELECT)
			{
				
			}
		}
		
		
		/** 
		* GameLoop: this is where things get updated!
		*/
		public function gameLoop(event:Event):void
		{

			theView.Update();
			
			
			
			
			
			//this.stage.addChild(this.input);
		
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