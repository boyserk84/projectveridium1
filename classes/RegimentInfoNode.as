package classes {
	
	/**
	* RegimentInfoNode
	* This class will act as a data object, which is intended to be use for receiving
	* and parsing data from the server.
	*/
	public class RegimentInfoNode
	{
		
		private var regiment_id:int;
		private var owner_id:String;
		private var town_id:String;
		private var des_town_id:String;
		private var intransit:Boolean;
		private var side:int;
		
		private var total_reg:int;
		
		private var n_minute:int, n_officer:int, n_cal:int, n_cannon:int;
		private var n_sharp:int, n_scout:int, n_agent:int, n_pol:int, n_worker:int;
		
		
		/**
		* Constructor
		* @param: reg_id: Regiment identitfication
		* @param: owner: Owner of this regiment
		* @param: town: Current Town or source town
		* @param: des_town: Destination Town
		* @param: in_transit: Is this regiment currently moving?
		*/
		public function RegimentInfoNode(reg_id:int, owner:String, town:String, des_town:String, in_transit:int)
		{
			regiment_id = reg_id;
			owner_id = owner;
			town_id = town;
			des_town_id = des_town;
			if (in_transit == 1) intransit = true;
			else intransit = false;
		}
		
		public function set Minute(value:int):void { n_minute= value; }
		public function set Officer(value:int):void { n_officer = value; }
		public function set Cal(value:int):void { n_cal = value; }
		public function set Cannon(value:int):void { n_cannon = value; }
		public function set Sharp(value:int):void { n_sharp = value; }
		public function set Scout(value:int):void { n_scout = value; }
		public function set Agent(value:int):void { n_agent = value; }
		public function set Politician(value:int):void { n_pol = value; }
		public function set Worker(value:int):void { n_worker = value; }
		public function set Side(value:int):void { side = value; }
		public function set TotalRegiments(value:int):void { total_reg = value; }
		
		public function get Id():int { return regiment_id; }
		public function get OwnerId():String { return owner_id;}
		public function get TownId():String { return town_id; }
		public function get DestinationId():String { return des_town_id; } 
		public function get inTransit():Boolean { return intransit; } 
		public function get Minute():int { return n_minute; }
		public function get Officer():int { return n_officer; }
		public function get Cal():int { return n_cal; }
		public function get Cannon():int { return n_cannon; }
		public function get Sharp():int { return n_sharp; }
		public function get Scout():int { return n_scout; }
		public function get Agent():int { return n_agent; }
		public function get Politician():int { return n_pol; }
		public function get Worker():int { return n_worker; }
		public function get Side():int { return side; }
		public function get TotalRegiments():int { return total_reg; } 
		
		
	}
	
	
}