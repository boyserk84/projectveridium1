package constant{
	
	public class SoldierInfoNode
	{
		private var weapon:int;
		private var armor:int;
		private var skill:int;				
		private var requirement:int;		// Building Requirement
		private var type:int;				// Type of Soldier
		private var wood:int, money:int, food:int, iron:int;	// Required resources
		
		public function SoldierInfoNode
		(weaponIn:int,armorIn:int,skillIn:int,
						requirementIn:int,typeIn:int,
						foodIn:int,moneyIn:int,woodIn:int,ironIn:int)
		{
			weapon=weaponIn;
			armor=armorIn;
			skill=skillIn;
			requirement=requirementIn;
			type=typeIn;
			wood = woodIn;
			food = foodIn;
			money = moneyIn;
			iron = ironIn;
			
		}
		
		public function get Wood():int { return wood; }
		public function get Food():int { return food; }
		public function get Money():int { return money; }
		public function get Iron():int { return iron; }
		
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