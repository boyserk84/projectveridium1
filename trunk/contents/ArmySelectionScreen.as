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
		
		
		private var townLocation:Point;
		
		
		public function ArmySelectionScreen()
		{
			this.minuteMenText.text="0";
			this.plusButton.addEventListener(MouseEvent.CLICK,plusButtonClick);
			this.minusButton.addEventListener(MouseEvent.CLICK,minusButtonClick);
			this.minuteMenText.addEventListener(Event.CHANGE,textChangedEvent);
		}
		
		public function updateAttributes(town:Town):void
		{
			this.totalMinuteMenText.text=town.occupierType(SoldierType.MINUTEMAN).toString();
			
			
		}
		
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
		
	}
}