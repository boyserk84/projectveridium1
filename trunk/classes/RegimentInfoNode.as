package classes {
	
	public class RegimentInfoNode
	{
		
		private var regiment_id:int;
		private var owner_id:String;
		private var town_id:String;
		private var des_town_id:String;
		private var intransit:Boolean;
		
		private var n_minute:int, n_officer:int, n_cal:int, n_cannon:int;
		private var n_sharp:int, n_scout:int, n_agent:int, n_pol:int, n_work:int;
		
		
		/**
		*
		*/
		public function RegimentInfoNode(reg_id:int, owner:String, town:String, des_town:String, in_transit:int)
		{
			regiment_id = reg_id;
			owner_id = owner;
			town_id = town;
			des_town_id = des_town;
			if (in_transit == 1) intransit = true;
			else in_transit = false;
		}
		
	}
	
	
}