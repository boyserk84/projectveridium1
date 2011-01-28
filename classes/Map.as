package classes{
	import constant.WorldConfig;
	public class Map
	{
		private var towns:Array;
		private var districts:Array;
		
		public function Map()
		{
			towns=new Array();
			districts=new Array();
		}
		
		public function addTown(townIn:Town):void
		{
			towns.push(townIn);
		}
		
		public function addDistrict(districtIn:District):void
		{
			districts.push(districtIn);
		}
		
		public function get Towns():Array
		{
			return towns;
		}
		
		public function get Districts():Array
		{
			return districts;
		}
		
		public function findTownByLocation(xIn:int=0,yIn:int=0):Town
		{
			for(var i:int=0;i<towns.length;++i)
			{

				if(((xIn>=towns[i].Location.x)&&(yIn>=towns[i].Location.y))
								&&((xIn<=towns[i].Location.x+WorldConfig.TOWN_WIDTH)&&(yIn<=towns[i].Location.y+WorldConfig.TOWN_HEIGHT)))
				{
					return towns[i];
				}
			}
			return null
		}
		
	}
	
	
}