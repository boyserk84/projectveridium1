package {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import utilities.CountDown;
	import classes.*;
	import constant.BuildingType;
	import contents.*;
	import constant.GameConfig;
	import flash.geom.Rectangle;
	import network.*;
	
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
		
		/* Network Component */
		public var client:ConnectGame;
		
		/*
		* Default constructor
		*/
		public function GlobalDocument()
		{
			trace("Create GlobalDocument");
			gotoAndStop(GameConfig.CITY_FRAME);
			loadProfile();
			game = new GameCanvas(profile);
			this.addChild(game);
			
			worldgame = new WorldMapCanvas;
			this.addChild(worldgame);
			 
			enableCity();
		}
		
		/**
		* Load a player's all contents
		*/
		private function loadProfile():void
		{
			//var configuration:NetConst = new NetConst();
			//client = new ConnectGame(configuration);
								  
			// Set resources
			profile = new Player("RealName", "UserName");
			profile.Food = 200; /* 2 */
			profile.Wood = 220; /* 22 */
			profile.Iron = 11; /* 10 */
			profile.Money = 11; /* 10 */
			profile.Population = 10;
			
			// Set City			
			profile.addCity(new City(0,0,8,8));
			//profile.getCity().constructMainBuilding();
			//profile.getCity().addBuilding(new Building(new Rectangle(1,0,1,1),BuildingType.TOWN_SQUARE));
		
			// Set Town
			
			// Set Regiment
			
		}
		
		/**
		* Load player's profile from Database
		* @return True if load successfully
		*/
		private function loadFromDB():Boolean
		{
			// TODO: IMPLEMENT
							
			// Test Network
			//client.sendRequest("999");

			return true;
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