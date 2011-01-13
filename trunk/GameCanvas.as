package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	import flash.geom.Rectangle;
	import flash.geom.Point;
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
		
		/*
		private var addButton:TriggerButton;
		private var removeButton:TriggerButton;
		private var worldButton:TriggerButton;
		*/
		private var menuBar:MenuSystem;
		
		
		private var command:int;			// Current command of the mouse-click
		
		var mcity:City;
		var mbuilding:Building;
		var mbuilding2:Building;
		var mouse:MouseCurs;
		var test_update:Boolean = true;
		/**
		* Load all contents to the canvas
		*/
		public function loadContents():void
		{
			trace("loadContents"); 
			
			//this.theView = new View(this);
			this.input = new IOHandler(this.stage.x,this.stage.y,this.stage.width, this.stage.height);
			this.input.addEventListener(MouseEvent.CLICK,cityMouseClick);
			this.input.addEventListener(MouseEvent.MOUSE_MOVE,cityMouseMove);

//			this.command = GameConfig.COMM_ADD;
			
			/*
			this.addButton = new TriggerButton(200, 320, GameConfig.COMM_ADD);
			this.removeButton = new TriggerButton(300,320, GameConfig.COMM_REMOVE);
			this.worldButton=new TriggerButton(400,320, GameConfig.CHANGE_WORLD);
			*/
			
			this.menuBar = new MenuSystem(0,500,Images.WIN_CITYMENU);
			
				//attach mouse cursor
			mouse=new MouseCurs();
			

			this.menuBar.addExtFuncTo(GameConfig.COMM_ADD, MouseEvent.CLICK, addButtonClick);
			this.menuBar.addExtFuncTo(GameConfig.COMM_REMOVE,MouseEvent.CLICK, removeButtonClick);
			this.menuBar.addExtFuncTo(GameConfig.CHANGE_WORLD, MouseEvent.CLICK, worldButtonClick);
			
			
			
			//this.stage.addChild(curr.drawIndex(0));
			mcity=new City(0,0,8,8);
			mbuilding=new Building(new Rectangle(1,0,1,1),1);
			mbuilding2=new Building(new Rectangle(0,0,1,1),1);
			var mbuilding3=new Building(new Rectangle(3,3,2,2),BuildingType.FARM);
			
			mcity.addBuilding(mbuilding);
			mcity.addBuilding(mbuilding2);
			mcity.addBuilding(mbuilding3);
			
			
			this.theView = new View(mcity);
			// update Building List everytime add or remove in the game object occurs
			this.theView.addBuildingList(mcity.Buildings);
			
			
			this.theView.Update();
			this.addEventListener("enterFrame",gameLoop);
			//this.addEventListener(MouseEvent.CLICK, addB);
			
			// Add Layer of I/O input device
			//this.stage.addChild(this.input);
			//this.stage.addChild(this.addButton);
			//this.stage.addChild(this.removeButton);
			this.addChild(theView);
			this.addChild(mouse);						
			this.addChild(this.input);	// IO Input
			
			this.addChild(this.menuBar);	// Add Menu
			//this.addChild(this.addButton);
			//this.addChild(this.removeButton);
			//this.addChild(this.worldButton);

			//this.stage.addChild(/* Add entity here */);
			
		}
		
		/**
		* cityMouseMove: Locate cursor on the tile
		* @param: The mouse event for move.
		*/
		public function cityMouseMove(event:MouseEvent):void
		{
			
			//convert mouse coordinates from isometric back to normal
			var ymouse = ((2*(event.stageY-GameConfig.TILE_INIT_Y)-(event.stageX-GameConfig.TILE_INIT_X))/2);
			var xmouse = ((event.stageX-GameConfig.TILE_INIT_X)+ymouse);
			//find on which tile mouse is
			ymouse = Math.round(ymouse/GameConfig.TILE_HEIGHT);
			xmouse = Math.round(xmouse/GameConfig.TILE_HEIGHT)-1;
			
			// If valid tile, then display cursor
			if (mcity.isValid(xmouse,ymouse))
			{
				trace("Move Coords: "+xmouse+" , "+ymouse);
				this.mouse.x = (((xmouse-ymouse)*GameConfig.TILE_HEIGHT)+GameConfig.TILE_INIT_X);
				this.mouse.y = (((xmouse+ymouse)*GameConfig.TILE_HEIGHT/2)+GameConfig.TILE_INIT_Y);
			}
			
		}
		
		
		/**
		* Add button event listener, sets the command to be add a building
		* @param1: The mouse event for this click
		**/
		public function addButtonClick(event:MouseEvent):void
		{
			trace("Add button clicked!");
			this.command=GameConfig.COMM_ADD;
		}
		
		/**
		* Remove button event listener, sets the command to be Remove
		* @param1: The mouse event for this click
		**/
		public function removeButtonClick(event:MouseEvent):void
		{
			trace("Remove button clicked");
			this.command=GameConfig.COMM_REMOVE;
		}
		
		/**
		* World map listener event, changes the view from city map to worldmap
		* @param1: The mouse event for this click
		**/
		public function worldButtonClick(event:MouseEvent):void
		{
			//changes the frame to world map view
			trace("World button clicked!");
			MovieClip(parent).gotoAndStop(GameConfig.WORLD_FRAME);
			
		}
		
		
		/**
		* Event listener for this canvas' mouse click
		* @param1: The mouse event for this click
		**/
		public function cityMouseClick(event:MouseEvent):void
		{

			//do things with the click
			var xloc:int=event.stageX;
			var yloc:int=event.stageY;
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
					
				}
			} else 
			
			if (this.command == GameConfig.COMM_ADD)
			{
				trace("X: "+xloc+" ,y: "+yloc);
				// check if mouse-clicking is not on any building
				if (theView.checkClickedBuilding(xloc, yloc)==null)
				{
					
					var gamePos:Point=theView.getGamePos(xloc,yloc);
					// Translate mouse position to game position

					
					if (mcity.isValid(gamePos.x, gamePos.y))
					{
						// add building to the city
						mcity.addBuilding(new Building(new Rectangle(gamePos.x,gamePos.y,1,1),1));
						// (2) Add new building list to View
						theView.addBuildingList(mcity.Buildings);
						
					}//if 
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
			/*
			
			
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
			this.input.setNonClick();*/
			
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