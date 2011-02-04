package network{
	
	/**
	* Static Wrapper Interface: Client Connector
	* This class is intended to be a static wrapper for ConnectGame object in order
	* to use it global in all parts of the game.
	*/
	public class ClientConnector
	{
		public static var client:ConnectGame;
		
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