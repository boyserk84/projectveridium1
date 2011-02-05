package {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.LoaderInfo;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import utilities.CountDown;
	import utilities.NotifyWindow;
	import classes.*;
	import constant.BuildingType;
	import contents.*;
	import constant.GameConfig;
	import flash.geom.Rectangle;
	import network.*;
	import flash.system.Security;
	
	/**
	* GlobalDocument
	* This class handles information passing throughout the application.
	*
	*/
	public class GlobalDocument extends MovieClip
	{
		
		/** Game Data **/
		public var profile:Player;				// Player
		
		/** Global game objects **/
		public var game:GameCanvas;
		public var worldgame:WorldMapCanvas;
		
		/* Global Notification windows */
		private var g_notify_win:NotifyWindow;
		
		/* Network Component */
		public var client:ConnectGame;
		private var configuration:NetConst;
		
		private var firstRequestSent:Boolean = false;		// Check if request has been sent
		private var connectSet:Boolean = false;
		private var firstNotifyCloseConnection:Boolean = false;
		
		
		/* Load information from URL */
		private var loader:URLLoader = new URLLoader();
		
		
		/*
		* Default constructor
		*/
		public function GlobalDocument()
		{
			trace("Create GlobalDocument");
			gotoAndStop(GameConfig.CITY_FRAME);
			configuration = new NetConst(); // Load Network Configuration info
			createNotifyWindow();
			
			this.addEventListener(Event.ENTER_FRAME, pollingCheck);
			
			loadIdFromWeb();
			prepareConnect();
			connectServer();
		}
		
		/**
		* Create a notification window of network status
		*/
		private function createNotifyWindow():void
		{
			g_notify_win = new NotifyWindow(GameConfig.SCREEN_WIDTH/4,GameConfig.SCREEN_HEIGHT/4,1);
			g_notify_win.addEventToConfirmButton(MouseEvent.CLICK, function(){ g_notify_win.visible = false; } );
			g_notify_win.addEventToCancelButton(MouseEvent.CLICK, function(){ g_notify_win.visible = false; } );
		}
		
		/**
		* Polling check if something happened to the server
		*/
		private function pollingCheck(event:Event):void
		{
			if (client.isConnectionClosed() && !firstNotifyCloseConnection)
			{
				g_notify_win.modifyMessage(NetCommand.MSG_HEAD_CLOSED,NetCommand.MSG_BODY_CLOSED);
				g_notify_win.visible = true;
				firstNotifyCloseConnection = true;
			}
		}
		
		/**
		* Fetch Facebook ID from the embedded website
		*/
		private function loadIdFromWeb()
		{
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
			var myVar:String = "";
			var valueStr:String = "";
			var value_array:Array = new Array();		// Holding Value
			var field_array:Array = new Array();		// Holding field info
			
			// Fetch data from web page
			for (myVar in paramObj) 
			{
				valueStr = String(paramObj[myVar]);
				field_array.push(myVar);
				value_array.push(valueStr);
			}
			
			// Process data
			var id:String ="No_ID";
			var name_val:String ="No_Name";
			for (var i:int = 0; i < value_array.length; ++i)
			{
				if (field_array[i]=='id')
				{
					id = value_array[i];
				} else {
					name_val = value_array[i];
				}
			}
			profile = new Player("","596761244");
			//profile = new Player(name_val,id);
			
			//trace(profile.UserName);
			//profile = new Player(name_val,"123456789012345");
		}
		
		/**
		* Prepare client's connection
		*/
		private function prepareConnect():void
		{
			client = new ConnectGame(configuration);
			client.bindId(profile.UserName);
			client.bindPlayer(this.profile);
			
			ClientConnector.client = this.client;
		}
		
		/**
		* Connect to the server
		*/
		private function connectServer()
		{
			//trace("Connect to server");
			this.addEventListener(Event.ENTER_FRAME, loadingProgress);
		}
		
		/**
		* Pre-loader screen (Event listener) and loading stuff from the server
		*
		*/
		private function loadingProgress(event:Event):void
		{
			if (client.isConnectFailed())
			{
				msgInfo.text = "Connection Failed!";
				loadOfflineGame();
				return;
			}
			
			// Check client's side
			if (stage.loaderInfo.bytesTotal <= stage.loaderInfo.bytesLoaded)
			{
				// Check network configuration
				if (configuration.loadComplete())
				{
					// If already connect to server
					if (client.isAlreadyConnect())	
					{
						// Check if request has been sent
						if (!firstRequestSent)	
						{
							trace((NetCommand.REQUEST_PROFILE +"x"+ profile.UserName));
							client.sendRequest(NetCommand.REQUEST_PROFILE +"x"+ profile.UserName);
							firstRequestSent = true;
							msgInfo.text = "Request user data from the server.";
						}
					} else {
						if (!connectSet)
						{ 
							client.connectNow();
							connectSet = true;
							msgInfo.text = "Connecting to the server.";
						}
					}
					
					msgInfo.text = "Waitng for response.";
					
					// if data has been arrived
					if (client.isDataArrived())	
					{
						//trace("yes");
						msgInfo.text = "Loading requested data and contents.";
						loadProfile();
						msgInfo.text = "Load player's profile.";
						loadContents();
						msgInfo.text = "Load player's contents.";
						loadCity();
						loadGameLayers();
					}
					
				} else {
					msgInfo.text = "Loading Configuration file.";
				}
			} else {
				// Loading Screen
				//trace("Loading");
				msgInfo.text = "Loading Application.";
			}
		}
		
		/**
		* Load and initialize game contents
		*
		*/
		private function loadContents():void
		{
			gotoAndStop(GameConfig.CITY_FRAME);
			//if (profile.getCity()==null) trace ("PROFILE IS NULL");
			game = new GameCanvas(profile);
			worldgame = new WorldMapCanvas();
			enableCity();
		}
		
		/**
		* Loading game canvas layers
		*/
		private function loadGameLayers():void
		{
			this.addChild(game);
			this.addChild(worldgame);
			
			if (client.isConnectFailed())
			{
				g_notify_win.modifyMessage(NetCommand.MSG_HEAD_FAIL,NetCommand.MSG_BODY_FAIL);
				g_notify_win.visible = true;
			}
			
			this.addChild(g_notify_win);
			
			
			this.removeEventListener(Event.ENTER_FRAME, loadingProgress);
		}
		
		/**
		* Load default profile
		*/
		private function loadDefaultProfile():void
		{
			profile = null;
			profile = new Player("No Name","0000");
			profile.addCity(new City(0,0, GameConfig.MAX_CITY_COL, GameConfig.MAX_CITY_ROW));
			profile.Wood = 10;
			profile.WoodCap = BuildingType.WOOD_CAP_INIT;
			profile.Iron = 10;
			profile.IronCap = BuildingType.IRON_CAP_INIT;
			profile.Food = 12;
			profile.FoodCap = BuildingType.FOOD_CAP_INIT;
			profile.Money = 10;
			profile.Population = 10;
			profile.PopulationCap = BuildingType.POP_CAP_INIT;
		}
		
		/**
		* Load offline version of the game 
		* Using this function in case of unable to connect to server
		*/
		private function loadOfflineGame():void
		{
			loadDefaultProfile();
			loadContents();
			loadGameLayers();
		}
		

		
		/**
		* Load a player's all contents
		*/
		private function loadProfile():void
		{
			profile = client.profile;
			profile.addCity(new City(0,0,GameConfig.MAX_CITY_COL,GameConfig.MAX_CITY_ROW));
			trace("current wood is " + profile.Wood + " " + profile.Name)
			// Set City	
			
			// Load list of building
			//profile.getCity().addBuilding(new Building(new Rectangle(1,0,1,1),BuildingType.TOWN_SQUARE));
		
			// Set Town
			
			// Set Regiment
			
		}
		
		/**
		* load City
		*/
		private function loadCity():void
		{
			client.sendRequest(NetCommand.REQUEST_CITY+"x"+ profile.UserName);
			
		}
		
		/**
		* Display city
		*/
		private function enableCity()
		{
			game.visible = true;
			worldgame.visible = false;
		}
		
		/**
		* Display world map
		*/
		private function enableWorld()
		{
			game.visible = false;
			worldgame.visible = true;
		}
		
		/**
		* Switch between view
		*/
		public function switchGame()
		{
			if (currentFrame == GameConfig.CITY_FRAME)
			{
				gotoAndStop(GameConfig.WORLD_FRAME);
				enableWorld();
			} else if (currentFrame == GameConfig.WORLD_FRAME){
				gotoAndStop(GameConfig.CITY_FRAME);
				enableCity();
			}
			//trace("Current Frame is " + currentFrame);
		}
		
	}
	
}