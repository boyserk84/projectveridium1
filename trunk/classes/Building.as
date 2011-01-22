package classes
{ 
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import constant.BuildingInfo;
	import constant.BuildingInfoNode;
	
	public class Building
	{
		//Location of the building
		private var dimension:Rectangle;
		private var type:int;				// Type of building
		private var category:String;			// Category of building
		
		private var time_to_build:int;		// Time to build in seconds
		private var release_req:int = 1;
		
		/**
		* Constructor
		*
		*/
		public function Building(locationIn:Rectangle,typeIn:int=-1)		
		{
			dimension=locationIn;
			type=typeIn;
			time_to_build = BuildingInfo.getInfo(typeIn).Time;
			category = BuildingInfo.getInfo(typeIn).Type;
			//trace("Time " + time_to_build);
		}
		
		/*
		* Change the internal location of this building
		* @param1: xIn - The x-Coordinate to change to
		* @param2: yIn - The y-Coordinate to change to
		*/
		public function changeLocation(xIn:int,yIn:int):void
		{
			dimension.x=xIn;
			dimension.y=yIn;
		}
		
		/*
		* Perform updates that need to be done, I don't know what those are
		*/
		public function Update()
		{
			inProgress();
		}
		
		public function get Type():int
		{
			return type;
		}
		
		public function get Location():Point
		{
			var point:Point=new Point(dimension.x,dimension.y);
			return point;
		}
		
		public function get Dimension():Point
		{
			return new Point(dimension.width, dimension.height);
		}
		
		/**
		* isSingleDim
		* Checking if the building is only occupying one unit
		*/
		public function isSingleDim():Boolean
		{
			if (dimension.width > 1 || dimension.height > 1)
			{
				return false;
			} else return true;
		}
		
		/**
		* decrement time to build
		*/
		public function inProgress():void
		{
			if (time_to_build > 0)
			{
				--time_to_build;
			}
		}
		
		/**
		* remaining time in seconds
		*/
		public function currentProgress():int
		{
			return time_to_build;
		}
	
		/**
		* Is building finished?
		* @return True if complete, Otherwise, False is returned
		*/ 
		public function isBuildingDone():Boolean
		{
			return (time_to_build==0)?true:false;
		}
		
		/*
		* Flag set for building to be complete done (use with Timer)
		* @return return 1 and set release_req to 0
		*/
		public function releaseBuildingToCity():int
		{
			var temp:int = release_req;
			release_req = 0;
			return temp;
		}
	}
}