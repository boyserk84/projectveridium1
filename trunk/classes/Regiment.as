package classes{
	
	import flash.geom.Point;
	import flash.display.MovieClip;
	import constant.WorldConfig;
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
		//The username of the owner of this regiment
		private var owner:String;
		//The side this regiment is on
		private var side:int;
		//What the regiment is intending to do what it reaches its destination
		private var intention:int;
		
		
		private var distanceTraveled:Number;
		
		private var speed:int;
		
		private var travelSpeed:Number;
		
		
		public function Regiment(nameIn:String="Unnamed",ownerIn:String="Rogue",sideIn:int=1)
		{
			myName=nameIn;
			units=new LinkedList();
			distanceTraveled=0;
			owner=ownerIn;
			side=sideIn;
			intention=WorldConfig.NONE;
		}
		
		public function addRegiment(regIn:Regiment):void
		{
			for(var i:int=0;i<regIn.Units.Length;++i)
			{
				addUnit(regIn.Units.Get(i).data);
			}
		}
		
		//Add a unit to this Platoon
		public function addUnit(unitIn:Soldier):void
		{

			for(var i:int=0;i<units.Length;++i)
			{
				if(units.Get(i).data.Type==unitIn.Type)
				{
					units.Get(i).data.Amount+=unitIn.Amount;
					return;
				}
			}

			units.Add(unitIn);
		}
		
		//Remove a unit from this Platoon
		public function removeUnit(unitIn:Soldier):void
		{
			for(var i:int=0;i<units.Length;++i)
			{
				if(units.Get(i).data.Type==unitIn.Type)
				{
					units.Get(i).data.Amount-=unitIn.Amount;
					if(units.Get(i).data.Amount<=0)
					{
						units.Remove(units.Get(i).data);
					}
					return;
				}
			}
		}
		
		
		
		//Here is the problem!
		public function incurLosses(amountIn:int):void
		{
			while(amountIn>0)
			{
				
					if(amountIn>=units.Get(0).data.Amount)
					{
						amountIn-=units.Get(0).data.Amount;
						units.Remove(units.Get(0).data);
						if(units.Length==0)
						{
							amountIn=0;
						}
					}
					else
					{
						units.Get(0).data.Amount-=amountIn;
						amountIn=0;
					}
				
				
			}
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
		
		public function get Intention():int
		{
			return intention;
		}
		public function set Intention(value:int):void
		{
			intention=value;
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
				total+=(units.Get(i).data.Amount*units.Get(i).data.AttackLevel);
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
		
		public function get Owner():String
		{
			return owner;
		}
		
		public function get Side():int
		{
			return side;
		}
		
		
	}
}