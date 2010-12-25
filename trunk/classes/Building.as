package classes
{ 
	import flash.geom.Rectangle;
	import flash.geom.Point;
	public class Building
	{
		//Location of the building
		private var dimension:Rectangle;
		private var type:int;
		

		
		public function Building(locationIn:Rectangle,typeIn:int=-1)		
		{
			dimension=locationIn;
			type=typeIn;
			
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
			//Do building things here
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
		
		
		
	}
}