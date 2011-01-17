package{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import classes.*;
	import constant.*;
	import contents.*;
	
	/**
	* MenuSystem
	*/
	public class MenuSystem extends MovieClip
	{
		
		private var type:int;			// Menu type (WorldMap vs. City)
		private var sub_type:int;		// Sub-menu type (Within City)
		
		private var children:Array;		// sub-menu children
		private var sub_menu:int;		// Type of sub menu
		
		/* Internal GUI */
		//private var win_
		private var all_icons:ImgMenu;		// all clickable icons of builiding
		
		/* Internal Reference */
		private var index_removeButton:int;
		private var index_changeButton:int;
		private var index_nextButton:int;
		private var index_prevButton:int;
		private var index_milButton:int, index_civButton:int;
		private var index_cancelButton:int;
		
		/* game content reference */
		private var buildable_icons:Array;
		
		/* Pagination */
		private var current_page:int = 0;
		
		/**
		* Constructor
		* @param x,y (X,Y) Position
		* @param menu_type Menu type
		*/
		public function MenuSystem(x:int, y:int, menu_type:int)
		{
			this.x = x;
			this.y = y;
			this.type = menu_type;
			this.sub_type = Images.WIN_MIL_SUB;
			gotoAndStop(this.type);
			this.children = new Array();
			//this.alpha = 0;
		}
		
		/**
		* Build Menu
		*/
		public function buildMenu()
		{
			switch (this.type)
			{
				case Images.WIN_CITYMENU:
					construct_CityMenu();
					break;
				case Images.WIN_WORLDMENU:
					// Allocate all windows
					//win_panel = new ImgMenu(x,y, Images.WIN_WORLDMENU);
					break;
			}
			
			displayMenuSystem();
		}
		
		/**
		* feed city requirement for icons creation
		* @param arr (Boolean) array of buildings that can be built
		*/
		public function feedCityReqToIcons(arr:Array):void
		{
			this.buildable_icons = arr;
		}
		
		/**
		* Update city's list of buildings that has been built
		* @param arr (Boolean) array of city
		*/
		public function updateCityReq(arr:Array)
		{
			all_icons.updateCityBuiltList(arr);
		}
		
		/**
		* Construct city-map menu
		*/
		private function construct_CityMenu():void
		{
			
			// Main button
			index_removeButton = 0;
			this.children.push(new TriggerButton(450,0, GameConfig.COMM_REMOVE));
			index_changeButton = 1;
			this.children.push(new TriggerButton(450,30, GameConfig.CHANGE_WORLD));
			
			// Add building buttons/menu
			this.all_icons = new ImgMenu(0,0,buildable_icons);
			this.children.push(all_icons);
			index_nextButton = 3;
			this.children.push(new TriggerButton(440,55, GameConfig.COMM_NEXT));
			index_prevButton = 4;
			this.children.push(new TriggerButton(15, 55, GameConfig.COMM_PREV));
			index_milButton = 5;
			index_civButton = 6;
			index_cancelButton = 7;
			this.children.push(new TriggerButton(15, 10, GameConfig.COMM_MIL_LIST));
			this.children.push(new TriggerButton(150, 10, GameConfig.COMM_CIV_LIST));
			this.children.push(new TriggerButton(650,10, GameConfig.COMM_CANCEL));
			// Add external function
			addExtFuncTo(GameConfig.COMM_NEXT,MouseEvent.CLICK, nextPage );
			addExtFuncTo(GameConfig.COMM_PREV,MouseEvent.CLICK, prevPage );
			addExtFuncTo(GameConfig.COMM_MIL_LIST, MouseEvent.CLICK, switchSubMenu);
			addExtFuncTo(GameConfig.COMM_CIV_LIST, MouseEvent.CLICK, switchSubMenu);
		}
		
		/**
		* Switch sub menu between civil and military building list
		* @param event Mouseevent listener
		*/
		private function switchSubMenu(event:MouseEvent):void
		{
			var menu:int = this.children[IndexOfIcons].currentMenu;
			if (menu == Images.WIN_MIL_SUB)
			{
				menu = Images.WIN_CIVIL_SUB;
			} else {
				menu = Images.WIN_MIL_SUB;
			}
			this.children[IndexOfIcons].switchSubMenu(menu);
		}
		
		/**
		* Listener class for pagination
		*/
		private function nextPage(event:MouseEvent)
		{
			//trace("Curr n page " + current_page);
			//trace("nextPage");
			
			if (!isValidNextPage(++current_page))
			{
				//trace("Start Max Index" + current_page*Images.MAX_ICON_PER_PAGE);
				--current_page;
			}
			all_icons.nextPage(current_page);
		}
		
		/**
		* Is a valid next page?
		* @param current_page
		* @return True if it is a valid next page
		*/
		private function isValidNextPage(current_page:int)
		{
			return !(current_page*Images.MAX_ICON_PER_PAGE >= all_icons.TOTAL_MAX_ENTRY + 1);
		}
		
		/**
		* Listener class for pagination (previous)
		*/
		private function prevPage(event:MouseEvent)
		{
			//trace("Prev");
			//trace("Curr page " + current_page);
			if (current_page <= 0) 
			{
				current_page = 1;
			}
			all_icons.prevPage(--current_page);
		}
		
		/**
		* Display a complete menu system to the screen
		*/
		private function displayMenuSystem()
		{
			// Draw to screen
			for (var i:int = 0; i < this.children.length; ++i)
			{
				this.addChild(this.children[i]);
			}
		}
		
		/*
		* Attach external function (listener) to particular button
		* @param button Type of button (See GameConfig)
		* @param add_event Type of event trigger
		* @param func External function/trigger event function
		*/
		public function addExtFuncTo(button:int, add_event:String,func:Function):void
		{
			switch (button)
			{
				case GameConfig.COMM_REMOVE:
					children[index_removeButton].addEventListener(add_event,func);
					break;
				case GameConfig.COMM_ADD:
					addExtFuncToIcons(add_event,func);
					break;
				case GameConfig.CHANGE_WORLD:
					children[index_changeButton].addEventListener(add_event,func);
					break;
				case GameConfig.COMM_NEXT:
					children[index_nextButton].addEventListener(add_event,func);
					break;
				case GameConfig.COMM_PREV:
					children[index_prevButton].addEventListener(add_event,func);
					break;
				case GameConfig.COMM_MIL_LIST:
					children[index_milButton].addEventListener(add_event,func);
					break;
				case GameConfig.COMM_CIV_LIST:
					children[index_civButton].addEventListener(add_event,func);
					break;
				case GameConfig.COMM_CANCEL:
					children[index_cancelButton].addEventListener(add_event,func);
					break;
				default:
					// do something
					break;
			}
		}
		
		/**
		* Add external function (listner) to all building icons
		* @param add_event type of triggered event
		* @param func External function/event function
		*/
		private function addExtFuncToIcons(add_event:String,func:Function):void
		{
			this.children[IndexOfIcons].addExtFuncToAll(add_event,func);
		}
		
		/**
		* return index of where a set of all icons located
		*/
		private function get IndexOfIcons()
		{
			return this.children.indexOf(all_icons);
		}
		
	}

}