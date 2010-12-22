package contents{
	import flash.display.Bitmap;
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	/**
	* Tile
	*	Dummy class represents image or representation of tile.
	*/
	public class Tile extends MovieClip
	{
		public function Tile(x:Number, y:Number)
		{
			this.x = x;
			this.y = y;
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