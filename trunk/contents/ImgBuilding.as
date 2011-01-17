package contents{
	import flash.display.Bitmap;
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import constant.*;
	
	/**
	* ImgBuilding
	*	Dummy class represents image or representation of each building.
	*/
	public class ImgBuilding extends MovieClip
	{
		/**
		* Constructor
		* @param x,y (X,Y) displayed location
		* @param type : Type of building
		*/
		public function ImgBuilding(x:Number, y:Number, type:int)
		{
			this.x = x;
			this.y = y;
			gotoAndStop(type+1);
		}
		
		public function get X()
		{
			return this.x;
		}
		
		public function get Y()
		{
			return this.y;
		}
		
		/**
		* return building type of this image
		*/
		public function get getBuildingType()
		{
			return currentFrame-1;
		}
		
		/**
		* return actual frame index of image
		*/
		public function get currFrame()
		{
			return currentFrame;
		}
	}
}