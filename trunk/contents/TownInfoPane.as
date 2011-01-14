package contents{
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class TownInfoPane extends MovieClip
	{
		public static const WOOD_X=45;
		public static const WOOD_Y=42;
		
		public static const IRON_X=45;
		public static const IRON_Y=60;
		
		public static const MONEY_X=151;
		public static const MONEY_Y=40;
		
		public static const POPULATION_X=151;
		public static const POPULATION_Y=61;
		
		private var townLocation:Point;
		
		
		public function TownInfoPane()
		{
		}
		
		public function setAttributes(woodIn:int,ironIn:int,moneyIn:int,populationIn:int,nameIn:String,locationIn:Point)
		{
			this.woodText.text=woodIn.toString();
			this.ironText.text=ironIn.toString();
			this.moneyText.text=moneyIn.toString();
			this.populationText.text=populationIn.toString();
			this.nameText.text=nameIn;
			this.townLocation=locationIn;
		}
		
		public function get Location():Point
		{
			return townLocation;
		}
		
		
		
		
	}
}