package{
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import classes.*;
	import constant.*;
	
	public class WorldView extends MovieClip
	{
		
		private var gameViewObjects:Array;
		private var offset:Point;
		
		public function WorldView()
		{
			offset=new Point(0,0);
			gameViewObjects=new Array();
			//Build the District map
			for(var i:int=1;i<12;++i)
			{
				var clip:MovieClip=WorldSpriteInfo.getSprite(i);
				clip.x=WorldConfig.getInfo(i).x;
				clip.y=WorldConfig.getInfo(i).y;
				gameViewObjects.push(clip);
			}
			
			//Grab all of the cities from the server with their current owners
			
			drawAll();
		}
		
		public function addAssets(assetsIn:Array):void
		{
			assetsIn.forEach(draw,null);
		}
		
		public function changeOffset(changeIn:Point):void
		{
			offset.x=offset.x+changeIn.x;
			offset.y=offset.y+changeIn.y;
		}
					
		public function drawAll():void
		{
			gameViewObjects.forEach(draw,null);
			gameViewObjects=null;
		}
		
		
		public function draw(clip:*,index:int,array:Array):void
		{
			clip=MovieClip(clip);
			if(!(this.contains(clip)))
			{
				this.addChild(clip);
			}
		}
		
		public function get Offset():Point
		{
			return offset;
		}
		
		
		
		
		
	}
	
	
}