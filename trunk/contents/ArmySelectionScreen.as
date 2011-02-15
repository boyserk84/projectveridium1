package contents{
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import classes.Town;
	import constant.SoldierType;
	import constant.GameConfig;
	
	public class ArmySelectionScreen extends MovieClip
	{
		
		
		private var intention:int;
		
		
		public function ArmySelectionScreen()
		{
			this.minuteMenText.text="0";
			this.plusButton.addEventListener(MouseEvent.CLICK,plusButtonClick);
			this.minusButton.addEventListener(MouseEvent.CLICK,minusButtonClick);
			this.minuteMenText.addEventListener(Event.CHANGE,textChangedEvent);
			
			this.officerPlusButton.addEventListener(MouseEvent.CLICK,officersPlusButtonClick);
			this.officerMinusButton.addEventListener(MouseEvent.CLICK,officersMinusButtonClick);
			this.officersText.addEventListener(Event.CHANGE,officersTextChangedEvent);
			
			this.sharpshootersPlusButton.addEventListener(MouseEvent.CLICK,sharpshootersPlusButtonClick);
			this.sharpshootersMinusButton.addEventListener(MouseEvent.CLICK,sharpshootersMinusButtonClick);
			this.sharpshootersText.addEventListener(Event.CHANGE,sharpshootersTextChangedEvent);
			
			this.cannonsPlusButton.addEventListener(MouseEvent.CLICK,cannonsPlusButtonClick);
			this.cannonsMinusButton.addEventListener(MouseEvent.CLICK,cannonsMinusButtonClick);
			this.cannonsText.addEventListener(Event.CHANGE,cannonsTextChangedEvent);
			
			this.agentsPlusButton.addEventListener(MouseEvent.CLICK,agentsPlusButtonClick);
			this.agentsMinusButton.addEventListener(MouseEvent.CLICK,agentsMinusButtonClick);
			this.agentsText.addEventListener(Event.CHANGE,agentsTextChangedEvent);
			
			this.politiciansPlusButton.addEventListener(MouseEvent.CLICK,politiciansPlusButtonClick);
			this.politiciansMinusButton.addEventListener(MouseEvent.CLICK,politiciansMinusButtonClick);
			this.politiciansText.addEventListener(Event.CHANGE,politiciansTextChangedEvent);
			
			this.cavalryPlusButton.addEventListener(MouseEvent.CLICK,cavalryPlusButtonClick);
			this.cavalryMinusButton.addEventListener(MouseEvent.CLICK,cavalryMinusButtonClick);
			this.cavalryText.addEventListener(Event.CHANGE,cavalryTextChangedEvent);
			
			
			
			

		}
		
		public function updateAttributes(town:Town,intentionIn:int):void
		{
			this.minuteMenText.text="0";
			this.officersText.text="0";
			this.sharpshootersText.text="0";
			this.cannonsText.text="0";
			this.agentsText.text="0";
			this.politiciansText.text="0";
			this.cavalryText.text="0";
			this.totalMinuteMenText.text=town.occupierType(SoldierType.MINUTEMAN).toString();
			this.totalOfficersText.text=town.occupierType(SoldierType.OFFICER).toString();
			this.totalSharpshootersText.text=town.occupierType(SoldierType.SHARPSHOOTER).toString();
			this.totalCannonsText.text=town.occupierType(SoldierType.CANNON).toString();
			this.totalAgentsText.text=town.occupierType(SoldierType.AGENT).toString();
			this.totalPoliticiansText.text=town.occupierType(SoldierType.POLITICIAN).toString();
			this.totalCavalryText.text=town.occupierType(SoldierType.CALVARY).toString();
			this.intention=intentionIn;
			
			
		}
		
		//Minutemen events
		public function plusButtonClick(event:MouseEvent):void
		{
			var num:int=int(this.minuteMenText.text)+1;
			if(num>int(totalMinuteMenText.text))
			{
				num=int(totalMinuteMenText.text);
			}
			this.minuteMenText.text=num.toString();
			
		}
		
		public function minusButtonClick(event:MouseEvent):void
		{
			var num:int=int(this.minuteMenText.text)-1;
			if(num<0)
			{
				num=0;
			}
			this.minuteMenText.text=num.toString();
		}
		
		public function textChangedEvent(event:Event):void
		{
			var num:int=int(event.currentTarget.text);
			if(num>int(totalMinuteMenText.text))
			{
				event.currentTarget.text=totalMinuteMenText.text;
			}
			if(num<0)
			{
				event.currentTarget.text=0;
			}
			
		}
		
		public function numMinutemen():int
		{
			return int(minuteMenText.text);
		}
		
		//Events for Officers
		public function officersPlusButtonClick(event:MouseEvent):void
		{
			var num:int=int(this.officersText.text)+1;
			if(num>int(totalOfficersText.text))
			{
				num=int(totalOfficersText.text);
			}
			this.officersText.text=num.toString();
			
		}
		
		public function officersMinusButtonClick(event:MouseEvent):void
		{
			var num:int=int(this.officersText.text)-1;
			if(num<0)
			{
				num=0;
			}
			this.officersText.text=num.toString();
		}
		
		public function officersTextChangedEvent(event:Event):void
		{
			var num:int=int(event.currentTarget.text);
			if(num>int(totalOfficersText.text))
			{
				event.currentTarget.text=totalOfficersText.text;
			}
			if(num<0)
			{
				event.currentTarget.text=0;
			}
			
		}
		
		public function numOfficers():int
		{
			return int(officersText.text);
		}
		
		//Events for Sharpshooters
		public function sharpshootersPlusButtonClick(event:MouseEvent):void
		{
			var num:int=int(this.sharpshootersText.text)+1;
			if(num>int(totalSharpshootersText.text))
			{
				num=int(totalSharpshootersText.text);
			}
			this.sharpshootersText.text=num.toString();
			
		}
		
		public function sharpshootersMinusButtonClick(event:MouseEvent):void
		{
			var num:int=int(this.sharpshootersText.text)-1;
			if(num<0)
			{
				num=0;
			}
			this.sharpshootersText.text=num.toString();
		}
		
		public function sharpshootersTextChangedEvent(event:Event):void
		{
			var num:int=int(event.currentTarget.text);
			if(num>int(totalSharpshootersText.text))
			{
				event.currentTarget.text=totalSharpshootersText.text;
			}
			if(num<0)
			{
				event.currentTarget.text=0;
			}
			
		}
		
		public function numSharpshooters():int
		{
			return int(sharpshootersText.text);
		}
		
		//Events for Cannons
		public function cannonsPlusButtonClick(event:MouseEvent):void
		{
			var num:int=int(this.cannonsText.text)+1;
			if(num>int(totalCannonsText.text))
			{
				num=int(totalCannonsText.text);
			}
			this.cannonsText.text=num.toString();
			
		}
		
		public function cannonsMinusButtonClick(event:MouseEvent):void
		{
			var num:int=int(this.cannonsText.text)-1;
			if(num<0)
			{
				num=0;
			}
			this.cannonsText.text=num.toString();
		}
		
		public function cannonsTextChangedEvent(event:Event):void
		{
			var num:int=int(event.currentTarget.text);
			if(num>int(totalCannonsText.text))
			{
				event.currentTarget.text=totalCannonsText.text;
			}
			if(num<0)
			{
				event.currentTarget.text=0;
			}
			
		}
		
		public function numCannons():int
		{
			return int(cannonsText.text);
		}
		
		//Events for Agents
		public function agentsPlusButtonClick(event:MouseEvent):void
		{
			var num:int=int(this.agentsText.text)+1;
			if(num>int(totalAgentsText.text))
			{
				num=int(totalAgentsText.text);
			}
			this.agentsText.text=num.toString();
			
		}
		
		public function agentsMinusButtonClick(event:MouseEvent):void
		{
			var num:int=int(this.agentsText.text)-1;
			if(num<0)
			{
				num=0;
			}
			this.agentsText.text=num.toString();
		}
		
		public function agentsTextChangedEvent(event:Event):void
		{
			var num:int=int(event.currentTarget.text);
			if(num>int(totalAgentsText.text))
			{
				event.currentTarget.text=totalAgentsText.text;
			}
			if(num<0)
			{
				event.currentTarget.text=0;
			}
			
		}
		
		public function numAgents():int
		{
			return int(agentsText.text);
		}
		
		//Events for Politicians
		public function politiciansPlusButtonClick(event:MouseEvent):void
		{
			var num:int=int(this.politiciansText.text)+1;
			if(num>int(totalPoliticiansText.text))
			{
				num=int(totalPoliticiansText.text);
			}
			this.politiciansText.text=num.toString();
			
		}
		
		public function politiciansMinusButtonClick(event:MouseEvent):void
		{
			var num:int=int(this.politiciansText.text)-1;
			if(num<0)
			{
				num=0;
			}
			this.politiciansText.text=num.toString();
		}
		
		public function politiciansTextChangedEvent(event:Event):void
		{
			var num:int=int(event.currentTarget.text);
			if(num>int(totalPoliticiansText.text))
			{
				event.currentTarget.text=totalPoliticiansText.text;
			}
			if(num<0)
			{
				event.currentTarget.text=0;
			}
			
		}
		
		public function numPoliticians():int
		{
			return int(politiciansText.text);
		}
		
		//Events for Cavalry
		public function cavalryPlusButtonClick(event:MouseEvent):void
		{
			var num:int=int(this.cavalryText.text)+1;
			if(num>int(totalCavalryText.text))
			{
				num=int(totalCavalryText.text);
			}
			this.cavalryText.text=num.toString();
			
		}
		
		public function cavalryMinusButtonClick(event:MouseEvent):void
		{
			var num:int=int(this.cavalryText.text)-1;
			if(num<0)
			{
				num=0;
			}
			this.cavalryText.text=num.toString();
		}
		
		public function cavalryTextChangedEvent(event:Event):void
		{
			var num:int=int(event.currentTarget.text);
			if(num>int(totalCavalryText.text))
			{
				event.currentTarget.text=totalCavalryText.text;
			}
			if(num<0)
			{
				event.currentTarget.text=0;
			}
			
		}
		
		public function numCavalry():int
		{
			return int(cavalryText.text);
		}
		
		
		
		
		
		public function get Intention():int
		{
			return intention;
		}
		
		
		
	}
}