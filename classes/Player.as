package classes {
	import constant.BuildingType;
	import constant.SoldierType;
	
	
	public class Player
	{
		//The "username" of this player
		private var username:String;
		//The actual name of this player
		private var myName:String;
		//The city belonging to this player
		private var city:City;
		
		// Game that this player is in
		private var gameid:String;
		
		//The town on the worldmap where the city is located
		private var worldCityLocation:Town;
		private var city_local:int;
		
		//The side this player is on
		private var side:int;
		
		//The amount of time that has elapsed since the game started
		//This is in seconds
		private var elapsedTime:int;
		
		//How much wood this player has on hand
		private var wood:int;
		//The current wood capacity this player's tech level allows
		private var woodCap:int;
		//The extra wood capacity this player's towns provide
		private var extraWoodCap:int;
		
		//How much iron this player has on hand
		private var iron:int;
		//The current iron capacity this player's tech level allows
		private var ironCap:int;
		//The extra iron capacity this player's towns provide
		private var extraIronCap:int;
		
		
		//How much food this player has on hand
		private var food:int;
		//The current food capacity this player's tech level allows
		private var foodCap:int;
		//The extra food capacity this player's towns provide
		private var extraFoodCap:int;
		
		//How much money this player has on hand, there is no cap on money
		private var money:int;

		
		
		//How much population this player has on hand
		private var population:int;
		//The current population capacity this player's housing provides
		private var populationCap:int;
		//The extra population capacity this player's towns provide
		private var extraPopulationCap:int;
		
		
		//How many soldiers this player has on hand
		private var soldiers:int;
		//How many workers this player has on hand
		private var workers:int;
		//How many agents this player has
		private var agents:int;
		//How many politicians this player has
		private var politicians:int;
		//How many total agents and politicians this player can have
		private var agentsCap:int;
		private var politiciansCap:int;
		
		//The events that have passed
		private var eventCount:int;
		
		//The towns you own
		private var towns:LinkedList;
		private var total_towns:int;		// Number of towns you currently have
		//These towns only give you half resources and you can't send workers
		private var halfTowns:LinkedList;
		
		//The regiment this player has
		private var regiments:LinkedList;
		
		
		
		/**
		* @param: nameIn: Name
		* @param: userNameIn: Facebook Id
		*/
		public function Player(nameIn:String="",usernameIn:String="",sideIn:int=1)
		{
			username=usernameIn;
			myName=nameIn;
			regiments=new LinkedList();
			var reg:Regiment=new Regiment("",usernameIn,sideIn)
			reg.Id="0";
			regiments.Add(reg);
			
			side=sideIn;
			total_towns = 0;
			towns = new LinkedList();
			halfTowns=new LinkedList();
			populationCap = BuildingType.POP_CAP_INIT;
			foodCap = BuildingType.FOOD_CAP_INIT;
			ironCap = BuildingType.IRON_CAP_INIT;
			woodCap = BuildingType.WOOD_CAP_INIT;
		}
		public function get GameId():String { return gameid; }
		public function set GameId(value:String) { gameid = value; }
		public function get Name():String{	return myName;}
		public function set Name(value:String):void { myName = value; } 
		public function get UserName():String { return username;}
		
		public function addCity(city:City):void	{	this.city = city;}
		
		public function get Wood():int{	return wood;}
		
		public function get WoodCap():int{	return woodCap;}
		
		public function get ExtraWoodCap():int{	return extraWoodCap;}
		
		
		public function get Iron():int{	return iron;}
		
		public function get IronCap():int{	return ironCap;}
		
		public function get ExtraIronCap():int{	return extraIronCap;}
		
		public function get Money():int{	return money;}
		
		public function getCity():City{	return city;}
		/*
		public function get MoneyCap():int
		{
			return moneyCap;
		}
		
		public function get ExtraMoneyCap():int
		{
			return extraMoneyCap;
		}
		*/
		public function get Food():int{	return food;}
		public function get FoodCap():int{	return foodCap;}
		public function get ExtraFoodCap():int{	return extraFoodCap;}
		public function get Population():int{	return population;}
		public function get PopulationCap():int{	return populationCap;}
		public function get ExtraPopulationCap():int{	return extraPopulationCap;}
		public function get Agents():int{	return agents;}
		public function get Politicians():int{	return politicians;}
		public function get AgentsCap():int{	return agentsCap;}
		public function get PoliticiansCap():int{	return politiciansCap;}
		
		//The timing functionality
		public function get ElapsedTime():int{	return elapsedTime;}
		public function set ElapsedTime(value:int):void{	elapsedTime=value;}
		public function get EventCount():int{	return eventCount;}
		public function set EventCount(value:int):void{	eventCount=value;}
		

		
		public function set Wood(value:int) { wood = value; }
		public function set WoodCap(value:int){ woodCap = value;}
		public function set Iron(value:int) { iron=value; }
		public function set IronCap(value:int) { ironCap=value;}
		public function set ExtraIronCap(value:int){ extraIronCap=value; }
		public function set Money(value:int) { money=value;}
		public function set Agents(value:int){agents=value;}
		public function set Politicians(value:int) { politicians=value;}
		/*
		public function set MoneyCap(value:int)
		{
			 moneyCap=value;
		}
		
		public function set ExtraMoneyCap(value:int)
		{
			 extraMoneyCap=value;
		}
		*/
		public function set Food(value:int) { food = value;}
		public function set FoodCap(value:int) { foodCap=value;}
		public function set ExtraFoodCap(value:int) { extraFoodCap=value; }
		public function set Population(value:int){ population=value; }
		public function set PopulationCap(value:int){ populationCap=value; }
		public function set ExtraPopulationCap(value:int){ extraPopulationCap=value;}
		public function set AgentCap(value:int){ agentsCap=value;}
		public function set PoliticiansCap(value:int) { politiciansCap=value;}
		public function set CityLocation(value:int) { city_local = value; }
		
		public function get CityLocation():int { return city_local; }
		
		
		public function get WorldCityLocation():Town
		{
			return worldCityLocation;
		}
		
		public function set WorldCityLocation(value:Town)
		{
			worldCityLocation=value;
		}
		
		
		public function get AmountSoldiers():int
		{
			return allSoldiersAmount();
		}
		
		public function get AmountSoldiersAtCity():int
		{
			//trace("Amoutn SOldddddfaerardsa "+ allSoldiersAmountAt(SoldierType.CITY_REGIMENT_INDEX) );
			return allSoldiersAmountAt(SoldierType.CITY_REGIMENT_INDEX);
		}
		
		public function changeSoldiers(value:int):void
		{
			if (AvailablePop - value >=0 && value+soldiers >= 0){
				soldiers += value;
			} 
		}
		
		public function changeWorkers(value:int):void
		{
			//trace("Available " + value+workers+AvailablePop);
			if (AvailablePop - value >= 0 && value+workers >=0)
			{
				workers +=value;
				trace("Worker after" + workers);
			}
		}
		
		public function get AmountWorkers():int 
		{ 
			workers = soldierAmount(SoldierType.WORKER);
			return workers;
		}
		
		public function get Regiments():LinkedList { return regiments;}
		
		public function get HalfTowns():LinkedList { return halfTowns;}
		
		public function addRegiment(regimentIn:Regiment):void
		{
			regiments.Add(regimentIn);
		}
		
		public function removeRegiment(regimentIn:Regiment):Regiment
		{
			return regiments.Remove(regimentIn);
			
		}
		
		/**
		* Add and reclaim town
		*/
		public function addTown(newTown:Town):void
		{
			towns.Add(newTown);
			newTown.conquer(username,side);
		}
		
		/**
		* Add a town that only earns half resources
		*/
		public function addHalfTown(newTown:Town):void
		{
			halfTowns.Add(newTown);
		}
		
		/**
		* Remove/Pop Town from the LinkedLiist
		* @return the town to be reclaimed by other who conquered it
		*/
		public function removeTown(removeTown:Town):Town
		{
			return towns.Remove(removeTown);
		}
		
		/**
		* Remove half town
		*/
		public function removeHalfTown(removeTown:Town):Town
		{
			return halfTowns.Remove(removeTown).data;
		}
		
		/**
		* Add a soldier to main regiment
		* @param: unit Soldier object
		*/
		public function addSoldierToRegiment(unit:Soldier):void
		{
			Regiments.Get(SoldierType.CITY_REGIMENT_INDEX).data.addUnit(unit);
		}
		
		/**
		* Remove a soldier from main regiment
		* @param unit Soldier to be removed
		*/
		public function removeSoldierFromRegiment(unit:Soldier):void
		{
			Regiments.Get(SoldierType.CITY_REGIMENT_INDEX).data.removeUnit(unit);
		}
		
		public function changeWood(value:int)
		{
			if (wood + value < WoodCap)
			wood += value;
			else wood = WoodCap;
		}
		
		public function changeIron(value:int)
		{
			if (iron + value < IronCap)
			iron += value;
			else iron = IronCap;
		}
		
		public function changeMoney(value:int)
		{
			money += value;
		}
		
		public function changePop(value:int)
		{
			if (population + value < PopulationCap)
			population += value;
			else population = PopulationCap;
		}
		
		public function changeFood(value:int)
		{
			if (food + value < FoodCap)
			food += value;
			else food = FoodCap;
		}
		
		public function changeExtraFoodCap(value:int)
		{
			if (extraFoodCap + value >=0) extraFoodCap += value;
		}
		
		public function changeExtraWoodCap(value:int)
		{ 
			if (extraWoodCap + value >=0) extraWoodCap += value;
		}
		
		public function changeExtraIronCap(value:int)
		{ 
			if (extraIronCap + value >=0) extraIronCap += value;
		}
		
		public function changeExtraPop(value:int)
		{ 
			if (extraPopulationCap + value >=0) extraPopulationCap += value;
		}
		
		public function get Side():int
		{
			return side;
		}
		
		public function set Side(value:int):void
		{
			side = value;
		}
		
		/**
		* return available population (Commoners)
		*/
		public function get AvailablePop():int
		{
			return Population - (AmountSoldiers + AmountWorkers);
		}
		
		/**
		* return available workers in the city ready for allocate.
		*/
		public function get AvailableWorkers():int
		{
			// Basically, amount of workers in Regiement#0
			return regiments.Get(SoldierType.CITY_REGIMENT_INDEX).data.totalType(SoldierType.WORKER);
		}
		
		/**
		* Update maximum capacity of all resources
		*/
		public function updateResourcesCapacity()
		{
			updateAllTownCapacity();
			FoodCap = BuildingType.FOOD_CAP_INIT + city.ExtraStorage + extraFoodCap;
			WoodCap = BuildingType.WOOD_CAP_INIT + city.ExtraStorage + extraWoodCap; 
			IronCap = BuildingType.IRON_CAP_INIT + city.ExtraStorage + extraIronCap;
			populationCap = BuildingType.POP_CAP_INIT + city.ExtraPop + extraPopulationCap;
		}
		
		/*
		* Returns the total amount of a certain type of unit this player has
		*/
		public function soldierAmount(type:int):int
		{
			var total:int=0;
			for(var i:int=0;i<regiments.Length;++i)
			{
				total+=regiments.Get(i).data.totalType(type);
			}
			return total;
		}
		
		/**
		* Return all soldiers at a particular regiment
		* @param city_index: Regiment index
		*/
		public function allSoldiersAmountAt(city_index:int):int
		{
			return regiments.Get(city_index).data.totalType(SoldierType.MINUTEMAN)+
			regiments.Get(city_index).data.totalType(SoldierType.SHARPSHOOTER)+
			regiments.Get(city_index).data.totalType(SoldierType.OFFICER)+
			regiments.Get(city_index).data.totalType(SoldierType.CALVARY)+
			regiments.Get(city_index).data.totalType(SoldierType.CANNON)+
			regiments.Get(city_index).data.totalType(SoldierType.SCOUT)+
			regiments.Get(city_index).data.totalType(SoldierType.AGENT)+
			regiments.Get(city_index).data.totalType(SoldierType.POLITICIAN);
		}
		
		/**
		* Return all workers at a particular regiment
		* @param : reg_index: Regiment index
		*/
		public function allWokersAmountAt(reg_index:int):int
		{
		trace("all workers amoutn at " + regiments.Get(reg_index).data.totalType(SoldierType.WORKER));
			return regiments.Get(reg_index).data.totalType(SoldierType.WORKER);
		}
		
		/**
		* Return the toal amount of soldiers across the entire map
		*/
		public function allSoldiersAmount():int
		{
			var total:int=0;
			for(var i:int=0;i<regiments.Length;++i)
			{
				total+=
				regiments.Get(i).data.totalType(SoldierType.MINUTEMAN)+
				regiments.Get(i).data.totalType(SoldierType.SHARPSHOOTER)+
				regiments.Get(i).data.totalType(SoldierType.OFFICER)+
				regiments.Get(i).data.totalType(SoldierType.CALVARY)+
				regiments.Get(i).data.totalType(SoldierType.CANNON)+
				regiments.Get(i).data.totalType(SoldierType.SCOUT)+
				regiments.Get(i).data.totalType(SoldierType.AGENT)+
				regiments.Get(i).data.totalType(SoldierType.POLITICIAN)
				;
			}
			return total;
		}
		
		/**
		* Update all towns' capacity
		*/
		private function updateAllTownCapacity():void
		{
			var w_cap:int, i_cap:int, f_cap:int, p_cap:int;
			for (var i:int = 0; i < towns.Length ;++i)
			{
				w_cap += towns.Get(i).data.ExtraWoodCap;
				i_cap += towns.Get(i).data.ExtraIronCap;
				f_cap += towns.Get(i).data.ExtraFoodCap;
				p_cap += towns.Get(i).data.ExtraPopulationCap;
			}
			extraWoodCap = w_cap;
			extraIronCap = i_cap;
			extraFoodCap = f_cap;
			extraPopulationCap = p_cap;
		}
		
		/**
		* Update all towns' resources
		*/
		public function updateAllTownResources():void
		{
			var w:int,iron:int,f:int,p:int, m:int;
			for (var i:int = 0; i < towns.Length ;++i)
			{
				w += towns.Get(i).data.Wood;
				iron += towns.Get(i).data.Iron;
				f += towns.Get(i).data.Food;
				p += towns.Get(i).data.Population;
				m += towns.Get(i).data.Money;
			}
			
			for (var i:int = 0; i < halfTowns.Length ;++i)
			{
				w += halfTowns.Get(i).data.Wood;
				iron += halfTowns.Get(i).data.Iron;
				f += halfTowns.Get(i).data.Food;
				p += halfTowns.Get(i).data.Population;
				m += halfTowns.Get(i).data.Money;
			}
			changeWood(w);
			changeIron(iron);
			changeFood(f);
			changePop(p);
			changeMoney(m);
		}
		


	}
}