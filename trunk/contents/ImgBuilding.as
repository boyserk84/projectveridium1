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
		public function ImgBuilding(x:Number, y:Number)
		{
			this.x = x;
			this.y = y;
			trace(BuildingType.BARRACK);
		}
		
		public function get X()
		{
			return this.x;
		}
		
		public function get Y()
		{
			return this.y;
		}
	}
}