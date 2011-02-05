﻿package {
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import classes.*;
	import constant.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
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
		private var secondTown:Town;
		private var currentTarget:Town;
		private var townInfoBar:TownInfoBar;
		private var armyManagementScreen:ArmySelectionScreen;
		private var currentState:int;
		private var startPoint:Point;
		
		//The towns currently highlightes, we need to set back to unhighlighted
		private var selectedTowns:Array;
		
		
		//The old position of the mouse for the sake of movement distance
		private var mouseOldPos:Point;
		/**
		* Load all contents to the canvas
		*/
		public function loadContents(playerIn:Player=null):void
		{
			this.input = new IOHandler(0,0,WorldConfig.INPUT_WIDTH, WorldConfig.INPUT_HEIGHT);
			this.worldView=new WorldView();
			this.townInfoBar=new TownInfoBar();
			this.armyManagementScreen=new ArmySelectionScreen();
			townInfoBar.x=GameConfig.SCREEN_WIDTH-275;
			townInfoBar.y=0;
			myMap=new Map();
			gameTimer=new Timer(100,0);
			gameTimer.addEventListener(TimerEvent.TIMER,gameLoop);
			regiments=new LinkedList();
			myPlayer=playerIn;
			
			

			//Build the District map
			
			for(var i:int=0;i<11;++i)
			{
				var clip:MovieClip=WorldSpriteInfo.getSprite(i);

				clip.x=WorldConfig.getInfo(i).x;
				clip.y=WorldConfig.getInfo(i).y;
				myMap.addDistrict(District(clip));
			}
			
									

					
			//Will read all of the towns of the server in order to get them!
			for(var j:int=0;j<53;++j)
			{
				var nodeSet:GraphNode = new GraphNode();
				var temp2:Town=WorldConfig.getTownInfo(j);
				temp2.numberText.text=temp2.Name;
				nodeSet.MyTown=temp2;
				temp2.Node=nodeSet;
				myMap.addTown(temp2);
				temp2.MyDistrict=myMap.Districts[WorldConfig.getTownDistrict(j)];
				temp2.MyDistrict.addTown(temp2);
				
				
			}

			for(var n:int=0;n<53;++n)
			{
				var node=myMap.getTownByIndex(n).Node;
				var neighbors:Array=WorldConfig.getNeighbors(n);
				for(var a:int=0;a<neighbors.length;++a)
				{
					node.pushNeighbor(myMap.getTownByIndex(neighbors[a]).Node);
				}
				
			}
			
			
			if(myPlayer==null)
			{
				myPlayer=new Player("Rob","Robtacular",GameConfig.AMERICAN);
				var reg:Regiment=new Regiment("Regiment 1",myPlayer.Name,myPlayer.Side);
				reg.addUnit(new Soldier(25,SoldierType.MINUTEMAN));
				reg.addUnit(new Soldier(3,SoldierType.OFFICER));			
				reg.addUnit(new Soldier(10,SoldierType.SHARPSHOOTER));
				reg.addUnit(new Soldier(1,SoldierType.CANNON));
				reg.addUnit(new Soldier(1,SoldierType.AGENT));
				reg.addUnit(new Soldier(1,SoldierType.POLITICIAN));
				reg.Location=myMap.Towns[0].Location;
				myMap.Towns[0].Occupier=reg;
				myMap.Towns[0].modifyWorkers(10);
				myMap.Towns[0].conquer(myPlayer.Name,myPlayer.Side);
				
				startPoint=myMap.Towns[0].Location.clone();
				
				startPoint.x-=int(WorldConfig.INPUT_WIDTH/2);
				startPoint.y-=int(WorldConfig.INPUT_HEIGHT/2);
				
				//startPoint.x-=int(GameConfig.SCREEN_WIDTH/2);
				//startPoint.y-=int(GameConfig.SCREEN_HEIGHT/2);

			}

			
			
			enemyPlayer=new Player("Steve","Steve The Great!",GameConfig.BRITISH);

			
			
			var reg2:Regiment=new Regiment("Enemies",enemyPlayer.Name,enemyPlayer.Side);
			
			reg2.addUnit(new Soldier(20,SoldierType.MINUTEMAN));

			
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


			
			//this.worldView.addAssets(myMap.Districts);	
			trace("Hello!");
			var worldMap:MovieClip=new WorldMap();
			trace("ow?");

			trace("or here");
			
			this.worldView.addAsset(worldMap);
			
			this.worldView.addAssets(myMap.Towns);
			this.worldView.setStartPoint(startPoint);
			//this.worldView.setStartPoint(new Point(-1892,-679));
			worldView.addEventListener(MouseEvent.MOUSE_DOWN,worldMouseDown);
			worldView.addEventListener(MouseEvent.MOUSE_UP,worldMouseUp);
			worldView.addEventListener(MouseEvent.CLICK,worldMouseClick);
			worldView.addEventListener(MouseEvent.MOUSE_OUT,worldMouseOut);

			/*input.addEventListener(MouseEvent.MOUSE_DOWN,worldMouseDown);
			input.addEventListener(MouseEvent.MOUSE_UP,worldMouseUp);
			input.addEventListener(MouseEvent.MOUSE_OUT,worldMouseOut);
			input.addEventListener(MouseEvent.CLICK,worldMouseClick);*/
			
			cityButton=new TriggerButton(354,526, GameConfig.CHANGE_WORLD);
			cityButton.addEventListener(MouseEvent.CLICK,cityButtonClick);

			
			this.addChild(worldView);
			//this.addChild(input);			


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
			//Do economic things
			townInfoBarEconomic(currTown);
			secondTown=currTown;
			
			
		}
		
		public function townInfoBarEconomic(town:Town):void
		{
			changeTownInfoBar(WorldConfig.TOWN_BAR_ECONOMIC);
			
			this.townInfoBar.sendWorkersButton.addEventListener(MouseEvent.CLICK,townSendWorkersButtonClick);
			this.townInfoBar.sendAgentsButton.addEventListener(MouseEvent.CLICK,townSendAgentsButtonClick);
			this.townInfoBar.releaseAgentsButton.addEventListener(MouseEvent.CLICK,townReleaseAgentsButtonClick);
			this.townInfoBar.sendPoliticiansButton.addEventListener(MouseEvent.CLICK,townSendPoliticiansButtonClick);
			this.townInfoBar.releasePoliticiansButton.addEventListener(MouseEvent.CLICK,townReleasePoliticiansButtonClick);
			townInfoBar.updateAttributesEconomic(town,myPlayer.Side);
			
			
			if(town.Owner==myPlayer.Name)
			{
				this.townInfoBar.sendAgentsButton.visible=false;
				this.townInfoBar.sendAgentsButton.enabled=false;
				this.townInfoBar.sendPoliticiansButton.visible=false;
				this.townInfoBar.sendPoliticiansButton.enabled=false;
				this.townInfoBar.releaseAgentsButton.visible=false;
				this.townInfoBar.releaseAgentsButton.enabled=false;
				this.townInfoBar.releasePoliticiansButton.visible=false;
				this.townInfoBar.releasePoliticiansButton.enabled=false;
				
				this.townInfoBar.sendWorkersButton.visible=true;
				this.townInfoBar.sendWorkersButton.enabled=true;
			}
			else
			{
				//if the player already has a politician there or not
				trace(myPlayer.HalfTowns.Contains(town));
				if(myPlayer.HalfTowns.Contains(town))
				{
					//This means they have a politician there
					if(town.Side==myPlayer.Side)
					{
						this.townInfoBar.sendPoliticiansButton.visible=false;
						this.townInfoBar.sendPoliticiansButton.enabled=false;
						this.townInfoBar.releasePoliticiansButton.visible=true;
						this.townInfoBar.releasePoliticiansButton.enabled=true;
						this.townInfoBar.releaseAgentsButton.visible=false;
						this.townInfoBar.releaseAgentsButton.enabled=false;
					}
					//This means they have an agent there
					else
					{
						this.townInfoBar.sendAgentsButton.visible=false;
						this.townInfoBar.sendAgentsButton.enabled=false;
						this.townInfoBar.releaseAgentsButton.visible=true;
						this.townInfoBar.releaseAgentsButton.enabled=true;
						this.townInfoBar.releasePoliticiansButton.visible=false;
						this.townInfoBar.releasePoliticiansButton.enabled=false;
					}
				}
				else
				{
					if(town.Side==myPlayer.Side)
					{
						this.townInfoBar.sendAgentsButton.visible=false;
						this.townInfoBar.sendAgentsButton.enabled=false;
						this.townInfoBar.sendPoliticiansButton.visible=true;
						this.townInfoBar.sendPoliticiansButton.enabled=true;
					}
					else
					{
						this.townInfoBar.sendAgentsButton.visible=true;
						this.townInfoBar.sendAgentsButton.enabled=true;
						this.townInfoBar.sendPoliticiansButton.visible=false;
						this.townInfoBar.sendPoliticiansButton.enabled=false;
					}
					this.townInfoBar.releasePoliticiansButton.visible=false;
					this.townInfoBar.releasePoliticiansButton.enabled=false;
					this.townInfoBar.releaseAgentsButton.visible=false;
					this.townInfoBar.releaseAgentsButton.enabled=false;
				}
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
			this.townInfoBar.updateAttributesMilitary(currTown,myPlayer.Side);
			
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
		
		
		//Highlights the towns capable of sending and sets the list
		private function selectValidTowns(town:Town):void
		{
			var validTowns=myMap.findValidNeighbors(currentTarget.Node,myPlayer);
			selectedTowns=validTowns;
			for(var t:int=0;t<validTowns.length;++t)
			{
				validTowns[t].gotoAndStop(4);
				
			}
		}
		
		private function clearSelectedTowns():void
		{
			for(var t:int=0;t<selectedTowns.length;++t)
			{
				selectedTowns[t].occupationGraphic();
				
				
			}
			selectedTowns=null;
		}
		
		public function townAttackButtonClick(event:MouseEvent):void
		{
			//Set the state to be attacking, then allow clicking on a town for deciding what troops to send.
			currentState=WorldConfig.STATE_ATTACK;
			selectValidTowns(currentTarget);
			
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
			selectValidTowns(currentTarget);
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
			selectValidTowns(currentTarget);
		}
		
		public function townSendAgentsButtonClick(event:MouseEvent):void
		{
			//Send agents to this town
			currentState=WorldConfig.STATE_AGENTS;
			selectValidTowns(currentTarget);
		}
		
		public function townSendPoliticiansButtonClick(event:MouseEvent):void
		{
			//Send politicians to this town			
			currentState=WorldConfig.STATE_POLITICIANS;
			selectValidTowns(currentTarget);
		}
		
		public function townReleaseAgentsButtonClick(event:MouseEvent):void
		{
			secondTown.modifyAgents(-1);
			myPlayer.HalfTowns.Remove(secondTown);
			clearTownBar();
			townInfoBarEconomic(secondTown);



		}
		
		
		public function townReleasePoliticiansButtonClick(event:MouseEvent):void
		{
			secondTown.modifyPoliticians(-1);
			myPlayer.HalfTowns.Remove(secondTown);
			clearTownBar();
			townInfoBarEconomic(secondTown);

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
			clearSelectedTowns();
			currentState=WorldConfig.STATE_NONE;
		}

		public function workerManagementCancelButtonClick(event:MouseEvent):void
		{
			worldView.hideWorkerManagement();
			clearSelectedTowns();
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
			//Minutemen
			if(armyManagementScreen.numMinutemen()>0)
			{
				reg.addUnit(new Soldier(armyManagementScreen.numMinutemen(),SoldierType.MINUTEMAN));
			}
			//Sharpshooters
			if(armyManagementScreen.numSharpshooters()>0)
			{
				reg.addUnit(new Soldier(armyManagementScreen.numSharpshooters(),SoldierType.SHARPSHOOTER));
			}
			//Cannoneers
			if(armyManagementScreen.numCannons()>0)
			{
				reg.addUnit(new Soldier(armyManagementScreen.numCannons(),SoldierType.CANNON));
			}
			//Officers
			if(armyManagementScreen.numOfficers()>0)
			{
				reg.addUnit(new Soldier(armyManagementScreen.numOfficers(),SoldierType.OFFICER));
			}
			//Cavalry
			
			//Agents
			if(armyManagementScreen.numAgents()>0)
			{
				reg.addUnit(new Soldier(armyManagementScreen.numAgents(),SoldierType.AGENT));
			}
			//Politicians
			if(armyManagementScreen.numPoliticians()>0)
			{
				reg.addUnit(new Soldier(armyManagementScreen.numPoliticians(),SoldierType.POLITICIAN));
			}
			
			reg.Destination=currentTarget.Location;
			currTown.removeOccupationAmount(reg);
			reg.Location=currTown.Location;
			reg.Owner=myPlayer.Name;
			reg.Intention=armyManagementScreen.Intention;
			sendRegiment(reg);
			
			clearSelectedTowns();
			currentState=WorldConfig.STATE_NONE;
			clearTownBar();
		}
		
		public function armyManagementCancelButtonClick(event:MouseEvent):void
		{
			if(this.contains(armyManagementScreen))
			{
				this.removeChild(armyManagementScreen);
			}
			currentState=WorldConfig.STATE_NONE;
			clearSelectedTowns();
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
			trace(event.target);

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
					trace("Showing info");
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
					if(currTown.Owner==myPlayer.Name)
					{
						armyManagementScreen.updateAttributes(currTown,WorldConfig.ATTACK);
						currentState=WorldConfig.STATE_SELECTING;
						this.addChild(armyManagementScreen);
					}
				}
				else if(currentState==WorldConfig.STATE_WORKERS)
				{
					worldView.showWorkerManagement(currTown);
					currentState=WorldConfig.STATE_SELECTING;
					
				}
				else if(currentState==WorldConfig.STATE_AGENTS)
				{
					var reg:Regiment = new Regiment("","",myPlayer.Side);
					if(currTown.Occupier.totalType(SoldierType.AGENT)>=1)
					{
						//Make this a function?
						reg.addUnit(new Soldier(1,SoldierType.AGENT));
						currTown.Occupier.removeRegiment(reg);
						reg.Destination=currentTarget.Location;
						reg.Location=currTown.Location;
						reg.Intention=WorldConfig.AGENT;
						sendRegiment(reg);
						clearSelectedTowns();
						currentState=WorldConfig.STATE_NONE;
						
					}
					else
					{
						//Some kind of dialog saying there are no agents in this town
					}

				}
				else if(currentState==WorldConfig.STATE_POLITICIANS)
				{
					if(currTown.Occupier.totalType(SoldierType.POLITICIAN)>=1)
					{						
						//Make this a function? Possibly won't highlight if there are no agents nearby? Or button won't show!
						reg.addUnit(new Soldier(1,SoldierType.POLITICIAN));
						currTown.Occupier.removeRegiment(reg);
						reg.Destination=currentTarget.Location;
						reg.Location=currTown.Location;
						reg.Intention=WorldConfig.POLITICIAN;
						sendRegiment(reg);
						clearSelectedTowns();
						currentState=WorldConfig.STATE_NONE;
					}
					else
					{
						//Some kind of dialog saying there are no politicians in this town
					}
				}
				
			}
			else
			{
				worldView.hideTownInfo();
			}
		}
		
		
		
		
		
		
		/*
		* Performs the calculation to determine how many defenders will die
		* @param1: The attacking regiment
		* @param2: The defending regiment
		* @return: How many defending units will die
		*/
		private function battleFormula(attacker:Regiment,defender:Regiment):int
		{
			var amount:Number=0;
			amount=attacker.TotalAmount*
				(
				(attacker.TotalAttack)
				/
				(defender.TotalDefense)
				);

			amount=Math.ceil(amount);
			trace("Attack rating:"+attacker.TotalAmount*attacker.TotalAttack);
			trace("Defense Rating:"+defender.TotalAmount*defender.TotalDefense);
			trace("Amount!:"+amount);
			if(amount>attacker.TotalAmount+attacker.totalType(SoldierType.CANNON))
			{
				amount=attacker.TotalAmount+attacker.totalType(SoldierType.CANNON);
			}
			
			trace("Final Amount!:"+amount);
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
				//still need to determine the probability math for a normal curve for losses
				attacker.incurLosses(attackerLosses);
				defender.incurLosses(defenderLosses);
			}
			
		}
		
		public function AttackTown(town:Town, attacker:Regiment):void
		{
			if(town.Occupier!=null)
			{
				var defender:Regiment=town.Occupier;
				resolveBattle(attacker,defender);
				trace("Attacker Remainder: "+attacker.TotalAmount);
				trace("Defender Remainder: "+defender.TotalAmount);
			}

						
			if(attacker.TotalAmount>0)
			{
				if(myPlayer.HalfTowns.Contains(town))
				{
					attacker.addUnit(new Soldier(town.Agents,SoldierType.AGENT));
					town.modifyAgents(-town.Agents);
					myPlayer.removeHalfTown(town);
				}

				myPlayer.addTown(town);
				town.Occupier=attacker;
			}
		}
		
		/**
		* What to do when a regiment is reinforcing a town
		*
		*/
		public function ReinforceTown(town:Town,reg:Regiment):void
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
				if(Point.distance(loc,reg.Destination)<(reg.Speed/Point.distance(reg.Location,reg.Destination))*Point.distance(reg.Location,reg.Destination))
				{
					//Regiment arrived at location now determine intentions
					reg.Location=reg.Destination;
					var town:Town=myMap.findTownByLocation(reg.Destination.x,reg.Destination.y);
					reg.resetDistance();
					if(reg.Intention==WorldConfig.ATTACK)
					{
						//if the town gets captured by you before you get there
						if(town.Owner!=myPlayer.Name)
						{
							AttackTown(town,reg);
						}
						else
						{
							ReinforceTown(town,reg);
						}
						
					}
					else if(reg.Intention==WorldConfig.REINFORCE)
					{
						if(town.Owner!=myPlayer.Name)
						{
							AttackTown(town,reg);
						}
						else
						{
							ReinforceTown(town,reg);
						}
					}
					else if(reg.Intention==WorldConfig.WORKER)
					{
						if(town.Owner==myPlayer.Name)
						{
							town.modifyWorkers(reg.TotalAmount);
						}
					}
					else if(reg.Intention==WorldConfig.AGENT)
					{
						
						if(town.Side!=myPlayer.Side)
						{
							//Need to change it to represent there is an agent
							//Actually reduces how many resources are gained from town for all parties
							myPlayer.addHalfTown(town);
							town.modifyAgents(1);
						}
						else
						{
							if(town.Occupier!=null)
							{
								town.Occupier.addRegiment(reg);
							}
						}
					}
					else if(reg.Intention==WorldConfig.POLITICIAN)
					{
						if(town.Side==myPlayer.Side)
						{
							//Does not actually reduce the resources received from town
							myPlayer.addHalfTown(town);
							town.modifyPoliticians(1);
						}
					}
					
					
					regiments.Remove(reg);
					worldView.removeAsset(reg);
					
				}
				else
				{
					//move this guy along the interpolation
					var newLoc=Point.interpolate(reg.Destination,reg.Location,reg.DistanceTraveled);
					//Location refers to starting location
					reg.changeDistance((reg.Speed/Point.distance(reg.Location,reg.Destination)));
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
		public function WorldMapCanvas(playerIn:Player=null):void
		{
			this.loadContents(playerIn);
		}
	}
}
