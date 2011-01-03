package {
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import classes.*;
	import constant.*;
	
	/**
	* View class
	*	Management of all graphic and view representation.
	*/
	public class View extends MovieClip
	{
		// get hold of Building objects not only data objects
		//private var gameBuildingList:LinkedList;				// Actual building game object
		private var gameSortedBuildingList:Array;				// Sorted Building List
		
		// Internal Structure
		private var gameViewObjects:Vector.<SpriteSheet>;				// All game objects for view
		private var gameViewPanel:Vector.<SpriteSheet>;					// All panel/admin objects in the game
		private var gameTileObjects:Vector.<SpriteSheet>;
		
		private var viewStage:Stage;			// Stage management
		/**
		* View Constructor
		* @param ref_stage: stage of GameCanvas
		*/
		public function View(ref_stage:Stage)
		{
			this.gameViewObjects = new Vector.<SpriteSheet>;
			this.gameViewPanel = new Vector.<SpriteSheet>;
			this.gameTileObjects = new Vector.<SpriteSheet>;
			this.gameSortedBuildingList = new Array();
			this.viewStage = ref_stage;
			this.createIsoTileView();
		}
		
		/**
		* create an isometric view of tiles
		*/
		private function createIsoTileView()
		{
			for (var row:int =0; row < 5; ++row)
			{
				for (var col:int = 0; col < 5; ++ col)
				{
					this.gameTileObjects.push
					(new SpriteSheet(BuildingType.TILE,
									 isometricTrans_X(col,row),
									 isometricTrans_Y(col,row)
									 )
					 );
				}//for
			}//for
		}
		
		/**
		* Transform X-game position to X-isometric display position
		* @param col, row: X or Y coordinate game position
		*/
		private function isometricTrans_X(col:int, row:int):int
		{
			return GameConfig.TILE_INIT_X + GameConfig.TILE_WIDTH*col - row*GameConfig.TILE_WIDTH/2 - col*GameConfig.TILE_WIDTH/2;
		}
		
		/**
		* Transform Y-game position to Y-isometric display position
		* @param col, row: X or Y coordinate game position
		*/
		private function isometricTrans_Y(col:int, row:int):int
		{
			return GameConfig.TILE_INIT_Y + GameConfig.TILE_HEIGHT*row - 
						row*GameConfig.TILE_HEIGHT/2 + col*GameConfig.TILE_HEIGHT/2;
		}
		
		
		/**
		* Comparator: compareTileValue using for sorting display
		* @param a building object
		* @param b building object
		*/
		private function compareTileValue(a:Building, b:Building)
		{
			if ((a.Location.x + a.Location.y) < (b.Location.x + b.Location.y))
			{
				return -1;
			} else if ((a.Location.x + a.Location.y) > (b.Location.x + b.Location.y))
			{
				return 1;
			} else return 0;
		}
		
		/**
		* sortBuilding for isometric view
		* @param list LinkedList of building objects
		*/
		private function sortBuilding(list:LinkedList)
		{
			// Add LinkedList building into an array for sorting
			for (var i:int=0; i < list.Length; ++i)
			{
				this.gameSortedBuildingList.push(Building(list.Get(i).data));
			}
			//Sort using comparator
			this.gameSortedBuildingList.sort(this.compareTileValue);
		}
		
		/**
		* constructIsoView
		* Constructing isometric view for all building objects
		*/
		private function constructIsoView()
		{
			for (var i:int=0; i < this.gameSortedBuildingList.length; ++i)
			{
				// (1) Extracting info from each building object
				// x,y and type of building
				//var temp_building = Building(gameBuildingList.Get(i).data);
				var temp_building = this.gameSortedBuildingList[i];
				var temp_type:int = (temp_building.Type);
				var temp_x:int = (temp_building.Location.x); 
				var temp_y:int = (temp_building.Location.y);
				
				// (2) Construct spriteSheet based on type and 
				// (3) isometrically transform game position (x,y)
				this.gameViewObjects.push(new SpriteSheet
										  (temp_type,
										   /* if one dimension minus 0, then minus WIDTH/2 */
										   isometricTrans_X(temp_x ,temp_y) - (this.gameSortedBuildingList[i].isSingleDim()?0:GameConfig.TILE_WIDTH/2), 
										   isometricTrans_Y(temp_x,temp_y)-GameConfig.TILE_HEIGHT/2)
										  );
				
				//trace(this.gameViewObjects[i].x + "," + this.gameViewObjects[i].y);
			}//for
		}
		
		/**
		* Add LinkedList of building objects from the game logic
		* @param LinkedList list of building objects
		*/
		public function addBuildingList(list:LinkedList)
		{
			this.sortBuilding(list);
			this.constructIsoView();
		}
		
		public function determineTileNumber(x:int,y:int):int
		{
			for (var i:int = 0; i < this.TotalTiles; ++i)
			{
				if (this.gameTileObjects[i].hitTestPoint(x,y,true))
				{
					return i;
				}
			}
			return -1;
		}
		
		/**
		* return total numbers of Buildings object for display
		*/
		public function get TotalBuildings()
		{
			return this.gameViewObjects.length;
		}
		
		/**
		* return total numbers of tiles for display
		*/
		public function get TotalTiles()
		{
			return this.gameTileObjects.length;
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
		* @return MovieClip object from spritesheet
		*/
		public function getCurGameObjOf(n:int)
		{
			return this.ViewObject[n].getCurrentImage();
		}
		
		/**
		* get nth spritesheet object of Tile with current index
		* @param n: nth object (tile)
		*/
		public function getTileIndexOf(n:int)
		{
			return this.gameTileObjects[n].getCurrentImage();
		}
		
		/**
		* Draw everything that needs to be displayed
		*/
		public function drawAll()
		{
			// Draw tile
			for (var i:int =0; i < this.TotalTiles; ++i)
			{
				this.viewStage.addChild(this.getTileIndexOf(i));
			}
			
			// Draw building
			for (var i:int =0; i < this.TotalBuildings; ++i)
			{
				this.viewStage.addChild(this.getCurGameObjOf(i));
			}
		}
		
		/**
		* Update everything in the "View"
		*/
		public function Update()
		{
			// update state of the building to draw or location
			this.drawAll();
		}
		
		
	}
	
}