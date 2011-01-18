package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import classes.*;
	import constant.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import contents.TownInfoPane;
	import utilities.TriggerButton;
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
		private var dragging:Boolean;
		private var myPlayer:Player;
		private var gameTimer:Timer;
		
		private var regiments:LinkedList;
		
		
		//The old position of the mouse for the sake of movement distance
		private var mouseOldPos:Point;
		/**
		* Load all contents to the canvas
		*/
		public function loadContents():void
		{
			this.worldView=new WorldView();
			myMap=new Map();
			gameTimer=new Timer(100,0);
			gameTimer.addEventListener(TimerEvent.TIMER,gameLoop);
			regiments=new LinkedList();
			
			
			//Will read all of the towns of the server in order to get them!
			for(var i:int=0;i<5;++i)
			{
				var temp:Town=WorldConfig.getTownInfo(i);
				myMap.addTown(temp);
				
			}
			
			
			myPlayer=new Player("Rob","Robtacular");
			
			var reg:Regiment=new Regiment("Regiment 1");
			reg.Location=myMap.Towns[0].Location;
			reg.addUnit(new Soldier(10));
			reg.addUnit(new Soldier(10));
			reg.addUnit(new Soldier(10,1,2,1));
			
			myPlayer.addRegiment(reg);
			
			this.worldView.TownInfo.attackButton.addEventListener(MouseEvent.CLICK,townAttackButtonClick);
			
			
			this.worldView.addAssets(myMap.Towns);
			this.input = new IOHandler(this.stage.x,this.stage.y,WorldConfig.INPUT_WIDTH, WorldConfig.INPUT_HEIGHT);
			worldView.addEventListener(MouseEvent.MOUSE_DOWN,worldMouseDown);
			worldView.addEventListener(MouseEvent.MOUSE_UP,worldMouseUp);
			input.addEventListener(MouseEvent.MOUSE_DOWN,worldMouseDown);
			input.addEventListener(MouseEvent.MOUSE_UP,worldMouseUp);
			input.addEventListener(MouseEvent.MOUSE_OUT,worldMouseOut);
			input.addEventListener(MouseEvent.CLICK,worldMouseClick);
			worldView.addEventListener(MouseEvent.CLICK,worldMouseClick);
			cityButton=new TriggerButton(640,526, GameConfig.CHANGE_WORLD);
			cityButton.addEventListener(MouseEvent.CLICK,cityButtonClick);

			

			this.addChild(input);			
			this.addChild(worldView);
			this.addChild(cityButton);
			gameTimer.start();
			
			
		}
		
		
		public function cityButtonClick(event:MouseEvent):void
		{
			
			MovieClip(parent).gotoAndStop(GameConfig.CITY_FRAME);
		}
		
		public function townAttackButtonClick(event:MouseEvent):void
		{
			//do things
			trace("I'm clicked");

			myPlayer.Regiments.Get(0).data.Destination=event.currentTarget.parent.Location;
			myPlayer.Regiments.Get(0).data.x=myPlayer.Regiments.Get(0).data.Location.x;
			myPlayer.Regiments.Get(0).data.y=myPlayer.Regiments.Get(0).data.Location.y;
			regiments.Add(myPlayer.Regiments.Get(0).data);
			worldView.addAsset(myPlayer.Regiments.Get(0).data);
		}
		
		/*
		* Event listener for a mouse down event in order to start the drag of the world map.
		* This will be done by adjusting entire view and then calculating an offset in order to justify coordinates.
		*/
		public function worldMouseDown(event:MouseEvent):void
		{
			var town=myMap.findTownByLocation((event.stageX+worldView.Offset.x),(event.stageY+worldView.Offset.y));
			//worldView.hideTownInfo();
			if(town==null)
			{
				mouseOldPos=new Point(event.stageX,event.stageY);
				dragging=true;
				worldView.startDrag();
			}

		}
		
		public function worldMouseUp(event:MouseEvent):void
		{
			if(dragging)
			{
				mouseOldPos.x=mouseOldPos.x-event.stageX;
				mouseOldPos.y=mouseOldPos.y-event.stageY;
				worldView.changeOffset(mouseOldPos);
				worldView.stopDrag();
				dragging=false;
			}
		}
		
		public function worldMouseOut(event:MouseEvent):void
		{
			if(dragging)
			{
				mouseOldPos.x=mouseOldPos.x-event.stageX;
				mouseOldPos.y=mouseOldPos.y-event.stageY;
				worldView.changeOffset(mouseOldPos);
				worldView.stopDrag();
				dragging=false;
			}
		}
		
		public function worldMouseClick(event:MouseEvent):void		
		{
			
			var town=myMap.findTownByLocation((event.stageX+worldView.Offset.x),(event.stageY+worldView.Offset.y));
			if(town!=null)
			{
				worldView.showTownInfo(town);
				trace(myPlayer.Regiments.Get(0).data.Units.Length);
			}
			else
			{
				worldView.hideTownInfo();
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
		public function gameLoop(event:TimerEvent):void
		{
			var i:int=0;
			while(i<regiments.Length)
			{
				var reg:Regiment=regiments.Get(i).data;
				var loc=new Point(reg.x,reg.y);
				if(Point.distance(loc,reg.Destination)<0.5)
				{
					reg.Location=reg.Destination;
					reg.Destination=new Point(0,0);
					reg.resetDistance();
					worldView.removeAsset(reg);
					regiments.Remove(reg);
				}
				else
				{
					//move this guy
					var newLoc=Point.interpolate(reg.Destination,reg.Location,reg.DistanceTraveled);
					trace();
					reg.changeDistance(1/Point.distance(reg.Location,reg.Destination));
					reg.x=newLoc.x;
					reg.y=newLoc.y;
					i++;
				}
			}
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