package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	
	import flash.events.*;
	import classes.*;
	import constant.*;
	import utilities.*;
	import contents.ImgBuilding;

	/**
	* gameCavas object
	*	- handle all game logic and game contents
	*/
	public class GameCanvas extends MovieClip
	{
		
		private var theView:View;			// View
		private var timer:CountDown;
		private var input:IOHandler;		// IO Handler (receiving input)
		private var profile:Player;			// Player's profile
		
		private var menuBar:MenuSystem;		// Menu System
		private var headStat:HeaderInfo;	// Header Info
		private var popUpStat:PopUpWindow;	// Pop Up Stat menu
		
		
		private var command:int;			// Current command of the mouse-click
		private var select_building:int;	// Current building selected when mouse-click at the menu
		
		private var build_cursor:ImgBuilding;	// Cursor of building image
		
		var mcity:City;
		var mbuilding:Building;
		var mbuilding2:Building;
		var mouse:MouseCurs;
		var update_resources:Boolean = true;
		
		/**
		* Load all contents to the canvas
		*/
		public function loadContents():void
		{
			trace("loadContents"); 
			profile = new Player("RealName", "UserName");
			profile.Food = 2;
			profile.Wood = 22;
			profile.Iron = 10;
			profile.Money = 10;
			profile.Population = 10;
			this.command = GameConfig.COMM_SELECT;
		
			//this.input = new IOHandler(this.stage.x,this.stage.y,this.stage.width, this.stage.height);
			this.input = new IOHandler(0,0, 766, 612);
			
			this.input.addEventListener(MouseEvent.CLICK,cityMouseClick);
			this.input.addEventListener(MouseEvent.MOUSE_MOVE,cityMouseMove);
			
			this.timer = new CountDown(1);
			this.menuBar = new MenuSystem(0,460,Images.WIN_CITYMENU);
			this.headStat = new HeaderInfo(profile);
			this.popUpStat = new PopUpWindow(580,245,Images.POP_STAT);
			
			//attach mouse cursor
			mouse=new MouseCurs();
			build_cursor = new ImgBuilding(0,0,BuildingType.TOWN_SQUARE);
			build_cursor.visible = false;
			build_cursor.alpha = GameConfig.HALF_TRANSPARENT;

			mcity=new City(0,0,8,8);
			mbuilding=new Building(new Rectangle(1,0,1,1),BuildingType.TOWN_SQUARE);
			mcity.addBuilding(mbuilding);

			profile.addCity(mcity);
			
			this.menuBar.feedCityReqToIcons(BuildingManager.determineBuildingList(mcity));
			this.menuBar.buildMenu();
			this.menuBar.addExtFuncTo(GameConfig.COMM_ADD, MouseEvent.CLICK, addButtonClick);
			this.menuBar.addExtFuncTo(GameConfig.COMM_REMOVE,MouseEvent.CLICK, removeButtonClick);
			this.menuBar.addExtFuncTo(GameConfig.CHANGE_WORLD, MouseEvent.CLICK, worldButtonClick);
			this.menuBar.addExtFuncTo(GameConfig.COMM_CANCEL, MouseEvent.CLICK, cancelButtonClick);
			this.menuBar.addExtFuncTo(GameConfig.COMM_STAT_POP, MouseEvent.CLICK, showStat);
			
			this.theView = new View(mcity);
			
			// update Building List everytime add or remove in the game object occurs
			this.theView.addBuildingList(mcity.Buildings);
			
			this.theView.Update();
			this.addEventListener("enterFrame",gameLoop);
			
			// Add Layer of I/O input device
			this.addChild(theView);
			this.addChild(mouse);			// Mouse cursor	
			this.addChild(build_cursor);	// Mouse cursor (for building)
			this.addChild(this.input);		// IO Input
			
			this.addChild(this.menuBar);	// Add Menu
			this.addChild(this.headStat);	// Add Top Stat Bar
			this.addChild(this.popUpStat);	// Add Pop-up windows
			
		}
		
		/**
		* Show/Hide stat information
		*/
		public function showStat(event:MouseEvent):void
		{
			popUpStat.updateInfo(profile);
			popUpStat.autoSwitch();
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
				if (this.command == GameConfig.COMM_SELECT || this.command == GameConfig.COMM_REMOVE)
				{
					//trace("Move Coords: "+xmouse+" , "+ymouse);
					this.mouse.visible = true;
					this.mouse.x = (((xmouse-ymouse)*GameConfig.TILE_HEIGHT)+GameConfig.TILE_INIT_X);
					this.mouse.y = (((xmouse+ymouse)*GameConfig.TILE_HEIGHT/2)+GameConfig.TILE_INIT_Y);
				} else 
				if (this.command == GameConfig.COMM_ADD)
				{
					this.build_cursor.visible = true;
					//trace("Move Coords: "+xmouse+" , "+ymouse);
					this.build_cursor.x = (((xmouse-ymouse)*GameConfig.TILE_HEIGHT)+GameConfig.TILE_INIT_X);
					this.build_cursor.y = (((xmouse+ymouse)*GameConfig.TILE_HEIGHT/2)-(GameConfig.TILE_HEIGHT/2)+GameConfig.TILE_INIT_Y);
					
				}
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
			
			// check requirement, retrive info from city
			var build_list:Array = BuildingManager.determineBuildingList(mcity);
			
			//trace(event.currentTarget.getBuildingType);
			
			// if met basic requirement
			if (build_list[event.currentTarget.getBuildingType])
			{
				// if met resources requirement
				if (BuildingManager.hasResourceToBuild(event.currentTarget.getBuildingType,profile.Wood, profile.Iron, profile.Money, profile.Population))
				{
					this.select_building = event.currentTarget.getBuildingType;
					trace("build now " + this.select_building);
					// give out ghost building
					//trace(event.currentTarget.getBuildingType);
					//this.build_cursor.visible = true;
					this.build_cursor.changeType(event.currentTarget.getBuildingType);
					this.mouse.visible= false;
					//trace("Error here?");
					
				} else {
					trace("Not enough resources for " + this.select_building);
					this.command = GameConfig.COMM_SELECT;
				}
			} else {
				this.command = GameConfig.COMM_SELECT;
			}
			
			//trace("Building clicked icon:" + this.select_building);
			//this.select_building = event.currentTarget;
		}
		
		/**
		* Remove button event listener, sets the command to be Remove
		* @param: The mouse event for this click
		**/
		public function removeButtonClick(event:MouseEvent):void
		{
			trace("Remove button clicked");
			this.build_cursor.visible = false;
			this.command=GameConfig.COMM_REMOVE;
		}
		
		/**
		* cancel a current command, and set it to select mode
		*/
		public function cancelButtonClick(event:MouseEvent):void
		{
			this.build_cursor.visible = false;
			this.command = GameConfig.COMM_SELECT;
		}
		
		/**
		* World map listener event, changes the view from city map to worldmap
		* @param1: The mouse event for this click
		**/
		public function worldButtonClick(event:MouseEvent):void
		{
			//changes the frame to world map view
			trace("World button clicked!");
			//MovieClip(parent).gotoAndStop(GameConfig.WORLD_FRAME);
			MovieClip(parent).switchGame();
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
					// (1) (GameObject) Notify city what building to be removed
					mcity.removeBuilding(theView.checkClickedBuilding(xloc, yloc));
					
					// (2) Adjust View, delete a building from view
					theView.setClickedBuildingInvisible(xloc,yloc);
					
					// (3) Update Menu Bar
					menuBar.updateCityReq(BuildingManager.determineBuildingList(mcity));
					
				}
			} else 
			
			if (this.command == GameConfig.COMM_ADD)
			{
				trace("X: "+xloc+" ,y: "+yloc);
				// check if mouse-clicking is not on any building
				if (theView.checkClickedBuilding(xloc, yloc)==null)
				{
					// Translate mouse position to game position
					var gamePos:Point=theView.getGamePos(xloc,yloc);

					if (mcity.isValid(gamePos.x, gamePos.y))
					{
						// (1) Check resources if enough
						if (BuildingManager.hasResourceToBuild(this.select_building,profile.Wood, profile.Iron, profile.Money, profile.Population))
						{
							// (2) add building to the city
							mcity.addBuilding(new Building(new Rectangle(gamePos.x,gamePos.y,1,1),this.select_building));
							
							// (3) Add new building list to View
							theView.addBuildingList(mcity.Buildings);
							
							// (4) Deduct resources
							profile.changeWood(-BuildingInfo.getInfo(this.select_building).Wood);
							profile.changeMoney(-BuildingInfo.getInfo(this.select_building).Money);
							profile.changeIron(-BuildingInfo.getInfo(this.select_building).Iron);
							profile.changePop(-BuildingInfo.getInfo(this.select_building).Population);
							//profile.changeFood(BuildingInfo.getInfo(this.select_building));
							
							// (5) Extra update maximum capacity
							profile.updateResourcesCapacity();
						}

						// (4) Update Menu Bar and update stat
						menuBar.updateCityReq(BuildingManager.determineBuildingList(mcity));
						headStat.updateInfo(profile);
						build_cursor.visible = false;
						this.command = GameConfig.COMM_SELECT;
					}//if 
				}
			} else 
			if (this.command == GameConfig.COMM_SELECT)
			{
				this.mouse.visible = true;
				// Move stuff
				// Also pop up menu
			}
			
		}
		
		/** 
		* GameLoop: this is where things get updated constantly!
		*/
		public function gameLoop(event:Event):void
		{
			theView.Update();
			headStat.updateTimerInfo(timer.stringCountDown);
			
			if (timer.stringCountDown==timer.MIN_MINS_STRING() && update_resources)
			{
				// GET INFO. FROM TOWN!!!!
				profile.changeWood(mcity.Wood);
				profile.changeIron(mcity.Iron);
				profile.changeFood(mcity.Food);
				profile.changePop(mcity.Pop);
				//
				headStat.updateInfo(profile);
				update_resources = false;
			}
			
			if (timer.stringCountDown==timer.MAX_MINS_STRING()) 
			{
				update_resources = true;
			}
			
		}
		
		/**
		*	Constructor
		*   This is the first thing that gets called when start a game.
		*/
		public function GameCanvas():void
		{
			trace("gameCanvas contructor is loaded!");
			this.loadContents();
			headStat.updateTimerInfo(timer.stringCountDown);
			//this.gameLoop();
		}
		
		
	}
}