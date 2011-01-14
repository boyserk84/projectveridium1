package classes{
	
	import flash.geom.Point;
	import flash.display.MovieClip;
	public class Regiment extends MovieClip
	{
		//The units in this platoon as represented by the "Soldier" class
		private var units:LinkedList;
		//The name of this Regiment
		private var myName:String;
		//The current Location of this Regiment
		private var myLocation:Point;
		//The current destination of this Regiment
		private var destination:Point;
		
		private var distanceTraveled:Number;
		
		private var speed:int;
		
		private var travelSpeed:Number;
		
		
		public function Regiment(nameIn:String="Unnamed")
		{
			myName=nameIn;
			units=new LinkedList();
			distanceTraveled=0;
		}
		
		//Add a unit to this Platoon
		public function addUnit(unitIn:Soldier):void
		{

			for(var i:int=0;i<units.Length;++i)
			{
				if(compareWeaponLevel(units.Get(i).data,unitIn)&&compareArmorLevel(units.Get(i).data,unitIn)&&compareSkillLevel(units.Get(i).data,unitIn))
				{
					units.Get(i).data.Amount+=unitIn.Amount;
					return;
				}
			}

			units.Add(unitIn);
		}
		
		
		/**
		* Helper functions to compare the Weapon, Armor, and Skill levels of two soldiers
		**/
		private function compareWeaponLevel(unit1:Soldier,unit2:Soldier):Boolean
		{
			if(unit1.WeaponLevel==unit2.WeaponLevel)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		
		private function compareArmorLevel(unit1:Soldier,unit2:Soldier):Boolean
		{
			if(unit1.ArmorLevel==unit2.ArmorLevel)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		private function compareSkillLevel(unit1:Soldier,unit2:Soldier):Boolean
		{
			if(unit1.SkillLevel==unit2.SkillLevel)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		//Remove a unit from this Platoon
		public function removeUnit(unitIn:Soldier):void
		{
			for(var i:int=0;i<units.Length;++i)
			{
				if(compareWeaponLevel(units.Get(i).data,unitIn)&&compareArmorLevel(units.Get(i).data,unitIn)&&compareSkillLevel(units.Get(i).data,unitIn))
				{
					units.Get(i).data.Amount-=unitIn.Amount;
					if(units.Get(i).data.Amount<=0)
					{
						units.Remove(units.Get(i).data);
					}
					return;
				}
			}
			units.Remove(unitIn);
		}
		
		public function changeDistance(changeIn:Number):void
		{
			distanceTraveled+=changeIn;
		}
		
		public function resetDistance():void
		{
			distanceTraveled=0;
		}
		
		public function get DistanceTraveled():Number
		{
			return distanceTraveled;
		}
		
		public function get Speed():int
		{
			return speed;
		}
		
		public function set Speed(value:int):void
		{
			speed=value;
		}
		
		public function get TravelSpeed():Number
		{
			return travelSpeed;
		}
		
		public function set TravelSpeed(value:Number):void
		{
			travelSpeed=value;
		}
		
		
		
		//Get the list for iteration
		public function get Units():LinkedList
		{
			return units;
		}
		
		public function get TotalAmount():int
		{
			var total:int=0;
			for(var i:int=0;i<units.Length;++i)
			{
				total+=units.Get(i).data.Amount;
			}
			return total;
		}
		
		public function get TotalAttack():int
		{
			var total:int=0;
			for(var i:int=0;i<units.Length;++i)
			{
				total+=(units.Get(i).data.Amount*units.Get(i).data.WeaponLevel);
			}
			return total;
		}
		
		public function get TotalDefense():int
		{
			var total:int=0;
			for(var i:int=0;i<units.Length;++i)
			{
				total+=(units.Get(i).data.Amount*units.Get(i).data.DefenseLevel);
			}
			return total;
		}
		
		
		public function get TotalSkill():int
		{
			var total:int=0;
			for(var i:int=0;i<units.Length;++i)
			{
				total+=(units.Get(i).data.Amount*units.Get(i).data.SkillLevel);
			}
			return total;
		}
		
		public function get Name():String
		{
			return myName;
		}
		
		public function set Name(value:String):void
		{
			myName=value;
		}
		
		public function get Location():Point
		{
			return myLocation;
		}
		
		public function set Location(value:Point):void
		{
			myLocation=value;
		}
		
		public function get Destination():Point
		{
			return destination;
		}
		
		public function set Destination(value:Point):void
		{
			destination=value;
		}
		
		
	}
}