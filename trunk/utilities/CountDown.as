package utilities {
	
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	// ISSUES: NEED TO RESET COUNT DOWN ONCE REACH ZERO.
	// ISSUES: NEED TO ELIMINATE NAN IN THE BEGINNING.
	
	/**
	* CountDown class (Utilities)
	* This class will create a count-down timer for using in the game.
	*/
	public class CountDown
	{
		private var time:Timer;
		private var secondsLeft:Number;
		private var max_min:int;
		private var resultVal:String;
		
		/**
		* Constructor
		*/
		public function CountDown(min:int)
		{
			time = new Timer(1000, convertMinsToSeconds(min));
			time.addEventListener(TimerEvent.TIMER, initiateCount);
			max_min = min;
			time.start();
		}
		
		private function convertMinsToSeconds(min:int):int
		{
			return min * 60;
		}
		
		/**
		* initiate count down timer (listener)
		* @param event: Timer event
		*/
		private function initiateCount(event:TimerEvent):void
		{
			secondsLeft =  convertMinsToSeconds(max_min) + 1 - event.currentTarget.currentCount;
		}
		
		/**
		* return current count-down min:seconds string format
		*/
		public function get stringCountDown():String
		{
			var minutes:int;
			var sMinutes:String="";
			var sSeconds:String="";
			
			if(secondsLeft > 59) {
				minutes = Math.floor(secondsLeft / 60);
				sMinutes = String(minutes);
				sSeconds = String(secondsLeft % 60);
			} else {
				sMinutes = "0";
				sSeconds = String(secondsLeft);
			}
				
			// If less than a minute
			if(sSeconds.length == 1) {
				sSeconds = "0" + sSeconds;
			}
			this.resultVal = sMinutes + ":" + sSeconds;

			return this.resultVal;
		}
		
	}
}