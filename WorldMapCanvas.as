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
	import contents.TownInfoBar;
	import contents.ArmySelectionScreen;
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
		private var currTown:Town;
		private var currentTarget:Town;
		private var townInfoBar:TownInfoBar;
		private var armyManagementScreen:ArmySelectionScreen;
		private var currentState:int;
		
		
		//The old position of the mouse for the sake of movement distance
		private var mouseOldPos:Point;
		/**
		* Load all contents to the canvas
		*/
		public function loadContents():void
		{
			this.worldView=new WorldView();
			this.townInfoBar=new TownInfoBar();
			this.armyManagementScreen=new ArmySelectionScreen();
			townInfoBar.x=GameConfig.SCREEN_WIDTH-275;
			townInfoBar.y=0;
			myMap=new Map();
			gameTimer=new Timer(100,0);
			gameTimer.addEventListener(TimerEvent.TIMER,gameLoop);
			regiments=new LinkedList();

			//Build the District map
			for(var i:int=0;i<11;++i)
			{
				var clip:MovieClip=WorldSpriteInfo.getSprite(i);

				clip.x=WorldConfig.getInfo(i).x;
				clip.y=WorldConfig.getInfo(i).y;
				myMap.addDistrict(District(clip));
			}
									

					
			//Will read all of the towns of the server in order to get them!
			for(var i:int=0;i<5;++i)
			{
				var temp2:Town=WorldConfig.getTownInfo(i);
				myMap.addTown(temp2);
				temp2.MyDistrict=myMap.Districts[WorldConfig.getTownDistrict(i)];
				temp2.MyDistrict.addTown(temp2);
				
				
			}
			//time for districts too!
			
			
			enemyPlayer=new Player("Steve","Steve The Great!",GameConfig.BRITISH);
			myPlayer=new Player("Rob","Robtacular",GameConfig.AMERICAN);
			
			var reg:Regiment=new Regiment("Regiment 1",myPlayer.Name,myPlayer.Side);
			var reg2:Regiment=new Regiment("Enemies",enemyPlayer.Name,enemyPlayer.Side);
			reg.addUnit(new Soldier(25,SoldierType.MINUTEMAN));
			
			reg2.addUnit(new Soldier(20,SoldierType.MINUTEMAN));
			reg.Location=myMap.Towns[0].Location;
			myMap.Towns[0].Occupier=reg;
			myMap.Towns[0].modifyWorkers(10);
			myMap.Towns[0].conquer(myPlayer.Name,myPlayer.Side);
			myMap.Towns[1].conquer(enemyPlayer.Name,enemyPlayer.Side);
			reg2.Location=myMap.Towns[1].Location;
			myMap.Towns[1].Occupier=reg2;

			

			
			myPlayer.addRegiment(reg);
			enemyPlayer.addRegiment(reg2);
			
			this.worldView.TownInfo.economicButton.addEventListener(MouseEvent.CLICK,townEconomicButtonClick);
			this.worldView.TownInfo.militaryButton.addEventListener(MouseEvent.CLICK,townMilitaryButtonClick);
			this.worldView.WorkerManagement.acceptButton.addEventListener(MouseEvent.CLICK,workerManagementAcceptButtonClick);
			this.worldView.WorkerManagement.cancelButton.addEventListener(MouseEvent.CLICK,workerManagementCancelButtonClick);
			
			armyManagementScreen.acceptButton.addEventListener(MouseEvent.CLICK,armyManagementAcceptButtonClick);
			armyManagementScreen.cancelButton.addEventListener(MouseEvent.CLICK,armyManagementCancelButtonClick);


			
			this.worldView.addAssets(myMap.Districts);			
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
			this.addChild(townInfoBar);
			this.addChild(cityButton);
			
			gameTimer.start();
			
			
		}
		
		
		public function cityButtonClick(event:MouseEvent):void
		{
			
			//MovieClip(parent).gotoAndStop(GameConfig.CITY_FRAME);
			MovieClip(parent).switchGame();
		}
		
		public function townEconomicButtonClick(event:MouseEvent):void
		{
			//Do military things
			townInfoBarEconomic(currTown);
			
			
		}
		
		public function townInfoBarEconomic(town:Town):void
		{
			changeTownInfoBar(WorldConfig.TOWN_BAR_ECONOMIC);
			
			this.townInfoBar.sendWorkersButton.addEventListener(MouseEvent.CLICK,townSendWorkersButtonClick);
			townInfoBar.updateAttributesEconomic(currTown);
			if(currTown.Owner==myPlayer.Name)
			{
				
				this.townInfoBar.sendWorkersButton.visible=true;
				this.townInfoBar.sendWorkersButton.enabled=true;
			}
			else
			{
				this.townInfoBar.sendWorkersButton.visible=false;
				this.townInfoBar.sendWorkersButton.enabled=false;
			}
			
			
		}
		
		public function townMilitaryButtonClick(event:MouseEvent):void
		{
			//Do military things
			townInfoBarMilitary(currTown);
		}
		
		public function townInfoBarMilitary(town:Town):void
		{
			changeTownInfoBar(WorldConfig.TOWN_BAR_MILITARY);
			this.townInfoBar.attackButton.addEventListener(MouseEvent.CLICK,townAttackButtonClick);
			this.townInfoBar.reinforceButton.addEventListener(MouseEvent.CLICK,townReinforceButtonClick);
			if(currTown.Owner==myPlayer.Name)
			{
				townInfoReinforce();
			}
			else
			{
				townInfoAttack();
			}
			this.townInfoBar.updateAttributesMilitary(currTown);
			
		}
		
		
		public function townInfoAttack():void
		{
			
			townInfoBar.attackButton.enabled=true;
			townInfoBar.attackButton.visible=true;
			townInfoBar.reinforceButton.enabled=false;
			townInfoBar.reinforceButton.visible=false;

		}
		public function townInfoReinforce():void
		{
			
			townInfoBar.reinforceButton.enabled=true;
			townInfoBar.reinforceButton.visible=true;
			townInfoBar.attackButton.enabled=false;
			townInfoBar.attackButton.visible=false;
		}
		
		public function clearTownBar():void
		{
			changeTownInfoBar(WorldConfig.TOWN_BAR_BLANK);
		}
		
		public function changeTownInfoBar(frameIn:int):void
		{
			townInfoBar.gotoAndStop(frameIn);
		}
		
		
		
		
		public function townAttackButtonClick(event:MouseEvent):void
		{
			//Set the state to be attacking, then allow clicking on a town for deciding what troops to send.
			currentState=WorldConfig.STATE_ATTACK;
			/*
			myPlayer.Regiments.Get(0).data.Destination=event.currentTarget.parent.Location;
			myPlayer.Regiments.Get(0).data.x=myPlayer.Regiments.Get(0).data.Location.x;
			myPlayer.Regiments.Get(0).data.y=myPlayer.Regiments.Get(0).data.Location.y;
			myPlayer.Regiments.Get(0).data.Intention=WorldConfig.ATTACK;
			regiments.Add(myPlayer.Regiments.Get(0).data);
			worldView.addAsset(myPlayer.Regiments.Get(0).data);
			*/
		}
		
		public function townReinforceButtonClick(event:MouseEvent):void
		{
			//Do other things
			currentState=WorldConfig.STATE_REINFORCE;
			/*

			*/
		}
		
		public function sendRegiment(regiment:Regiment):void
		{
			regiment.x=regiment.Location.x;
			regiment.y=regiment.Location.y;
			regiments.Add(regiment);
			worldView.addAsset(regiment);
			
		}
		
		public function townSendWorkersButtonClick(event:MouseEvent):void
		{
			//Do worker things
			currentState=WorldConfig.STATE_WORKERS;
		}
		
		public function workerManagementAcceptButtonClick(event:MouseEvent):void
		{	
			var reg:Regiment = new Regiment("","",myPlayer.Side);
			reg.addUnit(new Soldier(worldView.WorkerManagement.numWorkers(),SoldierType.WORKER));
			currTown.modifyWorkers(-worldView.WorkerManagement.numWorkers());
			reg.Destination=currentTarget.Location;
			reg.Location=currTown.Location;
			reg.Intention=WorldConfig.WORKER;
			sendRegiment(reg);
			worldView.hideWorkerManagement();
			currentState=WorldConfig.STATE_NONE;
		}

		public function workerManagementCancelButtonClick(event:MouseEvent):void
		{
			worldView.hideWorkerManagement();
			currentState=WorldConfig.STATE_NONE;
		}

		
		public function armyManagementAcceptButtonClick(event:MouseEvent):void
		{
			if(this.contains(armyManagementScreen))
			{
				this.removeChild(armyManagementScreen);
			}
			//Do other army things based on state
			var reg:Regiment = new Regiment("","",myPlayer.Side);
			var node:SoldierInfoNode=SoldierType.getSoldierInfo(SoldierType.MINUTEMAN);
			
			//Build up the regiment with the necesary amounts and unit types
			reg.addUnit(new Soldier(armyManagementScreen.numMinutemen(),SoldierType.MINUTEMAN));
			reg.Destination=currentTarget.Location;
			currTown.removeOccupationAmount(reg);
			reg.Location=currTown.Location;
			reg.Owner=myPlayer.Name;
			reg.Intention=armyManagementScreen.Intention;
			sendRegiment(reg);
			
			
			currentState=WorldConfig.STATE_NONE;
		}
		
		public function armyManagementCancelButtonClick(event:MouseEvent):void
		{
			if(this.contains(armyManagementScreen))
			{
				this.removeChild(armyManagementScreen);
			}
			currentState=WorldConfig.STATE_NONE;
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
			if(currentState!=WorldConfig.STATE_SELECTING)
			{
				currTown=myMap.findTownByLocation((event.stageX+worldView.Offset.x),(event.stageY+worldView.Offset.y));
			}

			if(currTown!=null)
			{
				if(currentState==WorldConfig.STATE_NONE)
				{
					currentTarget=currTown;
					worldView.showTownInfo(currTown);

				}
				else if(currentState==WorldConfig.STATE_REINFORCE)
				{
					armyManagementScreen.updateAttributes(currTown,WorldConfig.REINFORCE);
					currentState=WorldConfig.STATE_SELECTING;
					this.addChild(armyManagementScreen);

				}
				else if(currentState==WorldConfig.STATE_ATTACK)
				{
					armyManagementScreen.updateAttributes(currTown,WorldConfig.ATTACK);
					currentState=WorldConfig.STATE_SELECTING;
					this.addChild(armyManagementScreen);
				}
				else if(currentState==WorldConfig.STATE_WORKERS)
				{
					worldView.showWorkerManagement(currTown);
					currentState=WorldConfig.STATE_SELECTING;
				}
				
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
					else if(reg.Intention==WorldConfig.REINFORCE)
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
					else if(reg.Intention==WorldConfig.WORKER)
					{
						town.modifyWorkers(reg.TotalAmount);
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