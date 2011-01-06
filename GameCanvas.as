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
		
		private var addButton:TriggerButton;
		private var removeButton:TriggerButton;
		
		
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
			
			this.theView = new View(this.stage);			
			this.input = new IOHandler(this.stage.x,this.stage.y,GameConfig.SCREEN_WIDTH, GameConfig.SCREEN_HEIGHT);
			this.command = GameConfig.COMM_ADD;
			this.addButton = new TriggerButton(300, 320, GameConfig.COMM_ADD);
			this.removeButton = new TriggerButton(450,320, GameConfig.COMM_REMOVE);
			
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
			//this.addEventListener(MouseEvent.CLICK, addB);
			
			// Add Layer of I/O input device
			//this.stage.addChild(this.input);
			//this.stage.addChild(this.addButton);
			//this.stage.addChild(this.removeButton);
			
			
			//this.stage.addChild(/* Add entity here */);
			
		}
		
		
		/** 
		* GameLoop: this is where things get updated!
		*/
		public function gameLoop(event:Event):void
		{
			theView.Update();
			var xloc:int = input.X_click;
			var yloc:int = input.Y_click;
			
			if (input.isClick()){
			if (this.command == GameConfig.COMM_REMOVE)
			{
				if (theView.checkClickedBuilding(xloc, yloc)!=null)
				{
					
					// CITY IS NOT ACTUALLY REMOVING BUILDINGS!!!!
					// (1) (GameObject) Notify city what building to be removed
					mcity.removeBuilding(theView.checkClickedBuilding(xloc, yloc));
					
					// PROB: NEED TO CHECK IF BUILDING IS ACTUALLY REMOVED
					// CHECK LENGTH OF BUILDING INSIDE THE CITY
					
					// (2) Adjust View, delete a building from view
					theView.setClickedBuildingInvisible(xloc,yloc);
					
					this.stage.removeChild(this.input);
					
				}
			} else 
			
			if (this.command == GameConfig.COMM_ADD)
			{
				// check if mouse-clicking is not on any building
				if (theView.checkClickedBuilding(xloc, yloc)==null)
				{
					// Translate mouse position to game position
					var x_pos:int = theView.getGamePos(xloc,yloc).x;
					var y_pos:int = theView.getGamePos(xloc,yloc).y;
					
					if (x_pos > -1 || y_pos > -1)
					{
						// add building to the city
						mcity.addBuilding(new Building(new Rectangle(x_pos,y_pos,1,1),1));
					
						// (2) Add new building list to View
						theView.addBuildingList(mcity.Buildings);
					
						this.stage.removeChild(this.input);
	
					}
				}
			} else 
			if (this.command == GameConfig.COMM_SELECT)
			{
				
			}
			}
			
			
			this.stage.addChild(this.input);
			this.stage.addChild(this.addButton);
			this.stage.addChild(this.removeButton);
			
			// Spike code for button
			if (addButton.isClick())
			{
				trace("Add is clicked");
				this.command = addButton.Command;
			} else if (removeButton.isClick()){
				trace("Remove is clicked");
				this.command = removeButton.Command;
			}
			
			// flush all I/O Buffer
			this.addButton.setNonClick();
			this.removeButton.setNonClick();
			this.input.setNonClick();
		
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