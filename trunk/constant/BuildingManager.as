package constant {

	import classes.*;
	
	/**
	* Building Manager
	* This class object will determine what buildings can be built on the city.
	* 
	*/
	public class BuildingManager 
	{
	
		/**
		* Determine building list available based on city
		* @param City: City object
		* @return List of buildings that can be built
		*/
		public static function determineBuildingList(city:City):Array
		{
			var building_list:Array = city.Requirements;			// List of buildings that has been built
			var node:BuildingInfoNode = null;
			var available_list:Array = new Array();
			
			
			// for each type of building
			for (var i = 0; i < building_list.length; ++i)
			{	
				// Gather requirement from each type of building
				node = BuildingInfo.getInfo(building_list[i]);
				
				// Check if a building fullfils requirement
				if (building_list[node.Requirement]==1)
				{
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
		public static function canBeBuilt(buildingType:int)
		{
			// Need to compare with resources
		}
		
	
	}



}