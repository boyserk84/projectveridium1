package {
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Point;
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
		
		private var offset:Point;
		
		// Internal Structure
		private var gameViewObjects:Vector.<SpriteSheet>;				// All game objects for view
		private var gameViewPanel:Vector.<SpriteSheet>;					// All panel/admin objects in the game
		private var gameTileObjects:Vector.<SpriteSheet>;
		
		// Holding actual graphics
		//private var viewStage:GameCanvas;			// Stage management
		
		private var need_update:Boolean;
		
		private var total_x_tile:int;
		private var total_y_tile:int;
		
		/**
		* View Constructor
		* @param ref_stage: stage of GameCanvas
		*/
		public function View(new_city:City)
		{
			this.gameViewPanel = new Vector.<SpriteSheet>;
			this.gameTileObjects = new Vector.<SpriteSheet>;
			offset=new Point(0,0);
			//this = ref_stage;
			this.total_x_tile = new_city.Bounds.width;
			this.total_y_tile = new_city.Bounds.height;
			this.createIsoTileView();
			this.need_update = true;


		}
		
		/**
		* create an isometric view of tiles
		*/
		private function createIsoTileView()
		{
			for (var row:int =0; row < this.total_x_tile; ++row)
			{
				for (var col:int = 0; col < this.total_y_tile; ++ col)
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
			
			return (GameConfig.TILE_INIT_X + GameConfig.TILE_WIDTH*col - row*GameConfig.TILE_WIDTH/2 - col*GameConfig.TILE_WIDTH/2)+offset.x;
		}
		
		/**
		* Transform Y-game position to Y-isometric display position
		* @param col, row: X or Y coordinate game position
		*/
		private function isometricTrans_Y(col:int, row:int):int
		{
			return(GameConfig.TILE_INIT_Y + GameConfig.TILE_HEIGHT*row - 
						row*GameConfig.TILE_HEIGHT/2 + col*GameConfig.TILE_HEIGHT/2)+offset.y;
		}
		
		public function get Offset():Point
		{
			return offset;
		}
		
		public function updateOffset(changeIn:Point):void
		{
			offset.add(changeIn);
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
			this.gameViewObjects = new Vector.<SpriteSheet>;
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
		public function addBuildingList(list:LinkedList):void
		{
			// Refresh game contents
			if (this.gameSortedBuildingList !=null )
			{
				deleteGameBuildings();
				//trace("Create");
			}
			
			this.gameSortedBuildingList = new Array();
			this.sortBuilding(list);	// sort
			
			// Refresh view contents
			if (this.ViewObject!=null)
			{
				deleteViewOfBuildings();
			}
			
			this.constructIsoView();
			this.need_update = true;
		}
		
		
		/**
		* Collision Detection
		* Checking if (x,y) actually does collide with the target or tile
		* NEED: ISOMETRIC COLLIISION CHECKING, probably OVAL or SPHERE DETECTION
		*/
		private function isCollide(target:MovieClip, x:int,y:int):Boolean
		{
			return !((target.x + target.width)-target.width/4 < x || (target.x + target.width/4) < x)
			&& ((target.y + target.height)-target.height/4 < y || (target.y + target.height/4) < y)
			/**
			return ((target.x + target.width < x) || (x < target.x))
			&& ((target.y + target.height < y) || (y < target.y))
			;
			*/
			
		}
		
		/**
		* Determine which nth Tile is being clicked on
		* @param (X,Y) coordinate
		* @return Nth tile number. Otherwise, -1 is returned.
		*/
		public function checkClickedTile(x:int,y:int):int
		{
			/*
			for (var i:int = 0; i < this.TotalTiles; ++i)
			{
				// NEED BETTER COLLISION DETECTION, BUT IT WORKS FOR NOW.
				//if (isCollide(this.gameTileObjects[i],x,y))
				if (this.gameTileObjects[i].hitTestPoint(x,y, false))
				{
					//trace("Tile:" + this.gameTileObjects[i].x + "," +this.gameTileObjects[i].y);
					//trace (i);
					return i;
				}
			}
			*/
			
			var gameLoc:Point=new Point();
			var ymouse = ((2 * y - x) / 2);
			var xmouse = (x+ y);
			gameLoc.x= Math.round(ymouse / GameConfig.TILE_WIDTH);
			gameLoc.y= Math.round(xmouse / GameConfig.TILE_WIDTH) - 1;
			trace(gameLoc.x+","+gameLoc.y);
			

			return -1;
		}
		
		/**
		* convert (X,Y) screen position to actual game location
		* @param (X,Y) screen position
		* @return (X,Y) position in the game
		*/
		private function convertToGameLoc(x:int, y:int):Point
		{
			//var loc:int = checkClickedTile(x,y);
			
/*			var gameLoc:Point = new Point(loc % GameConfig.MAX_CITY_COL,
										  Math.floor(loc / GameConfig.MAX_CITY_ROW));
		*/
			var gameLoc:Point=new Point();
			var ymouse = ((2*(y-GameConfig.TILE_INIT_Y)-(x-GameConfig.TILE_INIT_X))/2);
			var xmouse = ((x-GameConfig.TILE_INIT_X)+ymouse);
			//find on which tile mouse is
			gameLoc.y = Math.round(ymouse/GameConfig.TILE_HEIGHT);
			gameLoc.x = Math.round(xmouse/GameConfig.TILE_HEIGHT)-1;
			trace("Converting to gameLoc: "+gameLoc.x+","+gameLoc.y);

			return gameLoc;
		}
		
		/**
		* same as ConvertToGameLoc
		*/
		public function getGamePos(x:int, y:int):Point
		{
			return convertToGameLoc(x,y);
		}
		
		/**
		* checking which building game object is being clicked on
		* @param x,y (X,Y) Mouse position
		* @return Building object that being clicked on, Otherwise, null is returned!
		*/
		public function checkClickedBuilding(x:int,y:int):Building
		{
			// Determining actual game location based on Tile Number
			var col:int = convertToGameLoc(x,y).x;
			var row:int = convertToGameLoc(x,y).y;

			for (var i:int = 0; i < this.TotalGameBuildings; ++i)
			{
				if (col == this.gameSortedBuildingList[i].Location.x
					&& row == this.gameSortedBuildingList[i].Location.y)
				{
					if (this.contains(getCurGameObjOf(i)))
					{
						return this.gameSortedBuildingList[i];
					}
				}
			}
			
			return null;
		}
		
		/**
		* set clicked building to be invisible
		* and remove it from the view
		* @param (X,Y) click position
		*
		*/
		public function setClickedBuildingInvisible(x:int, y:int):void
		{
			// Determining actual game location based on Tile Number
			var col:int = convertToGameLoc(x,y).x;
			var row:int = convertToGameLoc(x,y).y;
			
			for (var i:int = 0; i < this.TotalBuildings; ++i)
			{
				if (col == this.gameSortedBuildingList[i].Location.x
					&& row == this.gameSortedBuildingList[i].Location.y)
				{
					if (this.contains(getCurGameObjOf(i)))
					{
						this.removeChild(getCurGameObjOf(i));
					}
				}
			}//for
			
		}
		
		/**
		* Delete all views of Building objects (SpriteSheet)
		*/
		private function deleteViewOfBuildings()
		{
			var temp:MovieClip;
			while(TotalBuildings>0)
			{
				temp = (this.ViewObject.pop().getCurrentImage());
				if (this.contains(temp))
				{
					this.removeChild(temp);
				}
			}
		}
		
		/**
		* Delete all game buildings objects
		*/
		private function deleteGameBuildings()
		{
			while (TotalGameBuildings > 0)
			{
				this.gameSortedBuildingList.pop();
			}
		}
		
		/**
		* return total numbers of Buildings object in the game
		*/
		public function get TotalGameBuildings():int
		{
			return this.gameSortedBuildingList.length;
		}

		/**
		* return total numbers of Buildings object for display
		*/
		public function get TotalBuildings():int
		{
			return this.gameViewObjects.length;
		}
		
		/**
		* return total numbers of tiles for display
		*/
		public function get TotalTiles():int
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
		* Draw all tiles to the stage screen
		*/
		private function drawTiles()
		{
			// Draw tile
			for (var i:int =0; i < this.TotalTiles; ++i)
			{
				this.addChild(this.getTileIndexOf(i));
			}
		}
		
		/**
		* Draw everything that needs to be displayed
		*/
		public function drawAll()
		{
			if (this.need_update)
			{
				this.drawTiles();
				// Draw building
				for (var i:int =0; i < this.TotalBuildings; ++i)
				{
					this.addChild(this.getCurGameObjOf(i));
				}
			}
			this.need_update = false;
		}
		
		/**
		* Update everything in the "View"
		*/
		public function Update()
		{
			// update state of the building to draw or location
			this.drawAll();
			
			for (var i:int = 0; i < this.TotalBuildings; ++i)
			{
				// Check if building is complete, if so change to normal
				if (gameSortedBuildingList[i].isBuildingDone())
				{
					ViewObject[i].changeToMainImage();
				}
			}
		}
		
		
	}
	
}