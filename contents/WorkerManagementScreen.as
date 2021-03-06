﻿package contents{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import classes.Town;
	
	public class WorkerManagementScreen extends MovieClip
	{
		
		
		
		
		public function WorkerManagementScreen(xIn:int,yIn:int)
		{
			this.workersText.text="0";
			this.x=xIn;
			this.y=yIn;

			this.workersText.addEventListener(Event.CHANGE,textChangedEvent);
		}
		
		public function updateAttributes(town:Town):void
		{
			this.workersText.text="0";
			this.totalWorkersText.text=town.Workers.toString();
			
			
		}
		
		public function numWorkers():int
		{
			return int(workersText.text);
		}
		
		public function textChangedEvent(event:Event):void
		{
			var num:int=int(event.currentTarget.text);
			if(num>int(totalWorkersText.text))
			{
				event.currentTarget.text=totalWorkersText.text;
			}
			if(num<0)
			{
				event.currentTarget.text=0;
			}
			
		}
		
	}
}