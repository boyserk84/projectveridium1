package utilities {
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import classes.City;
	
	/**
	* CountDown class (Utilities)
	* This class will create a count-down timer for using in the game
	* as well as update function that needs to be executed periodically (every sec).
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
		* Run update function that needs to be executed periodically (ever sec)
		* inside each objects every second
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
		* add object that has Update() function to be executed every second.
		* @param obj: Generic object that has update function.	
		*/
		public function addObjectWithUpdate(obj:Object):void
		{
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
			return formatTimeFromNumber(seconds);
		}
		
		/**
		* Static function Convert seconds to Time format Min:Sec in String
		* @param seconds: Seconds
		* @return String of time in format Min:Sec
		*/
		public static function formatTimeFromNumber(seconds:Number):String
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
		
		public function triggerEveryNSeconds(n_sec:Number):Boolean
		{
			if (secondsLeft%n_sec == 0)
			return true;
			else
			return false;
		}
		
	}
}