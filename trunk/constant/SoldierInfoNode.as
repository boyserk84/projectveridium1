package constant{
	
	public class SoldierInfoNode
	{
		private var weapon:int;
		private var armor:int;
		private var skill:int;
		private var requirement:int;
		private var type:int;
		
		public function SoldierInfoNode(weaponIn:int,armorIn:int,skillIn:int,requirementIn:int,typeIn:int)
		{
			weapon=weaponIn;
			armor=armorIn;
			skill=skillIn;
			requirement=requirementIn;
			type=typeIn;
			
		}
		
		public function get Weapon():int
		{
			return weapon;
		}
		
		public function get Armor():int
		{
			return armor;
		}
		
		public function get Skill():int
		{
			return skill;
		}
		
		public function get Requirement():int
		{
			return requirement;
		}
		
		public function get Type():int
		{
			return type;
		}
		
		
	}
}