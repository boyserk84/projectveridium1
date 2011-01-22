package constant{
	
	//A node to represent the requirements of a specific building
	public class BuildingInfoNode
	{
		private var wood:int;
		private var iron:int;
		private var money:int;
		private var population:int;
		private var requirement:int;
		private var main_type:String;
		private var time_sec_build;
		
		public function BuildingInfoNode(woodIn:int=0,ironIn:int=0,populationIn:int=0,moneyIn:int=0,requirementIn:int=0,maintypeIn:String="",timeIn:int=0)
		{
			wood=woodIn;
			iron=ironIn;
			money=moneyIn;
			population=populationIn;
			requirement=requirementIn;
			main_type = maintypeIn;
			time_sec_build = timeIn;
		}
		
		public function get Wood():int
		{
			return wood;
		}
		
		public function get Iron():int
		{
			return iron;
		}
		
		public function get Money():int
		{
			return money;
		}
		
		public function get Population():int
		{
			return population;
		}
		
		public function get Requirement()
		{
			return requirement;
		}
		
		public function get Type():String
		{
			return main_type;
		}
		
		public function get Time():int
		{
			return time_sec_build;
		}
		
		
	}
}