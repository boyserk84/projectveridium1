package utilities{
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
			this.popInfo.text = profile.Population.toString();
			this.woodInfo.text = profile.Wood.toString();
			this.moneyInfo.text = profile.Money.toString();
			this.ironInfo.text = profile.Iron.toString();
			this.foodInfo.text = profile.Food.toString();
		}
	}
}
	