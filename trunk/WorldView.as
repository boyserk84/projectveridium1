﻿package{
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import classes.*;
	import constant.*;
	import contents.TownInfoPane;
	import contents.WorkerManagementScreen;

	
	public class WorldView extends MovieClip
	{
		
		private var gameViewObjects:Array;
		private var offset:Point;
		private var townInfoPane:TownInfoPane;
		private var workerManagement:WorkerManagementScreen;
		
		public function WorldView()
		{
			offset=new Point(0,0);
			gameViewObjects=new Array();
			townInfoPane=new TownInfoPane();
			workerManagement=new WorkerManagementScreen();
			
			
			//Grab all of the cities from the server with their current owners
			
			drawAll();
		}
		
		public function get TownInfo():TownInfoPane
		{
			return townInfoPane;
		}
		
		public function get WorkerManagement():WorkerManagementScreen
		{
			return workerManagement;
		}
		
		public function addAssets(assetsIn:Array):void
		{
			assetsIn.forEach(draw,null);
		}
		
		public function addAsset(assetIn:MovieClip):void
		{
			if(!(this.contains(assetIn)))
			{
				this.addChild(assetIn);
			}
		}
		
		public function removeAsset(assetIn:MovieClip):void
		{
			if(this.contains(assetIn))
			{
				this.removeChild(assetIn);
			}
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
		
		public function showTownInfo(townIn:Town):void
		{
			townInfoPane.setAttributes(townIn.Wood,townIn.Iron,townIn.Money,townIn.Population,townIn.Name,townIn.Location);
			townInfoPane.x=(townIn.x)+WorldConfig.TOWN_INFO_OFFSET_X;
			townInfoPane.y=(townIn.y)+WorldConfig.TOWN_INFO_OFFSET_Y;
			this.addChild(townInfoPane);			
		}
		
		public function showWorkerManagement(townIn:Town):void
		{
			workerManagement.updateAttributes(townIn);
			workerManagement.x=(townIn.x)+WorldConfig.TOWN_INFO_OFFSET_X;
			workerManagement.y=(townIn.y)+WorldConfig.TOWN_INFO_OFFSET_Y;
			this.addChild(workerManagement);			
		}
		
		public function hideTownInfo():void
		{
			if(this.contains(townInfoPane))
			{
				this.removeChild(townInfoPane);
			}
		}
		
		public function hideWorkerManagement():void
		{
			if(this.contains(workerManagement))
			{
				this.removeChild(workerManagement);
			}
											  
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