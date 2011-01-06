package classes
{
	import flash.geom.Rectangle;
	public class City
	{
		//The bounds of this City
		private var bounds:Rectangle;
		//The name of this City for key purposes
		private var name:String;
		//The buildings in this City
		private var buildings:LinkedList;
		//The building's ghost that is going to be created
		private var ghost:Building;
		
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
			if(isCollide(buildingIn))
			{
				return false;
			}
			
			addBuilding(buildingIn);
			return true;
			
			
			
		}
		
		public function updateGhostLocation(xIn:int=0,yIn:int=0):void
		{
			if(ghost!=null)
			{
				ghost.changeLocation(xIn,yIn);
			}
		}
		
		/*
		* Updates what the ghost of the building that is to be created is
		*/
		public function updateGhost(buildingIn:Building=null):void
		{
			
			ghost=buildingIn;
			buildings.Add(ghost);
		}
		public function removeGhost():void
		{
			buildings.Remove(ghost);
			ghost=null;
			
		}
		/*
		* Checks building collision against other buildings in the list
		* @param1: buildingIn - The building to check collision against
		* return: True if collide, False otherwise
		*/
		public function isCollide(buildingIn:Building=null):Boolean
		{
			for(var i:int=0;i<buildings.Length;i++)
			{
				if(buildingIn.Bounds.intersects(Building(buildings.Get(0).data).Bounds))
				{
					trace("Collides");
					return true;
				}
			}
			return false;
			

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
			trace("Were trying to remove from the city");
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
		
		public function get Ghost():Building
		{
			return ghost;
		}
		
		
		
		
	}
}