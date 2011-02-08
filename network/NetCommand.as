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
		
		/* Client requests to server */
		public static var REQUEST_PROFILE:int = 2000;
		
		public static var REQUEST_CITY:int = 2001;
		public static var REQUEST_UPDATE_PROFILE:int = 2002;
		public static var REQUEST_ADD_BUILDING:int = 2003;
		public static var REQUEST_UPDATE_BUILDING:int = 2004;
		public static var REQUEST_REMOVE_BUILDING:int = 2005;
		public static var REQUEST_TOWN:int = 2006;
		
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
		/*
		* Parse and decode package data upon receive
		* @param raw_data: Data in format mentioned above.
		*/
		public static function parseData(raw_data:String):void
		{
			decode_pack = raw_data.split("x");
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
			if (isNotEmptyPackage())
			{
				var new_building:Building = new Building(new Rectangle(decode_pack[2],decode_pack[3],1,1),decode_pack[4]);
				if (decode_pack[5].toString()=="1")
				{
					new_building.setConstruction();
				} else {
					new_building.setDone();
				}
				
				return new_building;
			}
			return null;
		}
		
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
			if (isNotEmptyPackage())
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
			if (isNotEmptyPackage())
			{
				//trace("Receive Town Id: " + decode_pack[2] + " owned by " + decode_pack[5]);
				var node:TownInfoNode = new TownInfoNode
					(decode_pack[5], decode_pack[3], decode_pack[4], decode_pack[2]);
				return node;
			}
			return null;
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