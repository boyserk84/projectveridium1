package constant {

	import classes.*;
	
	/**
	* Building Manager
	* This class object will determine what buildings can be built on the city.
	* 
	*/
	public class BuildingManager 
	{
		private static var building_list:Array; 		// List of buildings that has been built
		private static var available_list:Array = new Array();		// List of building that can be built
		
		/**
		* Determine building list available based on city
		* @param City: City object
		* @return List of buildings that can be built
		*/
		public static function determineBuildingList(city:City):Array
		{
			building_list = city.Requirements;		
			
			var node:BuildingInfoNode = null;
			
			// for each type of building
			for (var i = 0; i < building_list.length; ++i)
			{	
				// Gather requirement from each type of building
				node = BuildingInfo.getInfo(i);
				
				//trace("Req " + node.Requirement);
				
				// Check if a building fullfils requirement
				if (building_list[node.Requirement])
				{
					//trace("met Requirement");
					available_list[i] = true;
				} else {
					available_list[i] = false;
				}
			}//for
			
			return available_list;
		}
		
		/**
		* Determine if a particular building can be built basd on resources.
		* @param buildingType Building type
		* @return True if the specific building can be built. Otherwise, False is returned.
		*/
		public static function hasResourceToBuild(buildingType:int, wood:int, iron:int, money:int, pop:int)
		{
			//trace("Has resource of type : " + buildingType);
			var node:BuildingInfoNode = BuildingInfo.getInfo(buildingType);
			if (node.Wood <= wood && node.Iron <= iron && node.Money <= money && node.Population <= pop)
			{
				//trace("Enough");
				return true;
			}
			//trace("Return damn it");
			return false;
		}
		
	
	}



}