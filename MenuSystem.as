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
		
		private var current_page:int = 0;
		
		private var ref_stage:Stage;
		
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
			//this.ref_stage = ref_stage;
			//this.alpha = 0;
			
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
		* Switch to sub menu type
		*/
		public function switchSubMenu(sub_menu:int)
		{
			switch(sub_menu)
			{
				case Images.WIN_MIL_SUB:
					
					
					// 
					break;
				case Images.WIN_CIVIL_SUB:
				
					break;
			}
		}
		
		/**
		* Construct world-map menu
		*/
		private function construct_WorldMenu():void
		{
			
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
			this.all_icons = new ImgMenu(0,0)
			this.children.push(all_icons);
			index_nextButton = 3;
			this.children.push(new TriggerButton(440,30, GameConfig.COMM_NEXT));
			index_prevButton = 4;
			this.children.push(new TriggerButton(15, 30, GameConfig.COMM_PREV));
			addExtFuncTo(GameConfig.COMM_NEXT,MouseEvent.CLICK, nextPage );
			addExtFuncTo(GameConfig.COMM_PREV,MouseEvent.CLICK, prevPage );
		}
		
		/**
		* Listener class for pagination
		*/
		private function nextPage(event:MouseEvent)
		{
			trace("nextPage");
			all_icons.nextPage(++current_page);
		}
		
		/**
		* Listener class for pagination (previous)
		*/
		private function prevPage(event:MouseEvent)
		{
			trace("Prev");
			all_icons.nextPage(--current_page);
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
		* TODO: Make sure display all building list is working first.
		*/
		public function determineCityMenu(city:City)
		{
			var icon_list:Array = BuildingManager.determineBuildingList(city);
			
			for (var i = 0; i < icon_list.length; ++i)
			{
				
				if (icon_list[i])	// if met requirement
				{
					//this.removeChild();	// remove cross
				} else {
					//this.addChild(); // add cross
				}
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