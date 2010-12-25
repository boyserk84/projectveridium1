package contents{
	import flash.display.Bitmap;
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	/**
	* ImgBuilding2
	*	Dummy class represents image or representation of each building.
	*/
	public class ImgBuilding2 extends MovieClip
	{
		public function ImgBuilding2(x:Number, y:Number)
		{
			this.x = x;
			this.y = y;
			//this(0);
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