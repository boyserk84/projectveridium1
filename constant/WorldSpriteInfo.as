package constant{
	import flash.display.MovieClip;
	public class WorldSpriteInfo
	{

		
		public static function getSprite(worldType:int):MovieClip
		{
			switch(worldType)
			{
				case WorldType.MAINE:
					return new Maine();
				break;
				
				case WorldType.MARYLAND:
					return new Maryland();
				break;
				
				case WorldType.MASSACHUSETTS:
					return new Massachusettes();
				break;
				
				case WorldType.GEORGIA:
					return new Georgia();
				break;
				
				case WorldType.NEWHAMPSHIRE:
					return new NewHampshire();
				break;
				
				case WorldType.NEWYORK:
					return new NewYork();
				break;
				
				case WorldType.NORTHCAROLINA:
					return new NorthCarolina();
				break;
				
				case WorldType.PENNSYLVANIA:
					return new Pennsylvania();
				break;
				
				case WorldType.RHODEISLAND:
					return new RhodeIsland();
				break;
				
				case WorldType.SOUTHCAROLINA:
					return new SouthCarolina();
				break;
				
				case WorldType.VIRGINIA:
					return new Virginia();
				break;
				
				case WorldType.REGIMENT:
					//return new RegimentView();
				break;
			}
			return null;
		}
	}
}