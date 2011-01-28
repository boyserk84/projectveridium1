package contents{
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import classes.Town;
	import constant.GameConfig;
	
	public class TownInfoBar extends MovieClip
	{
		
		
		private var townLocation:Point;
		
		
		public function TownInfoBar()
		{
		}
		
		public function updateAttributesMilitary(town:Town):void
		{
			
			townLocation=town.Location;
			nameText.text=town.Name;
			ownerText.text=town.Owner;
			switch(town.Side)
			{
				case GameConfig.BRITISH:
				{
					sideText.text="British";
					break;
				}
				case GameConfig.AMERICAN:
				{
					sideText.text="American";
					break;
				}
				default:
				{
					sideText.text="Renegade";
					break;
				}
			}
			if(town.Occupier!=null)
			{
				minutemenText.text=town.Occupier.TotalAmount.toString();
			}
			else
			{
				minutemenText.text="0";
			}
			
		}
		
		public function updateAttributesEconomic(town:Town):void
		{
			townLocation=town.Location;
			nameText.text=town.Name.toString();
			ownerText.text=town.Owner.toString();
			switch(town.Side)
			{
				case GameConfig.BRITISH:
				{
					sideText.text="British";
					break;
				}
				case GameConfig.AMERICAN:
				{
					sideText.text="American";
					break;
				}
				default:
				{
					sideText.text="Renegade";
					break;
				}
			}
			workersText.text=town.Workers.toString();
			ironText.text=town.Iron.toString();
			woodText.text=town.Wood.toString();
			moneyText.text=town.Money.toString();
			populationText.text=town.Population.toString();

		}
		
		public function get Location():Point
		{
			return townLocation;
		}
		
		
		
		
	}
}