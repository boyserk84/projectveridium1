package contents{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import constant.*;
	
	/**
	* ImgMenu
	*	Show list of all buildings.
	*	Class object represents image or representation of a menu system.
	*	It also determines what is shown on the screen.
	* 	For City Menu,
	*		this class will hold a sub menu for each category of buildings.
	*		Frame 1 : Military Buildings
	*		Frame 2 : Civilian BUildings
	*/
	public class ImgMenu extends MovieClip
	{
		private var icon_children:Array;					// Icon represents each building
		
		private var icon_shown:Array = null;				// which icon can be shown
		
		// Internal Strucuture 
		private var icon_mil:Array = null;		// Keep track of miltary building index
		private var icon_civil:Array = null;	// Keep track of civil building index
		private var bound:int = 0;				// Maximum bound for each type of building
		
		/**
		* Constructor
		* @param x, y (X,Y) position on the screen
		* @param citylist List of buildings that has been built from the city
		*/
		public function ImgMenu(x:Number, y:Number, citylist:Array)
		{
			this.x = x;
			this.y = y;
			this.icon_shown = citylist;
			gotoAndStop(Images.WIN_MIL_SUB);
			icon_children = new Array();
			icon_mil = new Array();
			icon_civil = new Array();
			constructBound();
			constructSUBMENU();
			
			
			trace("Create a sub-menu");
		}
		
		/**
		* Update list of building to be shown
		*/
		public function updateCityBuiltList(arr:Array)
		{
			this.icon_shown = arr;
			goToPage(0);
		}
		
		/**
		* Construct all icons and set them all invisible
		*/
		private function constructIcons():void
		{
			var temp_count:int = 0;
			var mil_count = 0;
			var civil_count = 0;
			
			// Construct icon of each building (all type)
			// Locate where each should be displayed (in order).
			for (var i:int = 0; i < BuildingType.TOTAL_BUILD_TYPE; ++i)
			{
				switch((BuildingInfo.getInfo(i)).Type)
				{
					case BuildingType.MIL_TYPE:
						temp_count = mil_count % Images.MAX_ICON_PER_PAGE;
						this.icon_children.push(new ImgBuildingIcon(60+(temp_count*92),35,BuildingType.TOWN_SQUARE + i));
						++mil_count;
						this.icon_mil.push(i);
					break;
					case BuildingType.CIVIL_TYPE:
						temp_count = civil_count % Images.MAX_ICON_PER_PAGE;
						this.icon_children.push(new ImgBuildingIcon(60+(temp_count*92),35,BuildingType.TOWN_SQUARE + i));
						++civil_count;
						this.icon_civil.push(i);
					break;
				}
				
				this.icon_children[i].setInvisible();
				this.addChild(icon_children[i]);
			}
		}
		
		/**
		* set boundary (maximum entry) for building type
		*/
		private function constructBound()
		{
			if (currentFrame == Images.WIN_MIL_SUB)
			{
				bound = BuildingType.TOTAL_MIL_TYPE;
			} else if (currentFrame == Images.WIN_CIVIL_SUB) {
				bound = BuildingType.TOTAL_CIVIL_TYPE;
			} else {
				bound = BuildingType.TOTAL_BUILD_TYPE;
			}
		}
		
		/**
		* Construct sub-menu
		*/
		private function constructSUBMENU():void
		{	
			constructIcons();
			goToPage(0);
		}
		

		
		/**
		* Set all icons invisible and reset alpha to opaque value
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
			goToPage(page);
		}
		
		/**
		* (Pagination)
		* Go to prev page: Display previous list of buildings
		* @param page: Page number
		*/
		public function prevPage(page:int):void
		{
			goToPage(page);
		}
		
		/**
		* Jump to a specific page with correct element and index
		* @param page Specific page
		*/
		private function goToPage(page:int):void
		{
			setAllIconsInvisible();
			updateDisplayList();
			setRegionVisible(page);
		}
		
		/**
		* find a maximum index value at a specific page
		* @param page: Specific page
		* @return maximum index value
		*/
		private function findMaxIndexAtPage(page:int):int
		{
			var max:int = page*Images.MAX_ICON_PER_PAGE+4;
			if (page==0)
			{
				max = Images.MAX_ICON_PER_PAGE;
			}
			
			//trace("Bound" + bound);
			// Upper bound check
			if (max >= bound)
			{
				max = bound ;
			}
			//trace("Maximum" + max);
			return max;
		}
		
		/**
		* find a minimum index value at a specific page
		* @param page Specific page
		* @return min index value
		*/
		private function findMinIndexAtPage(page:int):int
		{
			if (page > 0)
			{
				return page*Images.MAX_ICON_PER_PAGE;
			} else { 
				return 0;
			}
		}
		
		/**
		* (Pagination)
		* set particular set of icons to be displayed
		*/
		private function setRegionVisible(page:int):void
		{
			//trace("Set Region");
			var init_s:int, max:int;
			init_s = findMinIndexAtPage(page);
			max = findMaxIndexAtPage(page);
			
			//trace("start page" + init_s + " end page " + max);
			
			displayRegion(init_s,max);
			
		}
		
		/**
		* Display a particular region set of icons to be displayed
		* @param init_s : Starting index
		* @param max : max index
		*/
		private function displayRegion(init_s:int, max:int):void
		{
			if (init_s < max)
			{
				// Display a particular region
				for (var i:int = init_s; i < max; ++i)
				{
					if (currentFrame == Images.WIN_MIL_SUB)
					{
						//trace(icon_mil.length + "A-->" + this.icon_mil[i] + " Alpha : " + this.icon_children[icon_mil[i]].alpha);
						this.icon_children[this.icon_mil[i]].setVisible();
					} else if (currentFrame == Images.WIN_CIVIL_SUB)
					{
						//trace(icon_civil.length + "C-->" + this.icon_civil[i]);
						this.icon_children[this.icon_civil[i]].setVisible();
					}
				}//for
			}
		}
		
		/**
		* Update list of building icons to be shown
		* Determine what icons should be shown
		*/
		private function updateDisplayList():void
		{
			// Display
			for (var i:int = 0; i < BuildingType.TOTAL_BUILD_TYPE; ++i)
			{
				// Determine what can be displayed
				if (this.icon_shown!=null)
				{
					if (icon_shown[i]<=0)	// if not meeting requirement
					{
						//trace("not shown at " + i);
						this.icon_children[i].alpha = GameConfig.HALF_TRANSPARENT;
					}
				}
			}//for
		}
		
		/*
		* return Maximum entry of icons of a particular building type
		*/
		public function get TOTAL_MAX_ENTRY()
		{
			return this.bound;
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
			constructBound();
			constructSUBMENU();
		}
		
		/**
		* return current menu being displayed
		*/
		public function get currentMenu():int
		{
			return currentFrame;
		}
	
		public function get X() { return this.x; }
		public function get Y() { return this.y; }
		
	}
}