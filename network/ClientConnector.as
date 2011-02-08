package network{
	import classes.*;
	
	/**
	* Static Wrapper Interface: Client Connector
	* This class is intended to be a static wrapper for ConnectGame object in order
	* to use it global in all parts of the game.
	*/
	public class ClientConnector
	{
		public static var client:ConnectGame;
		
		/**
		* Get player's profile
		*/
		public static function getProfile():Player
		{
			return client.profile;
		}
		
		/**
		* Get player's building list with in a city
		*/
		public static function getBuildingList():LinkedList
		{
			return client.profile.getCity().Buildings;
		}
		/**
		* Get player's city's length
		*/
		public static function getBuildingLength():int
		{
			return client.profile.getCity().Buildings.Length;
		}
		/**
		* request write or update data on the server
		*/
		public static function requestWrite(raw_msg:String):void
		{
			client.sendRequest(raw_msg);
		}
		
		/**
		* Request update building information to the server
		*/
		public static function requestWriteAddBuilding():void
		{
			var new_building:Building = getBuildingList().Get(getBuildingLength()-1).data;
			var encode_pack:String = 
				NetCommand.REQUEST_ADD_BUILDING + 
				"x" + getProfile().UserName +
				"x" + new_building.Location.x +
				"x" + new_building.Location.y +
				"x" + new_building.Type +
				"x0" // + (new_building.isBuildingDone()?0:1)
				;
			requestWrite(encode_pack);

			
		}
		
		/**
		* Request Update Profile's resource
		*/
		public static function requestUpdateProfileResources()
		{
			var encode_pack:String = 
				NetCommand.REQUEST_UPDATE_PROFILE + 
				"x" + getProfile().UserName +
				"x" + getProfile().Side +
				"x" + getProfile().Wood +
				"x" + getProfile().WoodCap +
				"x" + getProfile().Iron +
				"x" + getProfile().IronCap +
				"x" + getProfile().Money +
				"x" + getProfile().Food +
				"x" + getProfile().FoodCap +
				"x" + getProfile().Population +
				"x" + getProfile().PopulationCap +
				"x" + getProfile().CityLocation +
				"x" + getProfile().GameId
				;
			requestWrite(encode_pack);
		}
		
		/**
		* Request remove Building from building list
		*/
		public static function requestRemoveBuilding(target:Building):void
		{
			var encode_pack:String =
				NetCommand.REQUEST_REMOVE_BUILDING +
				"x" + getProfile().UserName +
				"x" + target.Location.x +
				"x" + target.Location.y
				;
			requestWrite(encode_pack);
		}
		
		/**
		* request read or fetch data from the server
		*/
		public static function requestRead(raw_msg:String):void
		{
			client.sendRequest(raw_msg);
		}
		
	}
	
	
}