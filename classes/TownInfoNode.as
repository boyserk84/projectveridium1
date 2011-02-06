package classes
{
	public class TownInfoNode
	{
		private var ownerId:String;
		private var regiment:Regiment;
		
		/**
		* Constructor
		* @param ownerIdIn : Owner Id of this town
		*/
		public function TownInfoNode(ownerIdIn:String="",regIn:Regiment=null)
		{
			ownerId=ownerIdIn;
			regiment=regIn;
		}
		
		public function get OwnerId():String
		{
			return ownerId;
		}
		
		public function get Reg():Regiment
		{
			return regiment;
		}
	}
	
}