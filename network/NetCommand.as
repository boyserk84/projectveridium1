package network{
	
	/*
	* Network Command Protocol
	* Customized protocol used for communicating game logic with server and clients.
	*
	* C= Command
	* I= Identification of Client (15 digits)
	* P= Package details (vary based on information)
	* x= Divider
	* CCCCxIIIIIIIIIIIIIIIxP...
	*/
	public class NetCommand
	{
		/* Server's response to client */
		public static var RESPONSE_MSG:int = 1000;
		
		/* Client requests to server */
		public static var REQUEST_PROFILE:int = 2000;
		
		/*
		* Parse and decode package data
		* @param raw_data: Data in format mentioned above.
		*/
		public static function parseData(raw_data:String)
		{
			trace("Parse Data");
		}
	}
	
	
}