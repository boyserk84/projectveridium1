package classes
{
	/**
	* TownInfoNode
	*/
	public class TownInfoNode
	{
		private var ownerId:String;				// Facebook's Id
		private var regimentId:int;			// Regiment's Id that occupies this town
		private var side:int;				// Town's side
		//private var regiment:Regiment;			// Regiment that occupies this town
		
		private var gameId:String;				// Game ID
		private var townId:int;					// Town Id
		
		/**
		* Constructor
		* @param ownerIdIn : Owner Id of this town
		* @param regIn: current regiment that occupies this town
		*/
		public function TownInfoNode(ownerIdIn:String="",regIn:int=-1, gameIn:String="", townIn:int=-1,sideIn:int=-1)
		{
			ownerId=ownerIdIn;
			regimentId=regIn;
			gameId = gameIn;
			townId = townIn;
			side = sideIn;
		}
		
		public function get OwnerId():String { return ownerId; }
		public function get RegimentId():int { return regimentId; }
		//public function get Reg():Regiment { return regiment; }
		public function get GameId():String { return gameId; }
		public function get TownId():int { return townId; }
		public function get Side():int { return side; }
	}
	
}