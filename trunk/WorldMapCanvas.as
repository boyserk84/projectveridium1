package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import classes.*;
	import constant.*;

	/**
	* WorldMapCavas object
	*	- handle all game logic and game contents for WorldMap
	*/
	public class WorldMapCanvas extends MovieClip
	{
		
		private var input:IOHandler;
		private var worldView:WorldView;
		private var cityButton:TriggerButton;
		private var myMap:Map;
		
		
		//The old position of the mouse for the sake of movement distance
		private var mouseOldPos:Point;
		/**
		* Load all contents to the canvas
		*/
		public function loadContents():void
		{
			this.worldView=new WorldView();
			myMap=new Map();
			for(var i:int=0;i<5;++i)
			{
				var temp:Town=WorldConfig.getTownInfo(i);
				myMap.addTown(temp);
				
			}
			this.worldView.addAssets(myMap.Towns);
			this.input = new IOHandler(this.stage.x,this.stage.y,GameConfig.SCREEN_WIDTH, GameConfig.SCREEN_HEIGHT);
			input.addEventListener(MouseEvent.MOUSE_DOWN,worldMouseDown);
			input.addEventListener(MouseEvent.MOUSE_UP,worldMouseUp);
			input.addEventListener(MouseEvent.MOUSE_OUT,worldMouseOut);
			input.addEventListener(MouseEvent.CLICK,worldMouseClick);
			cityButton=new TriggerButton(400,320, GameConfig.CHANGE_WORLD);
			cityButton.addEventListener(MouseEvent.CLICK,cityButtonClick);

			
			this.addChild(worldView);
			this.addChild(input);			
			this.addChild(cityButton);
			
			
		}
		
		
		public function cityButtonClick(event:MouseEvent):void
		{
			MovieClip(parent).gotoAndStop(GameConfig.CITY_FRAME);
		}
		
		/*
		* Event listener for a mouse down event in order to start the drag of the world map.
		* This will be done by adjusting entire view and then calculating an offset in order to justify coordinates.
		*/
		public function worldMouseDown(event:MouseEvent):void
		{
			mouseOldPos=new Point(event.stageX,event.stageY);
			
			worldView.startDrag();
			
		}
		
		public function worldMouseUp(event:MouseEvent):void
		{
			mouseOldPos.x=mouseOldPos.x-event.stageX;
			mouseOldPos.y=mouseOldPos.y-event.stageY;
			worldView.changeOffset(mouseOldPos);
			worldView.stopDrag();
		}
		
		public function worldMouseOut(event:MouseEvent):void
		{
			worldView.changeOffset(mouseOldPos.subtract(new Point(event.stageX,event.stageY)));
			worldView.stopDrag();
		}
		
		public function worldMouseClick(event:MouseEvent):void		
		{
			
			var town=myMap.findTownByLocation((event.stageX+worldView.Offset.x),(event.stageY+worldView.Offset.y));
			if(town!=null)
			{
				trace("Wood: "+town.Wood);
				trace("Iron: "+town.Iron);
				trace("Population: "+town.Population);
			}
		}
		
		
		
		
		/**
		* The event listener for a mouse move event
		**/
		public function worldMouseMove(event:MouseEvent):void
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
}