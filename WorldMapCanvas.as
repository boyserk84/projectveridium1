package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import classes.*;
	import constant.*;

	/**
	* WorldMapCavas object
	*	- handle all game logic and game contents for WorldMap
	*/
	public class WorldMapCanvas extends MovieClip
	{
		
		/**
		* Load all contents to the canvas
		*/
		public function loadContents():void
		{
			
		}
		
		/** 
		* GameLoop: this is where things get updated!
		* Possibly where event handler is attached to.
		*/
		public function gameLoop():void
		{
		}
		
		/**
		* Constructor
		* This is the first thing that gets called when it is instantiated.
		*/
		public function WorldMapCanvas():void
		{
			this.loadContents();
		}
	}