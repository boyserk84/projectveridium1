package contents{
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import classes.Town;
	import constant.GameConfig;
	import constant.SoldierType;
	
	public class TownInfoBar extends MovieClip
	{
		
		
		private var townLocation:Point;
		
		
		public function TownInfoBar()
		{
		}
		
		public function updateAttributesMilitary(town:Town,side:int):void
		{
			cancelButton.visible=false;
			cancelButton.enabled=false;
			
			townLocation=town.Location;
			nameText.text=town.Name;
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
			if(side==town.Side)
			{
				if(town.Occupier!=null)
				{
					minutemenText.text=town.Occupier.totalType(SoldierType.MINUTEMAN).toString();
					sharpshootersText.text=town.Occupier.totalType(SoldierType.SHARPSHOOTER).toString();
					cannonsText.text=town.Occupier.totalType(SoldierType.CANNON).toString();
					officersText.text=town.Occupier.totalType(SoldierType.OFFICER).toString();
					agentsText.text=town.Occupier.totalType(SoldierType.AGENT).toString();
					politiciansText.text=town.Occupier.totalType(SoldierType.POLITICIAN).toString();

				}
				else
				{
					minutemenText.text="0";
					sharpshootersText.text="0";
					cannonsText.text="0";
					officersText.text="0";
					agentsText.text="0";
					politiciansText.text="0";
				}
				ownerText.text="Ally";
			}
			else
			{
				minutemenText.text="?";
				sharpshootersText.text="?";
				cannonsText.text="?";
				officersText.text="?";
				agentsText.text="?";
				politiciansText.text="?";
				ownerText.text="Enemy";
			}
			
		}
		
		public function updateAttributesEconomic(town:Town,side:int):void
		{
			cancelButton.visible=false;
			cancelButton.enabled=false;
			townLocation=town.Location;
			nameText.text=town.Name.toString();
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
			if(side==town.Side)
			{
				workersText.text=town.Workers.toString();
				ownerText.text="Ally";
			}
			else
			{
				workersText.text="?";
				ownerText.text="Enemy";
			}
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