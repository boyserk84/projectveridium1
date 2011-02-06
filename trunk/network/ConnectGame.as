package network{
	import flash.events.*;
	import flash.net.XMLSocket;
	import flash.system.Security;
	
	import classes.*;
	
	/**
	* Network interface for connecting to game server (Socket)
	* and process data upon receive.
	*
	*/
	public class ConnectGame
	{
		
		private var CONFIG:NetConst;			// Network information/config
		private var mySocket:XMLSocket;			// Network Socket
		
		private var id:String;					// Identitiy of client
		
		public var profile:Player;
		
		private var profilePackageArrive:Boolean = false;
		
		private var alreadyConnect:Boolean = false;
		private var failedConnect:Boolean = false;
		private var closedConnect:Boolean = false;
		
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
		}
		
		public function connectNow():void
		{
			try {
				mySocket.connect(CONFIG.getHost(), CONFIG.getPort());
			} catch (e:Error)
			{
				failedConnect = true;
			}

		}
		
		/**
		* Binding player object to this socket connection for data exchange
		* @param: profile: Player Object
		*/
		public function bindPlayer(profile:Player):void
		{
			this.profile = profile;
		}
		
		/**
		* Binding Id to this socket connection
		* @param Id: Facebook's Id
		*/
		public function bindId(id:String):void
		{
			this.id = id;
		}
		
		
		/**
		* Notification function: Connection established
		*/
		private function openConnect(event:Event):void
		{
			trace("Open connection:".concat(event));
			//Security.allowDomain("http://" + CONFIG.getHost() +"/");
			//xmlsocket://
			//Security.loadPolicyFile("http://"+ CONFIG.getHost() + "/crossdomain.xml");
			alreadyConnect = true;
			
		}
		
		public function isAlreadyConnect():Boolean { return alreadyConnect; }
		public function isConnectFailed():Boolean { return failedConnect; }
		public function isConnectionClosed():Boolean { return closedConnect;}
		
		/*
		* Notification function: Connection terminated
		*/
		private function endSocket(event:Event):void
		{
			trace("Close");
			closedConnect = true;
		}
		
		/**
		* Error report if unable to connect
		*/
		private function errorReport(event:Event):void
		{
			trace("Unable to connect".concat(event));
			failedConnect = true;
			closedConnect= true;
			//mySocket.connect(CONFIG.getHost(), CONFIG.getPort());
		}
		
		public function isDataArrived():Boolean
		{
			return profilePackageArrive;
		}
		
		/**
		* Receive a server's response
		* @param event: Data Event received from server
		*/
		private function receiveResponse(event:DataEvent)
		{
			trace("Receive data" + event.data);
			// (1) Parse/dissect data upon receive
			NetCommand.parseData(event.data);
			
			// (2) Check if package is for all
			if (isPackageForAll())
			{
				// (2.1) Process the package
				
			} else {
			
				// (2.2) Check if package belongs to this client
				if (isMyPackage())
				{
					trace("This is my package received");
					// Process the package base command
					switch (NetCommand.getCommand())
					{
						// Receive Building object
						case NetCommand.RESPONSE_BUILDING.toString():	
							this.profile.getCity().addBuilding(NetCommand.getBuildingObject());
							//this.profile.getCity().Buildings.Get(profile.getCity().Buildings.Length-1).data.setComplete();
						break;
						
						case NetCommand.RESPONSE_TOWN.toString():
							//TODO FIND THE WAY TO PASS INFO TO WORLDMAP
						
						break;
						
						// Receive Player's profile object
						// ONLY LOAD THE FIRST TIME
						case NetCommand.RESPONSE_PROFILE.toString():
							trace("Get Player");
							var nameIn:String = this.profile.Name;	// save name
							this.profile = null;
							this.profile = NetCommand.getPlayerObject();
							this.profile.Name = nameIn;
							profilePackageArrive = true;
							trace("Receive " + this.profile.Wood);
						break;
						
					}
					
					// Notify global document
					//trace("My Package");
				}
			}
			
			// (3) flush data
			NetCommand.freeData();
		}
		
		/**
		* Checking if the package received belongs to all clients
		* @return True if the package belongs to all.
		*/
		private function isPackageForAll():Boolean
		{
			switch (NetCommand.getCommand())
			{
				case NetCommand.RESPONSE_MSG:
					return true;
				break;
				// Add more
				
				default:
					return false;
				break;
			}
		}
		
		/**
		* Check if the package is belonged to this player
		* @param: data
		*/
		private function isMyPackage():Boolean
		{
			if (NetCommand.getId()==this.id) return true;
			else return false;
		}
		
		
		/**
		* Send a request to server
		* @param: raw_data: Raw data
		*/
		public function sendRequest(raw_data:String)
		{
			trace("Send Data");
			try {
				mySocket.send(raw_data);
			}  catch (e:Error)
			{
				// Log?
			}
		}
	}
}