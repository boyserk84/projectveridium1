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
		
		/** Game Objects **/
		public var profile:Player;				// Player's profile object
		public var townPlayer:Array;			// Array of townInfoNode
		public var regimentPlayer:Array;		// Array of RegimentInfoNode
		
		/** Network data receiver flags **/
		private var profilePackageArrive:Boolean = false;
		private var townPackageArrive:Boolean = false;
		private var cityPackageArrive:Boolean = false;
		private var regimentPackageArrive:Boolean = false;
		private var eventActionArrive:Boolean = false;
		
		/** Server's reponse string message **/
		private var messageReceived:String;
		private var messageHeader:String;
		
		
		/** Networking Connection flags **/
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
		* Binding array that holds townInfoNode info to this socket connection
		* @param town_array: List of town
		*/
		public function bindPlayerTown(town_array:Array):void
		{
			this.townPlayer = town_array;
		}
		
		/**
		* Binding array that holds RegimentInfoNode info to this socket connection
		* @param reg_array: List of regiment
		*/
		public function bindPlayerRegiment(reg_array:Array):void
		{
			this.regimentPlayer = reg_array;
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
		public function isActionEventReceived():Boolean { return eventActionArrive; }
		
		/* Confirm that Action event has been received*/
		public function confirmReceiveEvent():void { eventActionArrive = false; }
		
		/** Reset Network Data Flag **/
		public function resetTownsFlag():void { townPackageArrive = false; }
		public function resetRegimentsFlag():void { regimentPackageArrive = false; }
		
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
		
		public function isTownArrived():Boolean
		{
			return townPackageArrive;
		}
		
		public function isCityArrived():Boolean
		{
			//trace("City has " + cityPackageArrive);
			return cityPackageArrive;
		}
		
		public function isRegimentArrived():Boolean
		{
			return regimentPackageArrive;
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
				switch(NetCommand.getCommand())
				{
					// (2.1) Process the package
					
					//(2.1.1) Server Admin Message
					case NetCommand.RESPONSE_MSG.toString():
				
					break;
				
					// (2.1.2) Action Event processed
					case NetCommand.RESPONSE_BATTLE.toString():
					
					//trace("Response Battle");
					// (2.1.2.1) Check gameId and facebook's ID
					if (NetCommand.isEventGameIdSame(profile.GameId));
					{
						//trace("Yes same game");
						// (2.1.2.2) Check Type of Action
						switch (NetCommand.getActionType())
						{
							case NetCommand.ACTION_ATTACK:
								//trace("Attack event received");

								if (NetCommand.getEventResult())
								{
									if (NetCommand.getId() == profile.UserName)
									{
										// Notify Client for winning
										messageReceived = "Your troop has captured the town#" + NetCommand.getDestinationTown() + ". From now on, you will receive resources from this town.";
										messageHeader = "Congratulation ! your troop has captured the town!";
										
									} else {
										messageReceived = "Town#" +NetCommand.getDestinationTown()+ " has been conquered.";
										messageHeader = "Town #" + NetCommand.getDestinationTown() +" has been captured!";
									}
									eventActionArrive = true;
								}
								
							
							break;
							
							case NetCommand.ACTION_REINFORCE:
								if (NetCommand.getId() == profile.UserName)
								{
									if (!NetCommand.getEventResult())
									{
										// Notify client for fail to reinforce
										messageReceived = "Your reinforcement has been ambushed and eliminated by the enemy.";
										messageHeader = "Your reinforcement has been eliminated at town#" + NetCommand.getDestinationTown() + "!";
										eventActionArrive = true;
									}
								}
							break;
							
							case NetCommand.ACTION_WORKER:
								if (NetCommand.getId() == profile.UserName)
								{
									if (!NetCommand.getEventResult())
									{
										// Notify client for fail to send workers
										messageReceived = "Your workers have been ambushed and eliminated by the enemy.";
										messageHeader = "Oh no! Your wokers have been eliminated at town#" + NetCommand.getDestinationTown() + "!";
										eventActionArrive = true;
									}
								}
							break;
							
							case NetCommand.ACTION_SPY:
							
							break
							
							case NetCommand.ACTION_POLITICIAN:
							
							break;
							
							case NetCommand.ACTION_SCOUT:
							
							break;
							
							default:
							
							break;
							
							
						}
						
						// (2.1.2.3) Send Request for Town and Regiment
						sendRequest(NetCommand.REQUEST_TOWN+"x"+profile.UserName+"x"+profile.GameId);
						sendRequest(NetCommand.REQUEST_REGIMENT+"x"+profile.UserName);
						
						
					}
					break;
				}
				
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
							var new_building:Building = NetCommand.getBuildingObject();
							if (new_building != null)
							{
								this.profile.getCity().addImmediateBuilding(new_building);
							
								trace("Receive Building");
							}
							cityPackageArrive = true;
							
							//this.profile.getCity().Buildings.Get(profile.getCity().Buildings.Length-1).data.setComplete();
						break;
						
						// Receive info of all towns from the same gameId
						case NetCommand.RESPONSE_TOWN.toString():
							var new_town:TownInfoNode = NetCommand.getTownInfoNode();
							if (new_town != null)
							{
								// Check if it is the same gameId
								if (new_town.GameId == profile.GameId)
								{
									this.townPlayer.push(new_town);
								
									if (this.townPlayer.length == new_town.TotalTowns)
									{
										townPackageArrive = true;
									}
								}
							} else { regimentPackageArrive = true; }
							
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
							//trace("Receive " + this.profile.Wood);
						break;
						
						// Receive Player's all regiments
						case NetCommand.RESPONSE_REGIMENT.toString():
							var new_reg:RegimentInfoNode = NetCommand.getRegimentInfoNode()
							if (new_reg != null)
							{
								this.regimentPlayer.push(new_reg);
								if (this.regimentPlayer.length == new_reg.TotalRegiments)
								{
									regimentPackageArrive = true;
								}
							} else { regimentPackageArrive = true; }
							
						break;
						
					}
					
					// Notify global document
					//trace("My Package");
				}
			}
			
			// (3) flush data
			NetCommand.freeData();
		}
		
		public function gameMsgHeader():String
		{
			return messageHeader;
		}
		
		public function gameMsg():String
		{
			return messageReceived;
		}
		
		/**
		* Checking if the package received belongs to all clients
		* @return True if the package belongs to all.
		*/
		private function isPackageForAll():Boolean
		{
			switch (NetCommand.getCommand())
			{
				case NetCommand.RESPONSE_MSG.toString():
					return true;
				break;
				
				case NetCommand.RESPONSE_BATTLE.toString():
					return true;
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
			trace("Send Data".concat(raw_data));
			try {
				mySocket.send(raw_data.concat('K'));
			}  catch (e:Error)
			{
				// Log?
			}
		}
	}
}