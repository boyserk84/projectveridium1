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
		* request read or fetch data from the server
		*/
		public static function requestRead(raw_msg:String):void
		{
			client.sendRequest(raw_msg);
		}
		
	}
	
	
}