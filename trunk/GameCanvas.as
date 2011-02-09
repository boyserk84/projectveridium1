package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.utils.Timer;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	
	import flash.events.*;
	import classes.*;
	import constant.*;
	import utilities.*;
	import contents.ImgBuilding;
	import network.ClientConnector;

	/**
	* gameCavas object
	*	- handle all game logic and game contents
	*/
	public class GameCanvas extends MovieClip
	{
		
		private var theView:View;			// View
		private var timer:CountDown;		// Count Down Timer
		private var input:IOHandler;		// IO Handler (receiving input)
		private var profile:Player;			// Player's profile
		
		private var menuBar:MenuSystem;				// Menu System
		private var headStat:HeaderInfo;			// Header Info
		private var popUpStat:PopUpWindow;			// Pop Up Stat menu
		private var pop_buildingInfo:popupInfo		// Pop Up building info
		private var notifyWin:NotifyWindow;			// Notification window
		

		
		private var command:int;			// Current command of the mouse-click
		private var select_building:int;	// Current building selected when mouse-click at the menu
		
		private var build_cursor:ImgBuilding;			// Cursor of building image
		private var mouse:MouseCurs;					// Mouse cursor on tile
		private var update_resources:Boolean = true;	// Notifier when need to update
		
		private var show_Notify_win:Boolean = false;	// Pop Notify for resources
		
		private var length_of_city:int;
		
		// Game Contents
		private var mcity:City;
		private var tempBuilding:Building;		// Temporary game object

		
		/**
		* initalize mouse cursor
		*/
		private function initialize_MOUSE():void
		{
			mouse=new MouseCurs();
			mouse.gotoAndStop(GameConfig.CURSOR_SELECT);
			build_cursor = new ImgBuilding(0,0,BuildingType.TOWN_SQUARE);
			build_cursor.visible = false;
			build_cursor.alpha = GameConfig.HALF_TRANSPARENT;
		}
		
		/**
		* initialize I/O Handler
		*/
		private function initialize_IO():void
		{
			this.input = new IOHandler(0,0, GameConfig.SCREEN_WIDTH, GameConfig.SCREEN_HEIGHT);
			this.input.addEventListener(MouseEvent.CLICK,cityMouseClick);
			this.input.addEventListener(MouseEvent.MOUSE_MOVE,cityMouseMove);
			this.input.addEventListener(MouseEvent.ROLL_OVER,cityMouseMove);
			this.input.addEventListener(MouseEvent.ROLL_OUT, hoverOutaddButton);
		}
		
		/**
		* initialize building info pop up
		*/
		private function initialize_buildingInfoPopUp():void
		{
			pop_buildingInfo = new popupInfo();
			pop_buildingInfo.visible = false;
		}
		
		/**
		* Load all contents to the canvas
		*/
		public function loadContents():void
		{
			trace("loadContents"); 

			this.command = GameConfig.COMM_SELECT;
			
			initialize_buildingInfoPopUp();
			initialize_IO();
			initialize_StatBar(profile);
			initialize_windows();
			initialize_MOUSE();
			
			initialize_MenuBar(mcity);
			initialize_GameView();
			this.addEventListener("enterFrame",gameLoop);
			timer.addObjectWithUpdate(mcity);	// Feed object that needs timer
			initialize_Layers();
			
		}
		
		/**
		* Load status bar with user's profile
		*/
		private function initialize_StatBar(profile:Player):void
		{
			this.timer = new CountDown(GameConfig.TIME_MINS_RESPAWN);
			this.menuBar = new MenuSystem(0,460,Images.WIN_CITYMENU);
			this.headStat = new HeaderInfo(profile);
		}
		
		private function initialize_windows():void
		{
			this.popUpStat = new PopUpWindow(580,245,Images.POP_STAT);
			this.notifyWin = new NotifyWindow(GameConfig.SCREEN_WIDTH/4, GameConfig.SCREEN_HEIGHT/4,1);
		}
		
		/**
		* create a menu bar and add external functions (listeners) to it
		*/
		private function initialize_MenuBar(mcity:City):void
		{
			this.menuBar.feedCityReqToIcons(BuildingManager.determineBuildingList(mcity));
			this.menuBar.buildMenu();
			this.menuBar.addExtFuncTo(GameConfig.COMM_ADD, MouseEvent.CLICK, addButtonClick);
			this.menuBar.addExtFuncTo(GameConfig.COMM_ADD, MouseEvent.ROLL_OVER, hoverOveraddButton);
			this.menuBar.addExtFuncTo(GameConfig.COMM_ADD, MouseEvent.ROLL_OUT, hoverOutaddButton);
			this.menuBar.addExtFuncTo(GameConfig.COMM_REMOVE,MouseEvent.CLICK, removeButtonClick);
			this.menuBar.addExtFuncTo(GameConfig.CHANGE_WORLD, MouseEvent.CLICK, worldButtonClick);
			this.menuBar.addExtFuncTo(GameConfig.COMM_CANCEL, MouseEvent.CLICK, cancelButtonClick);
			this.menuBar.addExtFuncTo(GameConfig.COMM_STAT_POP, MouseEvent.CLICK, showStat);
			this.menuBar.addExtFuncTo(GameConfig.COMM_HELP, MouseEvent.CLICK, helpButtonClick );
			this.popUpStat.addExtFuncToButtons(GameConfig.COMM_PLUS_SIGN, MouseEvent.CLICK,addToStat);
			this.popUpStat.addExtFuncToButtons(GameConfig.COMM_PLUS_SIGN, MouseEvent.MOUSE_MOVE, hideNotifyRequirePopUp);
			//this.popUpStat.addExtFuncToButtons(GameConfig.COMM_PLUS_SIGN, MouseEvent.MOUSE_OVER, showSoldierRequirePopUp);
			this.popUpStat.addExtFuncToButtons(GameConfig.COMM_MINUS_SIGN, MouseEvent.CLICK, removeFromStat);
			this.popUpStat.addExtFuncToButtons(GameConfig.COMM_SWITCH_STAT, MouseEvent.CLICK, switchStat);
			this.notifyWin.addEventToConfirmButton(MouseEvent.CLICK, proceedRemove);
			this.notifyWin.addEventToCancelButton(MouseEvent.CLICK, disableNotifyWin);
		}
		
		/**
		* Hide Notification required resources pop up windows
		* @param event: MouseEvent
		*/
		private function hideNotifyRequirePopUp(event:MouseEvent):void
		{
			if (show_Notify_win ==true)
			{
				pop_buildingInfo.visible = false;
				show_Notify_win = false;
			}
		}
		
		/**
		* Remove a building from a game
		* @param tempBuilding: Building that needs to be removed
		*/
		private function removeGameBuilding(tempBuilding:Building)
		{
			// (1) (GameObject) Notify city what building to be removed
			mcity.removeBuilding(tempBuilding);
						
			// (2) Adjust View, delete a building from view
			theView.removeBuildingInvisibleAt(tempBuilding.Location.x,tempBuilding.Location.y);
						
			// (3) Update Menu Bar
			menuBar.updateCityReq(BuildingManager.determineBuildingList(mcity));
			
			// (4) Update Server's building info of this client
			ClientConnector.requestRemoveBuilding(tempBuilding);
		}
		
		/**
		* Initialize game into view
		*/
		private function initialize_GameView():void
		{
			this.theView = new View(mcity);
			this.theView.addBuildingList(mcity.Buildings);
			this.theView.Update();
		}
		
		/**
		* Initialize layers of display
		*/
		private function initialize_Layers():void
		{
			// Add Layer of I/O input device
			this.addChild(theView);
			this.addChild(mouse);			// Mouse cursor	
			this.addChild(build_cursor);	// Mouse cursor (for building)
			this.addChild(this.input);		// IO Input
			
			this.addChild(this.menuBar);	// Add Menu
			this.addChild(this.headStat);	// Add Top Stat Bar
			this.addChild(this.popUpStat);	// Add Pop-up windows
			this.addChild(pop_buildingInfo);// Add Pop-up building Info
			this.addChild(notifyWin);
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
		* Switch to different stat menu
		*/
		public function switchStat(event:MouseEvent):void
		{
			popUpStat.autoSwitchStatMenu();
			popUpStat.updateInfo(profile);
		}
		
		/**
		* Pop Up Alert Notification when resource needed in game
		* @param x,y: event.stage (X,Y) location
		*/
		private function alertPopUpNotify(x:Number, y:Number):void
		{
			// if has not been shown yet
			if (show_Notify_win==false)
			{
				pop_buildingInfo.visible = true;
				pop_buildingInfo.x = x - 100;
				pop_buildingInfo.y = y - 120/*65*/;
				pop_buildingInfo.gotoAndStop(Images.POP_REQUIRE_BUILD);
				show_Notify_win = true;
			}
		}
		
		/**
		* Add button in stat pop up (Adding soldiers for each type)
		*/
		public function addToStat(event:MouseEvent):void
		{
			// Determine type
			var unit_type:int = popUpStat.identifyButton(event.currentTarget.y);
			var node:SoldierInfoNode = SoldierType.getSoldierInfo(unit_type);
			
			// Check requirement
			if (mcity.Requirements[node.Requirement] > 0)
			{
				// check if there is enough population to allocate
				if (profile.AvailablePop > 0)
				{
					// check if enough resources
					if (SoldierType.enoughToTrain(profile.Money, profile.Wood, profile.Iron, profile.Food,unit_type))
					{
						if (unit_type==SoldierType.WORKER)
						{
							trace("Add Workers");
							profile.changeWorkers(1);
						} else {
							
							trace("add soldiers");
							profile.changeSoldiers(1);
						}
						
						// Update profile
						profile.addSoldierToRegiment(new Soldier(1,unit_type));
						profile.changeMoney(-node.Money);
						profile.changeFood(-node.Food);
						profile.changeWood(-node.Wood);
						profile.changeIron(-node.Iron);
						
						// Update Stat
						popUpStat.updateInfo(profile);
						headStat.updateInfo(profile);
						
						// update data on server
						ClientConnector.requestUpdateProfileResources();
						
					} else {
						// If not enough resource, notify a player
						alertPopUpNotify(event.stageX, event.stageY);
						pop_buildingInfo.reqInfo.text = "Not enough ".concat(
							SoldierType.resourceNeed(profile.Money, profile.Wood, profile.Iron, profile.Food,unit_type)
							);
						
					}
				} else {
					// If not enough population, notify a player
					alertPopUpNotify(event.stageX, event.stageY);
					pop_buildingInfo.reqInfo.text = ("Not enough population!");
				}
			} else {
				// Notify a player when required building has not been built
				alertPopUpNotify(event.stageX, event.stageY);
				pop_buildingInfo.reqInfo.text = (BuildingInfo.getBuildingName(node.Requirement).concat(" required!"));
			}
		}
		
		/**
		* Remove button in stat pop up
		*/
		public function removeFromStat(event:MouseEvent):void
		{
			var unit_type:int = popUpStat.identifyButton(event.currentTarget.y);
			if (unit_type==SoldierType.WORKER)
			{
				profile.changeWorkers(-1);
			} else {
				profile.changeSoldiers(-1);
			}
			profile.removeSoldierFromRegiment(new Soldier(1, unit_type ));
			popUpStat.updateInfo(profile);
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
					
					var clickedBuilding:Building = theView.checkClickedBuilding(event.stageX, event.stageY);
					// Check if mouse over building
					if (clickedBuilding!=null)
					{
						// Enable Pop-up building info
						pop_buildingInfo.visible = true;
						pop_buildingInfo.x = event.stageX + 20;
						pop_buildingInfo.y = event.stageY + 20;
						
						// if building is not done 
						if (!clickedBuilding.isBuildingDone())
						{
							var remain:int = clickedBuilding.currentProgress();
							
							// Enable view of time remaining
							pop_buildingInfo.gotoAndStop(Images.POP_TIME_REMAIN);
							pop_buildingInfo.remainTime.text = CountDown.formatTimeFromNumber(remain);
						} else {
							// Enable view of building's name
							pop_buildingInfo.gotoAndStop(Images.POP_NAME);
							pop_buildingInfo.buildInfo.text = BuildingInfo.getBuildingName(clickedBuilding.Type);
						}
					} else {
							pop_buildingInfo.visible = false;
					}// if mouse over building
					
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
			this.mouse.gotoAndStop(GameConfig.CURSOR_SELECT);

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
					//trace("build now " + this.select_building);					
					this.build_cursor.changeType(event.currentTarget.getBuildingType);
					this.mouse.visible= false;

				} else {
					alertPopUpNotify(event.stageX,event.stageY);
					pop_buildingInfo.reqInfo.text = "Not enough resources";
					this.command = GameConfig.COMM_SELECT;
				}
			} else {
				this.command = GameConfig.COMM_SELECT;
			}

		}
		
		/**
		* mouse over (hover over) add button
		*/
		public function hoverOveraddButton(event:MouseEvent):void
		{
			// check requirement, retrive info from city
			var build_list:Array = BuildingManager.determineBuildingList(mcity);
			// get requirement node
			var node:BuildingInfoNode = BuildingInfo.getInfo(event.currentTarget.getBuildingType);
			
			// Regular Mode
			if (this.command!=GameConfig.COMM_HELP)
			{
				// Set where to be displayed
				pop_buildingInfo.x = event.stageX + 10;
				pop_buildingInfo.y = event.stageY - 20;
				
				// if met basic requirement
				if (build_list[event.currentTarget.getBuildingType])
				{
					// show resources needed
					pop_buildingInfo.gotoAndStop(Images.POP_REQUIRE);
					pop_buildingInfo.buildName.text = BuildingInfo.getBuildingName(event.currentTarget.getBuildingType);
					pop_buildingInfo.woodInfo.text = node.Wood.toString();
					pop_buildingInfo.ironInfo.text = node.Iron.toString();
					pop_buildingInfo.moneyInfo.text = node.Money.toString();
					pop_buildingInfo.popInfo.text = node.Population.toString();
					
				} else {
					// show building requirement
					pop_buildingInfo.gotoAndStop(Images.POP_REQUIRE_BUILD);
					var req_build:int = node.Requirement;
					pop_buildingInfo.reqInfo.text = BuildingInfo.getBuildingName(req_build).concat(" is required!");
				}
			} else {
				// Help Mode
				
				/* Show Help/Tutorial pop up windows
				 Set where to be displayed
				 */
				pop_buildingInfo.x = event.stageX + 100;
				pop_buildingInfo.y = event.stageY - 100;
				pop_buildingInfo.gotoAndStop(Images.POP_HELP_BUILD);
				pop_buildingInfo.buildName.text = BuildingInfo.getBuildingName(event.currentTarget.getBuildingType);
				pop_buildingInfo.desInfo.text = BuildingInfo.getDescription(event.currentTarget.getBuildingType);
			}
			
			pop_buildingInfo.visible = true;
		}
		
		/**
		* mouse out of add button area (Hide pop up info)
		*/
		public function hoverOutaddButton(event:MouseEvent):void
		{
			pop_buildingInfo.visible = false;
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
			this.mouse.gotoAndStop(GameConfig.CURSOR_REMOVE);
		}
		
		/**
		* cancel a current command, and set it to select mode
		*/
		public function cancelButtonClick(event:MouseEvent):void
		{
			this.build_cursor.visible = false;
			this.command = GameConfig.COMM_SELECT;
			this.mouse.gotoAndStop(GameConfig.CURSOR_SELECT);
		}
		
		/**
		* Help button, and set it to help mode
		*/
		public function helpButtonClick(event:MouseEvent):void
		{
			this.build_cursor.visible = false;
			this.command = GameConfig.COMM_HELP;
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
		
				/*
		* Hide notification windows when clicked cancel
		*/
		private function disableNotifyWin(event:Event)
		{
			this.notifyWin.visible = false;
		}
		
		/**
		* Confirm to remove when click
		*/
		private function proceedRemove(event:Event)
		{
			this.notifyWin.visible = false;
			removeGameBuilding(tempBuilding);
			--this.length_of_city;
		}
		
		
		/**
		* Event listener for this canvas' mouse click
		* @param1: The mouse event for this click
		**/
		public function cityMouseClick(event:MouseEvent):void
		{
			var xloc:int=event.stageX;
			var yloc:int=event.stageY;
			
			if (this.command == GameConfig.COMM_REMOVE)
			{
				if (theView.checkClickedBuilding(xloc, yloc)!=null)
				{
					// Preventing remove one remainning town square
					if (mcity.hasMoreTownSquare() || theView.checkClickedBuilding(xloc, yloc).Type != BuildingType.TOWN_SQUARE)
					{
						// Only remove the building that has not been underconstruction
						if (theView.checkClickedBuilding(xloc, yloc).isBuildingDone())
						{
							// Refer building to be removed
							this.tempBuilding = theView.checkClickedBuilding(xloc, yloc);
							
							// Show confirmation window
							this.notifyWin.visible = true;
							this.notifyWin.modifyMessage("Confirmation", 
														 "Are you sure you want to remove "
														 .concat(
															BuildingInfo.getBuildingName(tempBuilding.Type).concat(" Building?")
															)
														 );
							
							/** OLD VERSION
								// (1) (GameObject) Notify city what building to be removed
								mcity.removeBuilding(theView.checkClickedBuilding(xloc, yloc));
						
								// (2) Adjust View, delete a building from view
								theView.setClickedBuildingInvisible(xloc,yloc);
						
								// (3) Update Menu Bar
								menuBar.updateCityReq(BuildingManager.determineBuildingList(mcity));
							**/
						}
					} else {
						// Alert, reason for not be able to remove a building
						alertPopUpNotify(event.stageX, event.stageY);
						
						if (theView.checkClickedBuilding(xloc, yloc).Type == BuildingType.TOWN_SQUARE)
						{
							pop_buildingInfo.reqInfo.text = ("Town square must remain!");
						}
						this.command = GameConfig.COMM_SELECT;
					}
				}
			} else 
			
			if (this.command == GameConfig.COMM_ADD)
			{
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
							++this.length_of_city;
							
							// (5) Send request to update server
							ClientConnector.requestUpdateProfileResources();
							ClientConnector.requestWriteAddBuilding();
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
			} else if (this.command==GameConfig.COMM_HELP)
			{
				// Back to select mode
				this.command = GameConfig.COMM_SELECT;
			}
			
		}
		
		/**
		* Synchronize city with the server (using for first time loading)
		*
		* Basically, check local city with server city and update view.
		*/
		private function synchronizeCity()
		{
			if (length_of_city!=ClientConnector.getBuildingLength())
			{
				//trace("UPDATEAAAAAAAAAAAAAAAAAAAAAA" + ClientConnector.getBuildingLength());
				theView.addBuildingList(ClientConnector.getBuildingList());
				menuBar.updateCityReq(BuildingManager.determineBuildingList(mcity));
				headStat.updateInfo(profile);
				length_of_city = ClientConnector.getBuildingLength();
			} 
		}
		
		/** 
		* GameLoop: this is where things get updated constantly!
		*/
		public function gameLoop(event:Event):void
		{
			synchronizeCity();
			
			theView.Update();
			headStat.updateTimerInfo(timer.stringCountDown);
			
			// Update city's capacity when specific types of building are finished.
			if (mcity.Requirements[BuildingType.WAREHOUSE] > 0 ||
				mcity.Requirements[BuildingType.HOUSE] > 0 )
			{
				profile.updateResourcesCapacity();
				headStat.updateInfo(profile);
			}
			
			// Give out and update resources periodically
			if (timer.stringCountDown==timer.MIN_MINS_STRING() && update_resources)
			{
				profile.changeWood(mcity.Wood);
				profile.changeIron(mcity.Iron);
				profile.changeFood(mcity.Food);
				profile.changePop(mcity.Pop);
				profile.updateAllTownResources();
				
				headStat.updateInfo(profile);
				popUpStat.updateInfo(profile);
				update_resources = false;
				
				ClientConnector.requestUpdateProfileResources();
			}
			
			if (timer.stringCountDown==timer.MAX_MINS_STRING()) // Reset Counting
			{
				update_resources = true;
			}
			
			//theView.addBuildingList(mcity.Buildings);
			//trace("Total buildings: "+ mcity.Buildings.Length);
			
		}
		
		/**
		*	Constructor
		*   This is the first thing that gets called when start a game.
		*/
		public function GameCanvas(user:Player):void
		{
			trace("gameCanvas contructor is loaded!");
			this.profile = user;
			this.mcity = profile.getCity();
			this.length_of_city = profile.getCity().Buildings.Length;
			this.loadContents();
			
			//headStat.updateTimerInfo(timer.stringCountDown);
			//this.gameLoop();
		}
		
		
	}
}