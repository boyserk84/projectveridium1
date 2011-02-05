package classes
{
	import flash.geom.Rectangle;
	import constant.BuildingType;
	public class City
	{
		//The bounds of this City
		private var bounds:Rectangle;
		
		//The buildings currently in this city
		private var buildings:LinkedList;
		
		//The buildings this city has for requirement issues
		private var requirements:Array;
		private var temp_req:Array;
		
		private const numberOfTypes:int=BuildingType.TOTAL_BUILD_TYPE;
		
		/*
		* Constructor creates a new city with a specified bounds
		* @param1: bounds - bounds of the rectangle by location and height and width
		*/
		public function City(xIn:int=0,yIn:int=0,widthIn:int=0,heightIn:int=0)
		{
			bounds=new Rectangle(xIn,yIn,widthIn,heightIn);
			buildings=new LinkedList();
			requirements=new Array(numberOfTypes);
			temp_req = new Array(numberOfTypes);
			
			for(var i:int=0;i<=numberOfTypes;++i)
			{
				requirements[i]=0;
			}
			constructMainBuilding();
		}
		
		/**
		* Construct main building (using after default constructor is called)
		*/
		public function constructMainBuilding()
		{
			buildings.Add(new Building(new Rectangle(1,0,1,1),BuildingType.TOWN_SQUARE));
			requirements[BuildingType.TOWN_SQUARE] = buildings.Get(0).data.releaseBuildingToCity();
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
			//requirements[buildingIn.Type]=++requirements[buildingIn.Type];
			if (buildingIn.Type==BuildingType.TOWN_SQUARE)
			{
				requirements[buildingIn.Type] = ++requirements[buildingIn.Type]
			} else {
				temp_req[buildingIn.Type]=++temp_req[buildingIn.Type];
			}
			buildings.Add(buildingIn);
			trace("Length of Buildings:" + buildings.Length);
		}
		
		/*
		* Removes a specific building from the building list
		* @param1: buildingIn - the building to be removed
		*/
		public function removeBuilding(buildingIn:Building=null):void
		{
			trace(requirements[buildingIn.Type] + "Before");
			requirements[buildingIn.Type] = --requirements[buildingIn.Type];
			trace(requirements[buildingIn.Type] + "left");
			buildings.Remove(buildingIn);
		}
		
		/*
		* Calls all of the buildings updates so they will update themselves
		*/
		public function Update():void
		{
			// for each building in the linked list
			for(var i:int=0;i<buildings.Length;i++)
			{
				//trace("Itration " + i);
				buildings.Get(i).data.Update();	// decrement time to build
				
				// if done, update the requirement list
				if (buildings.Get(i).data.isBuildingDone())
				{
					var index:int = buildings.Get(i).data.Type;
					// set flag to building and add to requirement list
					requirements[index]+=buildings.Get(i).data.releaseBuildingToCity();
				}
			}//for
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
		
		/**
		* Does city have more than one town square?
		* @return True if the city has more than one town square
		*/
		public function hasMoreTownSquare():Boolean
		{
			trace("Town Square left" + requirements[BuildingType.TOWN_SQUARE]);
			if (requirements[BuildingType.TOWN_SQUARE] > 1) return true;
			else return false;
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
		
		/*
		* return amount of population produced in this city
		*/
		public function get Pop():int
		{
			return BuildingType.POP_PRODUCT;
		}
		
		/*
		* return amount of irons can be produced in this city
		*/
		public function get Iron():int
		{
			return requirements[BuildingType.BLACKSMITH] * BuildingType.IRON_PRODUCT;
		}
		
		public function get Wood():int
		{
			return requirements[BuildingType.SAWMILL] * BuildingType.WOOD_PRODUCT;
		}
		
		public function get Food():int
		{
			return requirements[BuildingType.FARM] * BuildingType.FOOD_PRODUCT;
		}
		
		/**
		* Increase storage value
		*/
		public function get ExtraStorage():int
		{
			return requirements[BuildingType.WAREHOUSE] * BuildingType.EXTRA_STORAGE;
		}
		
		/*
		* Increase maximum capacity of population
		*/
		public function get ExtraPop():int
		{
			return requirements[BuildingType.HOUSE] * BuildingType.EXTRA_POP_STORAGE;
		}
		
	}
}