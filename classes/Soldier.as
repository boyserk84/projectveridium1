package classes {
	
	public class Soldier
	{
		//How many individual soldiers this unit represents
		private var amount:int;
		//The level of upgrade on this units weapons
		//Weapons will determine attack strength of this particular unit
		private var weaponLevel:int;
		//The level of upgrade on this units armor
		//Armor will determine defense of this particular unit
		private var armorLevel:int;
		//The level of upgrade on this units training
		//Training will determine the movement speed of this particular unit as well as a small modification to attack and defense
		private var skillLevel:int;
		
		public function Soldier(amountIn:int=0,weaponIn:int=1,armorIn:int=1,skillIn:int=1)
		{
			amount=amountIn;
			weaponLevel=weaponIn;
			armorLevel=armorIn;
			skillLevel=skillIn;
		}
		
		public function get ArmorLevel():int
		{
			return armorLevel;
		}
		
		public function get WeaponLevel():int
		{
			return weaponLevel;
		}
		
		public function get SkillLevel():int
		{
			return skillLevel;
		}
		
		public function get Amount():int
		{
			return amount;
		}

		public function set Amount(value:int):void
		{
			amount=value;
		}

		public function modifyArmorLevel(armorIn:int=0):void
		{
			armorLevel+=armorIn;
		}
		
		public function modifyWeaponLevel(weaponIn:int=0):void
		{
			weaponLevel+=weaponIn;
		}
		
		public function modifySkillLevel(skillIn:int=0):void
		{
			skillLevel+=skillIn;
		}
		
		public function modifyAmount(amountIn:int=0):void
		{
			amount+=amountIn;
		}
		
		
	}
}