package network{
	import flash.events.*;
	import flash.net.XMLSocket;
	
	/**
	* Network interface for connecting to game server (Socket)
	*
	*/
	public class ConnectGame
	{
		
		private var CONFIG:NetConst;			// Network information/config
		private var mySocket:XMLSocket;			// Network Socket
		
		/**
		* Constructor
		* (Automatic connect to the server)
		*/
		public function ConnectGame(config:NetConst)
		{
			CONFIG = config;
			mySocket = new XMLSocket();
			
			
			mySocket.addEventListener(Event.CONNECT, openConnect);
			mySocket.addEventListener(Event.CLOSE, endSocket);
			mySocket.addEventListener(IOErrorEvent.IO_ERROR, errorReport);
			mySocket.addEventListener(DataEvent.DATA,receiveResponse);
			
			// CONFIG did not get called first???
			mySocket.connect(CONFIG.getHost(), CONFIG.getPort());
			
		}
		
		
		/**
		* Notification function: Connection established
		*/
		private function openConnect(event:Event):void
		{
			trace("Open connection:".concat(event));
			
		}
		
		/*
		* Notification function: Connection terminated
		*/
		private function endSocket(event:Event):void
		{
			trace("Close");
		}
		
		/**
		* Error report if unable to connect
		*/
		private function errorReport(event:Event):void
		{
			trace("Unable to connect".concat(event));
			//mySocket.connect(CONFIG.getHost(), CONFIG.getPort());
		}
		
		/**
		* Receive a server's response
		* @param event: Data Event received from server
		*/
		private function receiveResponse(event:DataEvent)
		{
			// Need to process data
			trace("Receive".concat(event.data));
			NetCommand.parseData(event.data);
		}
		
		/**
		* Send a request to server
		* @param: raw_data: Raw data
		*/
		public function sendRequest(raw_data:String)
		{
			trace("Send Data");
			mySocket.send(raw_data);
		}
	}
}