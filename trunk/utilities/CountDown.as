package utilities {
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import classes.City;
	
	/**
	* CountDown class (Utilities)
	* This class will create a count-down timer for using in the game.
	*/
	public class CountDown
	{
		private var time:Timer;					// timer
		private var secondsLeft:Number;	
		private var max_min:int;				// maximum minute value
		private var resultVal:String;			// String format representing min:sec
		
		private var obj_Update:Array;			// Array of objects that need to be updated every second
		
		/**
		* Constructor
		* @param min: minute
		*/
		public function CountDown(min:int)
		{
			time = new Timer(1000, convertMinsToSeconds(min));
			obj_Update = new Array();
			time.addEventListener(TimerEvent.TIMER, initiateCount);
			time.addEventListener(TimerEvent.TIMER, updateObjects);
			max_min = min;
			time.start();
		}
		
		/**
		* Convert minute value to second value
		* @param min: minute
		*/
		private function convertMinsToSeconds(min:int):int
		{
			//return 10;
			return min * 60;
		}
		
		/**
		* initiate count down timer (listener)
		* @param event: Timer event
		*/
		private function initiateCount(event:TimerEvent):void
		{
			if (event.currentTarget.currentCount > convertMinsToSeconds(max_min)-1) 
			{
				secondsLeft = convertMinsToSeconds(max_min);
				time.reset();
				time.start();
			}
			
			secondsLeft =  convertMinsToSeconds(max_min)  - event.currentTarget.currentCount;
		}
		
		/**
		* Run update function inside each objects every second
		* @param event: Timer event
		*/
		private function updateObjects(event:TimerEvent):void
		{
			for (var i:int = 0; i < obj_Update.length; ++i)
			{
				//trace("run " + i);
				obj_Update[i].Update();
			}
		}
		
		/**
		* add object that has Update() function
		*/
		public function addObjectWithUpdate(obj:Object):void
		{
			//trace("Call");
			obj_Update.push((obj));
		}
		
		/**
		* return current count-down min:seconds string format
		*/
		public function get stringCountDown():String
		{
			if (secondsLeft.toString()!="NaN")
			{
				this.resultVal = formatTime(secondsLeft);
			} else {
				this.resultVal = max_min + ":00";
			}

			return this.resultVal;
		}
		
		/**
		* format Time in min:sec format
		* @param seconds: Seconds
		* @return String in min:sec format
		*/
		private function formatTime(seconds:Number):String
		{
			var sMinutes:String="";
			var sSeconds:String="";
			
			if(seconds > 59) 
			{
				sMinutes = String(Math.floor(seconds / 60));
				sSeconds = String(seconds % 60);
			} else {
				sMinutes = "0";
				sSeconds = String(seconds);
			}
					
			// If less than 10 seconds
			if(sSeconds.length == 1) 
			{
				sSeconds = "0" + sSeconds;
			}
			
			return sMinutes + ":" + sSeconds;
		}
		
		/**
		* return maximum minutes in string format
		*/
		public function MAX_MINS_STRING():String
		{
			//return "0:10";
			return max_min + ":00";
		}
		
		/**
		* return min minute in string format
		*/
		public function MIN_MINS_STRING():String
		{
			return "0:01";
		}
		
	}
}