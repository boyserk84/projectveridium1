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
		private var enemyPlayer:Player;
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
				var temp2:Town=WorldConfig.getTownInfo(i);
				myMap.addTown(temp2);
				
			}
			
			enemyPlayer=new Player("Steve","Steve The Great!",GameConfig.BRITISH);
			myPlayer=new Player("Rob","Robtacular",GameConfig.AMERICAN);
			
			var reg:Regiment=new Regiment("Regiment 1",myPlayer.Name,myPlayer.Side);
			var reg2:Regiment=new Regiment("Enemies",enemyPlayer.Name,enemyPlayer.Side);
			var temp:SoldierInfoNode=SoldierType.getSoldierInfo(SoldierType.MINUTEMAN);
			reg.addUnit(new Soldier(20,temp.Weapon,temp.Armor,temp.Skill,temp.Type));
			
			reg2.addUnit(new Soldier(20,temp.Weapon,temp.Armor,temp.Skill,temp.Type));
			reg.Location=myMap.Towns[0].Location;
			myMap.Towns[0].Occupier=reg;			
			myMap.Towns[0].conquer(myPlayer.Name,myPlayer.Side);
			myMap.Towns[1].conquer(enemyPlayer.Name,enemyPlayer.Side);
			reg2.Location=myMap.Towns[1].Location;
			myMap.Towns[1].Occupier=reg2;

			

			
			myPlayer.addRegiment(reg);
			enemyPlayer.addRegiment(reg2);
			
			this.worldView.TownInfo.attackButton.addEventListener(MouseEvent.CLICK,townAttackButtonClick);
			this.worldView.TownInfo.reinforceButton.addEventListener(MouseEvent.CLICK,townReinforceButtonClick);
			
			
			this.worldView.addAssets(myMap.Towns);
			this.input = new IOHandler(0,0,WorldConfig.INPUT_WIDTH, WorldConfig.INPUT_HEIGHT);
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
			MovieClip(parent).switchGame();
		}
		
		public function townAttackButtonClick(event:MouseEvent):void
		{
			//do things
			myPlayer.Regiments.Get(0).data.Destination=event.currentTarget.parent.Location;
			myPlayer.Regiments.Get(0).data.x=myPlayer.Regiments.Get(0).data.Location.x;
			myPlayer.Regiments.Get(0).data.y=myPlayer.Regiments.Get(0).data.Location.y;
			myPlayer.Regiments.Get(0).data.Intention=WorldConfig.ATTACK;
			regiments.Add(myPlayer.Regiments.Get(0).data);
			worldView.addAsset(myPlayer.Regiments.Get(0).data);
		}
		
		public function townReinforceButtonClick(event:MouseEvent):void
		{
			//Do other things
						//do things
						trace("Clicked");
			myPlayer.Regiments.Get(0).data.Destination=event.currentTarget.parent.Location;
			myPlayer.Regiments.Get(0).data.x=myPlayer.Regiments.Get(0).data.Location.x;
			myPlayer.Regiments.Get(0).data.y=myPlayer.Regiments.Get(0).data.Location.y;
			myPlayer.Regiments.Get(0).data.Intention=WorldConfig.REINFORCE;
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
			
			var town:Town=myMap.findTownByLocation((event.stageX+worldView.Offset.x),(event.stageY+worldView.Offset.y));
			if(town!=null)
			{
				if(town.Owner==myPlayer.Name)
				{
					worldView.townInfoReinforce();
				}
				else
				{
					worldView.townInfoAttack();
				}
				worldView.showTownInfo(town);
				
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
		
		/*
		* Performs the calculation to determine how many defenders will die
		* @param1: The attacking regiment
		* @param2: The defending regiment
		* @return: How many defending units will die
		*/
		private function battleFormula(attacker:Regiment,defender:Regiment):int
		{
			var amount:int=0;
			amount=attacker.TotalAmount*
				(
				(attacker.TotalAmount*attacker.TotalAttack)
				/
				(defender.TotalAmount*defender.TotalDefense)
				);
			amount=Math.ceil(amount);
			if(amount>attacker.TotalAmount)
			{
				amount=attacker.TotalAmount;
			}
			return amount;
		}
		
		/*
		* Perform the battle operation, this will probably be shifted to the server
		* @param1: The attacking regiment
		* @param2: The defending regiment
		*/
		public function resolveBattle(attacker:Regiment,defender:Regiment):void
		{
			while(attacker.TotalAmount>0 && defender.TotalAmount>0)
			{
				var defenderLosses=battleFormula(attacker,defender);
				var attackerLosses=battleFormula(defender,attacker);
				attacker.incurLosses(attackerLosses);
				defender.incurLosses(defenderLosses);
			}
			
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
					//Regiment arrived at location now determine intentions
					reg.Location=reg.Destination;
					var town:Town=myMap.findTownByLocation(reg.Destination.x,reg.Destination.y);
					reg.resetDistance();
					if(reg.Intention==WorldConfig.ATTACK)
					{
						var attacker:Regiment=reg;
						if(town.Occupier!=null)
						{
							var defender:Regiment=town.Occupier;
							resolveBattle(attacker,defender);
							trace("Attacker Remainder: "+attacker.TotalAmount);
							trace("Defender Remainder: "+defender.TotalAmount);
						}

						
						if(attacker.TotalAmount>0)
						{
							town.conquer(attacker.Owner,attacker.Side);

							town.Occupier=attacker;
						}
					}
					else 
					if(reg.Intention==WorldConfig.REINFORCE)
					{
						if(town.Occupier!=null)
						{
							//add these troops to that regiment
							town.Occupier.addRegiment(reg);
						}
						else
						{
							town.Occupier=reg;
						}
					}
					//reg.Destination=new Point(0,0);
					regiments.Remove(reg);
					worldView.removeAsset(reg);
					
				}
				else
				{
					//move this guy
					var newLoc=Point.interpolate(reg.Destination,reg.Location,reg.DistanceTraveled);
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