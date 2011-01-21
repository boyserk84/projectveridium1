package {
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import utilities.CountDown;
	import classes.*;
	import contents.*;
	import constant.GameConfig;
	
	/**
	* GlobalDocument
	* This class handles information passing throughout the application.
	*
	*/
	public class GlobalDocument extends MovieClip
	{
		
		/** Game Data **/
		public var profile:Player;				// Player
		
		/** Global Utilities **/
		public var time:CountDown;				// Count-down timer
		public var damn:String = "Damn it";
		
		public var game:GameCanvas;
		public var worldgame:WorldMapCanvas;
		
		/*
		* Default constructor
		*/
		public function GlobalDocument()
		{
			trace("Create GlobalDocument");
			gotoAndStop(GameConfig.CITY_FRAME);
			game = new GameCanvas();
			this.addChild(game);
			worldgame = new WorldMapCanvas;
			this.addChild(worldgame);
			enableCity();
		}
		
		private function enableCity()
		{
			game.visible = true;
			worldgame.visible = false;
		}
		
		private function enableWorld()
		{
			game.visible = false;
			worldgame.visible = true;
		}
		
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
			trace("Current Frame is " + currentFrame);
		}
		
	}
	
}