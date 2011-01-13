package classes
{
	import flash.geom.Rectangle;
	public class City
	{
		//The bounds of this City
		private var bounds:Rectangle;
		
		//The buildings currently in this city
		private var buildings:LinkedList;
		
		//The buildings this city has for requirement issues
		private var requirements:Array;
		
		private const numberOfTypes:int=22;
		
		/*
		* Constructor creates a new city with a specified bounds
		* @param1: bounds - bounds of the rectangle by location and height and width
		*/
		public function City(xIn:int=0,yIn:int=0,widthIn:int=0,heightIn:int=0)
		{
			bounds=new Rectangle(xIn,yIn,widthIn,heightIn);
			buildings=new LinkedList();
			requirements=new Array(numberOfTypes);
			for(var i:int=0;i<=numberOfTypes;++i)
			{
				requirements[i]=0;
			}
		}
		
		/*
		* Attempts to construct a new building in this city, checks bounds and collision against other buildings
		* @param1: buildingIn - The building to construct
		* @return: True if the building can be made, False otherwise
		*/
		public function constructBuilding(buildingIn:Building=null):Boolean
		{
			// DUMMY VALUE
			return true;
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
			// DUMMY VALUE
			return true;

		}
		/*
		* Add a building to the building list
		* @param1: buildingIn - the building to be added to the list
		*/
		public function addBuilding(buildingIn:Building=null):void
		{
			requirements[buildingIn.Type]=1;
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
		
		/**
		* Checks if a (x,y) coordinate pair is within the bounds of this city
		* @param1: The x-coordinate to be checked
		* @param2: The y-coordinate to be checked
		**/
		public function isValid(xIn:int=-1,yIn:int=-1):Boolean
		{
			return ((xIn>-1 && yIn>-1)&&(xIn<this.bounds.width && yIn<this.bounds.height));
		}
		
		/*
		* Returns the list of buildings
		*/
		public function get Buildings():LinkedList
		{
			return buildings;
		}
		
		/*
		* Returns the bounds of this city's rectangle
		*/
		public function get Bounds():Rectangle
		{
			return bounds;
		}
		
		/*
		* Returns the requirements array of this city
		*/
		public function get Requirements():Array
		{
			return requirements;
		}
		
		
		
		
	}
}