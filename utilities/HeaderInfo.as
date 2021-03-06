﻿package utilities{
	import flash.display.MovieClip;
	import classes.Player;
	
	/**
	* HeaderInfo Class
	* This class will update and display a player's profile (resources) to the screen.
	*
	*/
	public class HeaderInfo extends MovieClip
	{
		/**
		* Constructor
		* @param profile: Player's profile
		*/
		public function HeaderInfo(profile:Player)
		{
			this.x = 0;
			this.y = 0;
			updateInfo(profile);
		}
		
		/**
		* Update new information from player's profile
		*/
		public function updateInfo(profile:Player):void
		{
			this.popInfo.text = profile.Population.toString();// + "/" + profile.PopulationCap.toString();
			this.woodInfo.text = profile.Wood.toString();// + "/" + profile.WoodCap.toString();
			this.moneyInfo.text = profile.Money.toString();
			this.ironInfo.text = profile.Iron.toString();// + "/" + profile.IronCap.toString();
			this.foodInfo.text = profile.Food.toString();// + "/" + profile.FoodCap.toString();
		}
		
		public function updateTimerInfo(timer:String):void
		{
			this.timerInfo.text = timer;
		}
	}
}
	