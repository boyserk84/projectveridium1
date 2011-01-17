package contents{
	
	import flash.display.MovieClip;
	/**
	* Img Builiding Icon
	* This class object will hold a representation or image of each building.
	* This class will act as an add icon/button.
	*/
	public class ImgBuildingIcon extends MovieClip
	{
		/*
		* Constructor
		* @param (x,y) (X,Y) screen position
		* @param type Building Type
		*/
		public function ImgBuildingIcon(x:int, y:int, type:int)
		{
			this.x = x;
			this.y = y;
			gotoAndStop(type+1);
		}
		
		/*
		* return currentFrame
		*/
		public function get Type():int
		{
			return currentFrame;
		}
		/**
		* return type of the building
		*/
		public function get getBuildingType():int
		{
			return currentFrame-1;
		}
		
		/*
		* Set this image icon disappeared
		*/
		public function setInvisible():void
		{
			this.visible = false;
		}
		
		/*
		* Set this image icon appeared
		*/
		public function setVisible():void
		{
			this.visible = true;
		}
	}
	
}