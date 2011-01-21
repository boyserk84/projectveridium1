package constant{
	
	public class SoldierType
	{
		public static const NONE=0;
		public static const MINUTEMAN=1;


		public static function getSoldierInfo(soldierType:int):SoldierInfoNode
		{
			var weapon:int;
			var armor:int;
			var skill:int;
			var requirement:int;
			var type:int;
			
			switch(soldierType)
			{
				case MINUTEMAN:
				{
					weapon=10;
					armor=10
					skill=10;
					requirement=SoldierType.NONE;
					type=SoldierType.MINUTEMAN;
					break;
				}
			}
			return new SoldierInfoNode(weapon,armor,skill,requirement,type);

		}
		
		
		
	}
}