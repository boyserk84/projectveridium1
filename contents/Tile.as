package contents{
	import flash.display.Bitmap;
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import contents.*;
	
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
			
			this.hitArea= new hitTriangle();
			/* testing 
			this.hitArea = new hitTriangle();
			this.addEventListener(MouseEvent.CLICK, isHit);
			trace("hit Triangle");
			*/
		}
		
		public function get X()
		{
			return this.x;
		}
		
		public function get Y()
		{
			return this.y;
		}
		/*
		public function isHit(event:MouseEvent):Boolean
		{
			if (this.hitArea == event.target)
			{
				trace("Hit");
				return true;
			}
			trace("not hit");
			return false;
		}
		*/
		
	}
}