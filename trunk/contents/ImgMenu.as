package contents{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
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
		
		private var icon_shown:Array = null;				// which icon can be shown
		/**
		* Constructor
		* @param x, y (X,Y) position on the screen
		* @param type Type of Menu (Frame)
		* @param type Requirement for building city;
		*/
		public function ImgMenu(x:Number, y:Number, cityreq:Array)
		{
			this.x = x;
			this.y = y;
			gotoAndStop(Images.WIN_MIL_SUB);
			icon_children = new Array();
			this.icon_shown = cityreq;
			constructMIL_SUB();
			
			trace("Create a sub-menu");
		}
		
		/**
		* Update list of building to be shown
		*/
		public function updateCityReq(arr:Array)
		{
			this.icon_shown = arr;
			setRegionVisible(0);
		}
		
		/**
		* Construct military button sub-menu
		*/
		private function constructMIL_SUB():void
		{	
			var temp_count:int = 0;
			
			// Construct icon of each building (all type)
			for (var i:int = 0; i < BuildingType.TOTAL_BUILD_TYPE; ++i)
			{
				temp_count = i % Images.MAX_ICON_PER_PAGE;
				this.icon_children.push(new ImgBuildingIcon(60+(temp_count*92),12,BuildingType.TOWN_SQUARE + i));
				this.icon_children[i].setInvisible();
				this.addChild(icon_children[i]);
			}
			
		
			// Display icons on 1st page
			setRegionVisible(0);
		}
		
		/**
		* Set all icons invisible
		*/
		private function setAllIconsInvisible():void
		{
			for (var i:int = 0; i < BuildingType.TOTAL_BUILD_TYPE; ++i)
			{
				this.icon_children[i].setInvisible();
				this.icon_children[i].alpha = GameConfig.OPAQUE;
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
		* find a maximum index value at a specific page
		* @param page: Specific page
		* @return maximum index value
		*/
		private function findMaxIndexAtPage(page:int):int
		{
			var max:int = page*Images.MAX_ICON_PER_PAGE*2;
				
			// Upper bound check
			if (max >= BuildingType.TOTAL_BUILD_TYPE)
			{
				max = BuildingType.TOTAL_BUILD_TYPE -1;
			}
			return max;
		}
		
		/**
		* (Pagination)
		* set particular set of icons to be displayed
		*/
		private function setRegionVisible(page:int):void
		{
			trace("Set Region");
			
			var init_s:int, max:int;
			
			if (page > 0)
			{
				init_s = page*Images.MAX_ICON_PER_PAGE;
				max = findMaxIndexAtPage(page);
				//trace("start page" + init_s + " end page " + max);
			} else { // Lower bound check
				init_s= 0;
				max = Images.MAX_ICON_PER_PAGE;
			}

			if (init_s < max)
			{
				setAllIconsInvisible();
				
				// Display
				for (var i:int = init_s; i < max; ++i)
				{
					//trace("Icon: " + i);
					
					// Determine what can be displayed
					if (this.icon_shown!=null)
					{
						this.icon_children[i].setVisible();
						
						if (!icon_shown[i])	// if not meeting requirement
						{
							this.icon_children[i].alpha = GameConfig.HALF_TRANSPARENT;
						}
					}
				}//for
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