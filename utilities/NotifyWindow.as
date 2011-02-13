package utilities {
	import flash.display.MovieClip;
	import constant.GameConfig;
	import constant.Images;
	
	/**
	* Notification windows (A window panel with message, Confirm and cancel buttons)
	* This class is a generic notification window, which can be used throughout the application.
	*/
	public class NotifyWindow extends MovieClip
	{
		
		private var confirmButton:TriggerButton;
		private var cancelButton:TriggerButton;
		
		/*
		* Constructor
		* @param x,y : (X,Y) Location on the scrreen
		* @param type_win: Type of window
		*/
		public function NotifyWindow(x:int, y:int, type_win:int)
		{
			gotoAndStop(type_win);
			this.x = x;
			this.y = y;
			this.visible = false;
			// Location and type of button
			
			if (type_win ==Images.PANEL_CONFIRM)
			{
				confirmButton = new TriggerButton(this.width/6,50+this.height/2,GameConfig.BUTTON_CONFIRM);
				cancelButton = new TriggerButton(20+this.width/2,50+this.height/2,GameConfig.BUTTON_CANCEL);
				this.addChild(cancelButton);
			} else if (type_win == Images.PANEL_WINNER || type_win == Images.PANEL_LOSER) {
				confirmButton = new TriggerButton(70 + this.width/6,50+this.height/2,GameConfig.BUTTON_CONFIRM);
			}
			
			this.addChild(confirmButton);
		}
		
		/**
		* Change dimension of the notification window panel
		* @param width: new width
		* @param height: new height
		*/
		public function changeDimension(width:Number, height:Number):void
		{
			this.width = width;
			this.height = height;
		}
		
		/*
		* Return type of notification window
		*/
		public function get Type():int
		{
			return currentFrame;
		}
		
		/*
		* Modify message being shown on the notification window
		* @param header: Header message
		* @param msg: Detailed message
		*/
		public function modifyMessage(header:String, msg:String):void
		{
			this.headerInfo.text = header;
			this.messageInfo.text = msg;
		}
		
		/*
		* Add event listener function to Confirm button
		* @param trigger: Trigger command/event
		* @param func: External listener function
		*/
		public function addEventToConfirmButton(trigger:String, func:Function):void
		{
			confirmButton.addEventListener(trigger, func);
		}
		
		/*
		* Add event listener function to Cancel button
		* @param trigger: Trigger command/event
		* @param func: External listener function
		*/
		public function addEventToCancelButton(trigger:String, func:Function):void
		{
			cancelButton.addEventListener(trigger, func);
		}
	}
	
	
}