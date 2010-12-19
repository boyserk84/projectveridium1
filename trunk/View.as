package {
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import classes.*;
	
	/**
	* View class
	*	Management of all graphic and view representation.
	*/
	public class View extends MovieClip
	{
		// get hold of Building objects not only data objects
		private var gameBuildingList:LinkedList;				// Actual building game object
		
		// Internal Structure
		private var gameViewObjects:Vector.<SpriteSheet>;				// All game objects for view
		private var gameViewPanel:Vector.<SpriteSheet>;					// All panel/admin objects in the game
		
		/**
		* View Constructor
		*/
		public function View()
		{
			this.gameViewObjects = new Vector.<SpriteSheet>;
			this.gameViewPanel = new Vector.<SpriteSheet>;
		}
		
		/**
		* Add Vector/List of building objects from the game logic
		* @param LinkedList list of building objects
		*/
		public function addBuildingList(list:LinkedList)
		{
			this.gameBuildingList = list;
			
			trace(list.Length);
			//trace("Jereerere");
			
			for (var i:int=0; i < list.Length; ++i)
			{
				// (1) Extracting info from each building object
				// x,y and type of building
				var temp_building = Building(gameBuildingList.Get(i).data);
				var temp_type:int = (temp_building.Type);
				var temp_x:int = (temp_building.Location.x); 
				var temp_y:int = (temp_building.Location.y);
				
				//trace("(" + temp_x + "," + temp_y + ")");
				// (2) Construct spriteSheet based on type
				this.gameViewObjects.push(new SpriteSheet(temp_type,temp_x, temp_y));
				
			}//for
		}
		
		/**
		* return total numbers of Buildings object for display
		*/
		public function get TotalBuildings()
		{
			return this.gameViewObjects.length;
		}
		
		/**
		* return all view of game objects (Vector of spriteSheet)
		*/
		public function get ViewObject()
		{
			return this.gameViewObjects;
		}
		
		/**
		* Manually get nth spritesheet object with specified index corresponding
		* to the image.
		* @param n: nth object
		* @param index: index corresponding to an image inside the object
		*/
		public function getNthGameObjIndexOf(n:int, index:int)
		{
			return this.ViewObject[n].getImageIndexOf(index);
		}
		
		/**
		* get nth spritesheet object with current index corresponding to the image
		* @param n: nth object
		*/
		public function getCurGameObjOf(n:int)
		{
			return this.ViewObject[n].getCurrentImage();
		}
		
		public function Update()
		{
			// update state of the building to draw or location
		}
		
		
	}
	
}