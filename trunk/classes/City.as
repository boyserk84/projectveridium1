package classes
{
	import flash.geom.Rectangle;
	public class City
	{
		//The bounds of this City
		private var bounds:Rectangle;
		
		private var buildings:LinkedList;
		
		/*
		* Constructor creates a new city with a specified bounds
		* @param1: bounds - bounds of the rectangle by location and height and width
		*/
		public function City(xIn:int=0,yIn:int=0,widthIn:int=0,heightIn:int=0)
		{
			bounds=new Rectangle(xIn,yIn,widthIn,heightIn);
			buildings=new LinkedList();
		}
		
		/*
		* Attempts to construct a new building in this city, checks bounds and collision against other buildings
		* @param1: buildingIn - The building to construct
		* @return: True if the building can be made, False otherwise
		*/
		public function constructBuilding(buildingIn:Building=null):Boolean
		{
			
		}
		
		/*
		* Checks building collision against other buildings in the list
		* @param1: buildingIn - The building to check collision against
		* return: True if collide, False otherwise
		*/
		public function isCollide(buildingIn:Building):Boolean
		{
			for(var i:int=0;i<buildings.Length;i++)
			{

		}
		/*
		* Add a building to the building list
		* @param1: buildingIn - the building to be added to the list
		*/
		public function addBuilding(buildingIn:Building=null):void
		{
			
			buildings.Add(buildingIn);
			trace("Length of Buildings:" + buildings.Length);
		}
		
		/*
		* Removes a specific building from the building list
		* @param1: buildingIn - the building to be removed
		*/
		public function removeBuilding(buildingIn:Building=null):void
		{
			buildings.Remove(buildingIn);
		}
		
		/*
		* Calls all of the buildings updates so they will update themselves
		*/
		public function Update():void
		{
			for(var i:int=0;i<buildings.Length;i++)
			{
				buildings[i].Update();
			}
		}
		
		/*
		* Returns the list of buildings
		*/
		public function get Buildings():LinkedList
		{
			return buildings;
		}
		
		
		
		
	}
}