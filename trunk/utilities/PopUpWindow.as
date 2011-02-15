package utilities{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import classes.*;
	import constant.*;
	
	
	/**
	* PopUpWindow GUI
	* This class will handle and process information to display on the popup-screen.
	* In this case, stat-popup screen.
	*/
	public class PopUpWindow extends MovieClip
	{
		
		private var icons_add:Array;		// Array of Icons (Trigger Button)
		private var icons_minus:Array;		// Array of Icons Minus (Trigger Button)
		private var icon_switch:TriggerButton;
		
		/* Add and remove worker button */
		private var add_worker:TriggerButton;
		private var remove_worker:TriggerButton;
		
		
		/* Internal Dependency display */
		private var TOP_RIGHT:int = 5;
		private var AT_ALLOCATE:int = 60;
		private var ADD_LOCATE_X:int = 120;
		private var REMOVE_LOCATE_Y:int = 140;
		
		/**
		* Constructor
		*/
		public function PopUpWindow(x:int,y:int, type:int)
		{
			this.x = x;
			this.y = y;
			createAddMinusButtons();
			if (type == Images.POP_STAT)
			{
				icon_switch.y = AT_ALLOCATE;
			}
			switchToWin(type);
			deactivate();
		}
		
		/**
		* Create increment and decrement buttons
		*/
		private function createAddMinusButtons():void
		{
			//trace("AddPlus Button");
			icons_add = new Array();
			icons_minus = new Array();
			
			for (var i:int = 0; i < SoldierType.TOTAL_SOLDIERS_TYPE; ++i)
			{
				icons_add.push(new TriggerButton(ADD_LOCATE_X,27+i*22, GameConfig.COMM_PLUS_SIGN));
				icons_minus.push(new TriggerButton(REMOVE_LOCATE_Y,27+i*22, GameConfig.COMM_MINUS_SIGN));
				this.addChild(icons_add[i]);
				this.addChild(icons_minus[i]);
			}
			
			constructSwitchIcon();
			
			/* For stat screen */
			add_worker = new TriggerButton(ADD_LOCATE_X, 30, GameConfig.COMM_PLUS_SIGN);
			remove_worker = new TriggerButton(REMOVE_LOCATE_Y, 30, GameConfig.COMM_MINUS_SIGN);
			
			this.addChild(add_worker);
			this.addChild(remove_worker);
		}
		
		/*
		* Construct switching-menu icon
		*/
		private function constructSwitchIcon():void
		{
			icon_switch = new TriggerButton(ADD_LOCATE_X, TOP_RIGHT, GameConfig.COMM_SWITCH_STAT);
			this.addChild(icon_switch);
		}
		
		/**
		* identify a clicked button corresponding to soldier type
		* @param y: Y location
		* @return Soldier Type
		*/
		public function identifyButton(y:int):int
		{
			// calculate index with offset
			if (currentFrame == Images.POP_STAT_MIL){
				
				return (y-27)/22 + SoldierType.MINUTEMAN;
			} else {
				return SoldierType.WORKER;
			}
		}
		
		
		/**
		* Enable add and minus buttons to be displayed
		*/
		private function enableAddMinusButtons():void
		{
			for (var i:int = 0; i < SoldierType.TOTAL_SOLDIERS_TYPE; ++i)
			{
				icons_add[i].visible= true;
				icons_minus[i].visible = true;
			}
		}
		
		/**
		* Hide add and minus buttons 
		*/
		private function disableAddMinusButtons():void
		{
			for (var i:int = 0; i < SoldierType.TOTAL_SOLDIERS_TYPE; ++i)
			{
				icons_add[i].visible= false;
				icons_minus[i].visible = false;
			}
		}
		
		private function enableWorkerButton():void
		{
			add_worker.visible = true;
			remove_worker.visible = true;
		}
		
		private function disableWorkerButton():void
		{
			add_worker.visible = false;
			remove_worker.visible = false;
		}
		
		/**
		* update information to be displayed
		* @param profile: Player's profile
		*/
		public function updateInfo(profile:Player):void
		{
			if (currentFrame==Images.POP_STAT)
			{
				updatePopulationInfo(profile);
			} else if (currentFrame==Images.POP_STAT_MIL)
			{
				updateSoldiersInfo(profile);
			}
		}
		
		/**
		* Update population information
		* @param profile: User's profile
		*/
		private function updatePopulationInfo(profile:Player):void
		{
			this.soldiersInfo.text = profile.AmountSoldiersAtCity.toString();
			this.workersInfo.text = profile.AmountWorkers.toString();
			this.comInfo.text = (profile.Population - ( int(soldiersInfo.text) + int(workersInfo.text) )).toString();
			this.popInfo.text = profile.Population.toString();
		}
		
		/**
		* return total number of soldiers for each type
		* @param group :LinkedList of Regiment
		* @param type: Type of soldier
		*/
		private function getTotalSoldiersOfType(group:LinkedList,type:int):int
		{
			var total_soldiers:int = 0;
			//trace(group.Length);
			for (var i:int=0; i < group.Length; ++i)
			{
				total_soldiers += group.Get(i).data.totalType(type);
				//trace("Reg: " + i +" Gte ttoata " + total_soldiers + " Type: " + type);
			}
			
			//trace("Total Soliders : " + total_soldiers);
			return total_soldiers;
		}
		
		private function getTotalSoldiersInFirstRegiment(group:LinkedList, type:int):int
		{
			return group.Get(0).data.totalType(type);
		}
		
		/**
		* Return total numbers of all soldiers
		* @param: LinkedList of regiment
		* @return : Total numbers of all soldiers
		*/
		private function getAllTotalSoldiers(group:LinkedList):int
		{
			return getTotalSoldiersOfType(group, SoldierType.MINUTEMAN)+
			getTotalSoldiersOfType(group, SoldierType.SHARPSHOOTER)+
			getTotalSoldiersOfType(group, SoldierType.OFFICER)+
			getTotalSoldiersOfType(group, SoldierType.CALVARY)+
			getTotalSoldiersOfType(group, SoldierType.CANNON)+
			getTotalSoldiersOfType(group, SoldierType.SCOUT)+
			getTotalSoldiersOfType(group, SoldierType.AGENT)+
			getTotalSoldiersOfType(group, SoldierType.POLITICIAN);
		}
		
		/**
		* Update total number of soldiers of each type
		* @param User's profile
		*/
		private function updateSoldiersInfo(profile:Player):void
		{
			this.minInfo.text = getTotalSoldiersInFirstRegiment(profile.Regiments, SoldierType.MINUTEMAN).toString();
			this.sharpInfo.text =getTotalSoldiersInFirstRegiment(profile.Regiments, SoldierType.SHARPSHOOTER).toString();
			this.officerInfo.text = getTotalSoldiersInFirstRegiment(profile.Regiments, SoldierType.OFFICER).toString();
			this.calInfo.text = getTotalSoldiersInFirstRegiment(profile.Regiments, SoldierType.CALVARY).toString();
			this.cannonInfo.text = getTotalSoldiersInFirstRegiment(profile.Regiments, SoldierType.CANNON).toString();
			this.scoutInfo.text = getTotalSoldiersInFirstRegiment(profile.Regiments, SoldierType.SCOUT).toString();
			this.agentInfo.text = getTotalSoldiersInFirstRegiment(profile.Regiments, SoldierType.AGENT).toString();
			this.polInfo.text = getTotalSoldiersInFirstRegiment(profile.Regiments, SoldierType.POLITICIAN).toString();
		}
		
		/**
		* Add external function (listener) to all buttons with the same type
		* @param command: Command or button types
		* @param event_trigger: Action trigger
		* @param func: Listener Action
		*/
		public function addExtFuncToButtons(command:int,event_trigger:String,func:Function):void
		{
			if (command==GameConfig.COMM_PLUS_SIGN)
			{
				for (var i:int = 0; i < icons_add.length; ++i)
				{
					icons_add[i].addEventListener(event_trigger,func);
				}
				add_worker.addEventListener(event_trigger, func);
			} else if(command==GameConfig.COMM_MINUS_SIGN) {
				for (var j:int = 0; j < icons_minus.length; ++j)
				{
					icons_minus[j].addEventListener(event_trigger,func);
				}
				remove_worker.addEventListener(event_trigger, func);
			} else if (command==GameConfig.COMM_SWITCH_STAT)
			{
				icon_switch.addEventListener(event_trigger,func);
			}
		}
		
		
		/**
		* Switch to a specific type of pop up windows
		* @param type: Type of pop-up windows
		*/
		public function switchToWin(type:int):void
		{
			if (type==Images.POP_STAT)
			{
				disableAddMinusButtons();
				enableWorkerButton();
			} else if (type==Images.POP_STAT_MIL)
			{
				enableAddMinusButtons();
				disableWorkerButton();
			}
			gotoAndStop(type);
		}
		
		/**
		* Auto switch to different stat menu
		*/
		public function autoSwitchStatMenu():void
		{
			if (currentFrame==Images.POP_STAT)
			{
				icon_switch.y = TOP_RIGHT;
				switchToWin(Images.POP_STAT_MIL);
			} else {
				icon_switch.y = AT_ALLOCATE;
				switchToWin(Images.POP_STAT);
			}
		}
		
		/**
		* Activate Pop up windows to be displayed
		*/
		public function activate():void
		{
			this.visible = true;
		}
		
		/**
		* Deactive pop up windows (disappear)
		*/
		public function deactivate():void
		{
			this.visible = false;
		}
		
		/**
		* check if window is being displayed
		*/
		public function isWindowsUp():Boolean
		{
			return this.visible;
		}
		
		/**
		* Auto switch between display and disappear
		*/
		public function autoSwitch():void
		{
			this.visible = !this.visible;
		}
		
		/**
		* return type of pop up windows
		*/
		public function get Type():int
		{
			return currentFrame;
		}
		
		
	}
}