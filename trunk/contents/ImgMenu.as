package contents{
	import flash.display.Bitmap;
	import flash.display.Sprite; 
	import flash.display.MovieClip;
	import flash.display.Stage;
	import constant.*;
	
	/**
	* ImgMenu
	*	Class object represents image or representation of a menu system.
	*	It also determines what is shown on the screen.
	* 	For City Menu,
	*		this class will hold a sub menu for each category of buildings.
	*		Frame 1 : Military Buildings
	*		Frame 2 : Civilian BUildings
	*/
	public class ImgMenu extends MovieClip
	{
		private var icon_children:Array;			// Icon represents each building
		
		/**
		* Constructor
		* @param x, y (X,Y) position on the screen
		* @param type Type of Menu (Frame)
		*/
		public function ImgMenu(x:Number, y:Number)
		{
			this.x = x;
			this.y = y;
			gotoAndStop(Images.WIN_MIL_SUB);
			icon_children = new Array();
			constructMIL_SUB();
			
			trace("Create a sub-menu");
		}
		
		/**
		* Construct military button sub-menu
		*/
		private function constructMIL_SUB():void
		{	
			var temp_count:int = 0;
			// Construct icon of each building
			for (var i:int = 0; i < BuildingType.TOTAL_BUILD_TYPE; ++i)
			{
				temp_count = i % Images.MAX_ICON_PER_PAGE;
				this.icon_children.push(new ImgBuildingIcon(10+(temp_count*72),12,BuildingType.BARRACK + i));
				this.icon_children[i].setInvisible();
				
			}
		
			// Display icons on 1st page
			for (var i:int = 0; i < Images.MAX_ICON_PER_PAGE; ++i)
			{
				this.addChild(this.icon_children[i]);
				this.icon_children[i].setVisible();
			}
		}
		
		/**
		* Set all icons invisible
		*/
		private function setAllIconsInvisible():void
		{
			for (var i:int = 0; i < BuildingType.TOTAL_BUILD_TYPE; ++i)
			{
				this.icon_children[i].setInvisible();
			}
		}
		
		/**
		* (Pagination)
		* Go to next page: Display next list of buildings
		* @param page: Page number
		*/
		public function nextPage(page:int):void
		{
			
			setRegionVisible(page);
		}
		
		/**
		* (Pagination)
		* Go to prev page: Display previous list of buildings
		* @param page: Page number
		*/
		public function prevPage(page:int):void
		{
			setRegionVisible(page);
		}
		
		/**
		* (Pagination)
		* set particular set of icons to be displayed
		*/
		private function setRegionVisible(page:int):void
		{
			trace("Set Region");
			setAllIconsInvisible();
			var start:int, max:int;
			if (page > 0)
			{
				start = page*Images.MAX_ICON_PER_PAGE;
				max = page*Images.MAX_ICON_PER_PAGE*2;
			} else {
				start = 0;
				max = Images.MAX_ICON_PER_PAGE;
			}
			
			for (var i:int = start; i < max; ++i)
			{
				trace("Icon: " + i);
				this.icon_children[i].setVisible();
			}
		}
		
		/**
		* Add external function (listener) to all children (buttons)
		* @param event: Triggered Event
		* @param func: External function (event listener)
		*/
		public function addExtFuncToAll(event:String, func:Function):void
		{
			for (var i:int = 0; i < this.icon_children.length; ++i)
			{
				this.icon_children[i].addEventListener(event, func);
			}
		}
		
		/**
		* switch sub-category
		* @param type: (Frame) type of sub-menu
		*/
		public function switchSubMenu(type:int)
		{
			gotoAndStop(type);
		}
		
		//public function get BuildingType()
		
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