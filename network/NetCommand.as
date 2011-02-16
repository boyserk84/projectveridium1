package network{
	
	import classes.*;
	import flash.geom.Rectangle;
	/*
	* Network Command Protocol
	* Customized protocol used for communicating game logic with server and clients.
	*
	* RESPONSE (SERVER-RESPONSE)
	* 
	* I= Identification of Client (15 digits)
	* C= Command
	* P= Package details (vary based on information)
	* x= Divider
	*    Destination     Command
	* IIIIIIIIIIIIIII x   CCCC    x
	*
	* REQUEST( CLIENT'S REQUEST)
	* C= Command
	* I= Identification of Client (15 digits)
	* x= Divider
	* Command      Destination
	* CCCC     x  IIIIIIIIIIIIIII x
	*
	*/
	public class NetCommand
	{
		/* Server's response to client */
		public static var RESPONSE_MSG:int = 1000;
		
		public static var RESPONSE_PROFILE:int = 1111;
		
		public static var RESPONSE_BUILDING:int = 1002;
		public static var RESPONSE_TOWN:int = 1003;
		public static var RESPONSE_REGIMENT:int = 1004;
		public static var RESPONSE_BATTLE:int = 1005;
		
		/* Client requests to server */
		public static var REQUEST_PING:int = 1999;
		public static var REQUEST_PROFILE:int = 2000;
		
		public static var REQUEST_CITY:int = 2001;
		public static var REQUEST_UPDATE_PROFILE:int = 2002;
		public static var REQUEST_ADD_BUILDING:int = 2003;
		public static var REQUEST_UPDATE_BUILDING:int = 2004;
		public static var REQUEST_REMOVE_BUILDING:int = 2005;
		public static var REQUEST_TOWN:int = 2006;
		public static var REQUEST_UPDATE_TOWN:int = 2007;
		public static var REQUEST_REGIMENT:int = 2008;
		public static var REQUEST_UPDATE_REGIMENT:int = 2009;
		public static var REQUEST_CREATE_REGIMENT:int = 2010;
		public static var REQUEST_REMOVE_REGIMENT:int = 2011;
		
		public static var REQUEST_CREATE_ACTION:int = 3000;
	
		/* ACTION EVENT from server */
		public static var ACTION_ATTACK:int = 1;
		public static var ACTION_REINFORCE:int = 2;
		public static var ACTION_WORKER:int = 3;
		public static var ACTION_SPY:int = 4;
		public static var ACTION_POLITICIAN:int = 5;
		public static var ACTION_SCOUT:int = 6;
		
		/* Error Message to notify client */
		public static var MSG_HEAD_FAIL:String = "Offline Gameplay!";
		public static var MSG_BODY_FAIL:String = "You are currently in the offline gameplay mode. Nothing will be saved during this session.";
		public static var MSG_HEAD_CLOSED:String = "Connection closed!";
		public static var MSG_BODY_CLOSED:String = "Our server has encountered a problem. Please restart (F5) the application. Otherwise, you will be playing in the offline mode and nothing will be saved!";
		
		/* Decode Package */
		private static var decode_pack:Array;		// Decode package data upon receive
		
		/* ONLY FOR DECODING RESPONSE FROM SERVER */
		private static var COMMAND_INDEX:int = 1;
		private static var ID_INDEX:int = 0;
		
		//private static var CITY_BUILDING_LENGTH:int = 0;
		
		/*
		* Parse and decode package data upon receive
		* @param raw_data: Data in format mentioned above.
		*/
		public static function parseData(raw_data:String):void
		{
			decode_pack = raw_data.split("x");
		}
		
		/**
		* Check if data inside the package is empty
		*/
		public static function isEmptyData():Boolean
		{
			if (decode_pack[2]=='NULL')
			{
				return true;
			}
			return false;
		}
		
		/**
		* Flush data
		*/
		public static function freeData():void
		{
			decode_pack = null;
		}
		
		public static function showChunkData():void
		{
			for (var i:int = 0; i < decode_pack.length; ++i)
			{
				trace(decode_pack[i]);
			}
		}
		
		/**
		* get building object upon received from the server
		* @return Building object
		*/
		public static function getBuildingObject():Building
		{
			if (isNotEmptyPackage() && !isEmptyData())
			{
				var new_building:Building = new Building(new Rectangle(decode_pack[2],decode_pack[3],1,1),decode_pack[4]);
				//trace("Networking Building Type add in " + decode_pack[4]);
				if (decode_pack[5].toString()=="1")
				{
					new_building.setConstruction();
				} else {
					new_building.setDone();
				}
				//CITY_BUILDING_LENGTH = decode_pack[7];
				return new_building;
			}
			return null;
		}
		
/*		public static function getBuildingLength():int
		{
			return CITY_BUILDING_LENGTH;
		}*/
		
		/**
		* Checking if a pakcage is not empty
		* @return True if a package is full
		*/
		private static function isNotEmptyPackage():Boolean
		{
			return (decode_pack!=null || decode_pack.length!=0 || decode_pack[0]!="");
		}
		
		/**
		* get Player object upon received responses from server
		*/
		public static function getPlayerObject():Player
		{
			if (isNotEmptyPackage() && !isEmptyData())
			{
				var new_Player:Player = new Player("No Name",getId());
				new_Player.Side = int(decode_pack[2]);
				new_Player.Wood = int(decode_pack[3]);
				new_Player.WoodCap = int( decode_pack[4]);
				new_Player.Iron = int(decode_pack[5]);
				new_Player.IronCap = int(decode_pack[6]);
				new_Player.Money = int(decode_pack[7]);
				new_Player.Food = int(decode_pack[8]);
				new_Player.FoodCap = int(decode_pack[9]);
				new_Player.Population = int(decode_pack[10]);
				new_Player.PopulationCap = int(decode_pack[11]);
				new_Player.CityLocation = int(decode_pack[12]);
				new_Player.GameId = (decode_pack[13]);
				new_Player.ElapsedTime = (decode_pack[14]);
				new_Player.EventCount = (int)(decode_pack[15]);
				
				trace("======THE ELAPSED TIME! " + new_Player.ElapsedTime);
				
				//trace("Pack " + new_Player.Wood);
				return new_Player;
			}
			return null;
		}
		
		/**
		* get TownInfoNode object upon received responses from server
		* @return TownInfoNode
		*/
		public static function getTownInfoNode():TownInfoNode
		{
			if (isNotEmptyPackage() && !isEmptyData())
			{
				//trace("Receive Town Id: " + decode_pack[2] + " owned by " + decode_pack[5]);
				var node:TownInfoNode = new TownInfoNode
					(decode_pack[5], decode_pack[3], decode_pack[4], decode_pack[2] ,decode_pack[6]);
				node.TotalTowns = decode_pack[7];
				return node;
			}
			return null;
		}
		
		/**
		* get RegimentInfoNode object upon receive reponses from server
		* @return RegimentInfoNode
		*/
		public static function getRegimentInfoNode():RegimentInfoNode
		{
			if (isNotEmptyPackage() && !isEmptyData())
			{
				var reg:RegimentInfoNode = new RegimentInfoNode
				(decode_pack[2], decode_pack[6], decode_pack[3], decode_pack[4],decode_pack[5]);
				//trace("decode_pack 4 : " + decode_pack[4]);
				reg.Minute = int(decode_pack[7]);
				reg.Sharp = int(decode_pack[8]);
				reg.Officer = int(decode_pack[9]);
				reg.Cal = int(decode_pack[10]);
				reg.Cannon = int(decode_pack[11]);
				reg.Scout = int(decode_pack[12]);
				reg.Agent = int(decode_pack[13]);
				reg.Politician = int(decode_pack[14]);
				reg.Worker = int(decode_pack[15]);
				reg.Side = int(decode_pack[16]);
				reg.TotalRegiments = int(decode_pack[17]);
				return reg;
			}
			return null;
		}
		
		/**
		* getBattle result upon receive response from server
		*/
		public static function getEventResult():Boolean
		{
			if (isNotEmptyPackage() && !isEmptyData())
			{
				if (int(decode_pack[5])==1)
				{
					return true;
				}
				else { return false; }
			} else return false;
		}
		
		/**
		* Return Event-Action Type
		*/
		public static function getActionType():int
		{
			if (isNotEmptyPackage() && !isEmptyData())
			{
				return int(decode_pack[4]);
			}
			else { return -1; }
		}
		
		/**
		* Return Event-Action destination town
		*/
		public static function getDestinationTown():int
		{
			if (isNotEmptyPackage() && !isEmptyData())
			{
				return int(decode_pack[3]);
			}
			else { return -1; }
		}
		
		/**
		* Checking if Action Event result has the same game Id
		* @param: profile_gameid: Game's Id
		*/
		public static function isEventGameIdSame(profile_gameid:String):Boolean
		{
			if (isNotEmptyPackage() && !isEmptyData())
			{
				if (decode_pack[6]==profile_gameid)
				{
					return true;
				} else return false;
			} else { return false; }
		}
		
		/**
		* Get Facebook Id upon receive
		*/
		public static function getId():String
		{
			return decode_pack[ID_INDEX];
		}
		
		/**
		* Get Command upon receive
		*/
		public static function getCommand():String
		{
			return decode_pack[COMMAND_INDEX];
		}
	}
	
	
}