package network{
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.xml.*;
	import flash.events.*;
	
	/**
	* Network Configuration
	* This class will load information about what server and which port to connect to
	* from host.xml configuration. This way it is easier to change ip-addr of host without
	* having to recompile the application.
	*/
	public class NetConst
	{
		/* Configuration Properties and values */
		public var HOST:String="";			
		public var PORT:int;			
		
		
		/* XML Loader*/
		private var xmlLoader:URLLoader = new URLLoader(); 
		private var xmlData:XML; 
		
		private var FLAG:Boolean = false;
		
		/**
		* Constructor to load configuration XML file
		*/
		public function NetConst()
		{
			xmlLoader.load(new URLRequest("network/host.xml")); 
			xmlLoader.addEventListener(Event.COMPLETE, LoadXML); 
		}
		
		/**
		* Load Host Configuration file
		*/
		private function LoadXML(e:Event):void 
		{ 
			xmlData = new XML(e.target.data); 
			this.HOST = xmlData.host;
			this.PORT = xmlData.port;
			this.FLAG = true;
			xmlLoader.removeEventListener(Event.COMPLETE, LoadXML);
		}
		
		/*
		* Indicate whether XML config file is finished loading
		*/
		public function loadComplete():Boolean
		{
			return FLAG;
		}
		
		public function getHost():String { trace(HOST); return HOST; }
		public function getPort():int { return PORT; }
		
	}
	
	
}