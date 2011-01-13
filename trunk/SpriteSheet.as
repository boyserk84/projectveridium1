package {
	import flash.display.Bitmap;
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.ColorTransform;
	import constant.*;
	import contents.*;
	
	/**
	* SpriteSheet
	* (Strategy pattern)
	* Every reprensentation (image represent object) will be handled by this class.
	* Each building representation has a spritesheet.
	* Each spritesheet will have one or more image object associated with it.
	*/
	public class SpriteSheet extends MovieClip
	{
		private var object_Type:int;					// Corresponding to different category of images
		private var children:Vector.<MovieClip>;		// derived objects (image objects)
		private var curr_image:int;						// Index corresponding to current image displayed
		
		/**
		* SpriteSheet Constructor
		* @param type Type of building, or any game object
		* @param xLoc, yLoc : X,Y game location
		*/
		public function SpriteSheet(type:int, xLoc:int, yLoc:int):void
		{
			this.object_Type = type;
			this.children = new Vector.<MovieClip>;
			this.x = xLoc;
			this.y = yLoc;
			this.curr_image = Images.DEFAULT_INDEX;
		
			if (this.object_Type == BuildingType.TILE)
			{
				// object_type deterime how many images needed
				// also determine what type of object to be added
				
				// Allocate different type of object
				// and put in the vector
				//this.children.push(new ImgBuilding(this.x,this.y));
				this.children.push(new Tile(this.x, this.y));
			}
			
			// Barrack
			if (this.object_Type == BuildingType.BARRACK)
			{
				this.children.push(new ImgBuilding(this.x,this.y));
			}
			
			// Farm
			if (this.object_Type == BuildingType.FARM)
			{
				this.children.push(new ImgBuilding2(this.x,this.y));
			}
			
			if(this.object_Type==WorldType.WORLD_MAP)
			{
//				this.children.push(new WorldMap());
			}
			
			//trace(this.children.length);
		}
		
		/**
		* Update (X,Y) Location
		* @param x, y absolute location
		*/
		public function updateXYLoc(x:int, y:int):void
		{
			this.x = x;
			this.y = y;
		}
		
		/**
		* getTotalImages
		* @return return total images
		*/
		public function getTotalImages()
		{
			return this.children.length;
		}
		
		/**
		* Manually get an actual image object corresponding to the index
		*
		*/
		public function getImageIndexOf(index:int):MovieClip
		{
			return this.children[index];
		}
		
		/**
		* get a current actual image object
		*/
		public function getCurrentImage():MovieClip
		{
			return this.children[this.curr_image];
		}
		
		/**
		* set current corresponding index of image displayed
		*/
		public function setIndexImage(index:int):void
		{
			if (this.children.length > index && index >= 0)
			{
				this.curr_image = index;
			}
		}
		
		/**
		* Set image invisible
		*/
		public function setInvisible()
		{
			getCurrentImage().visible = false;
		}
		
		/**
		* Check if the image is visible
		*/
		public function isVisible()
		{
			return getCurrentImage().visible;
		}
		
		
	}
}