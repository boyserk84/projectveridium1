package classes{
	import constant.WorldConfig;
	public class Map
	{
		private var towns:Array;
		private var districts:Array;
		private var graphNodes:Array;
		private var BFSqueue:Queue;
		
		public function Map()
		{
			towns=new Array();
			districts=new Array();
			graphNodes=new Array();
		}
		
		public function addTown(townIn:Town):void
		{
			towns.push(townIn);
			graphNodes.push(townIn.Node);
		}
		
		//Sets all of the nodes to not visited
		public function resetGraph():void
		{
			for(var i:int =0;i<graphNodes.length;++i)
			{
				graphNodes[i].Visited=false;
			}
		}
		
		
		
		public function addDistrict(districtIn:District):void
		{
			districts.push(districtIn);
		}
		
		public function get Towns():Array
		{
			return towns;
		}
		
		public function get Districts():Array
		{
			return districts;
		}
		
		public function findTownByLocation(xIn:int=0,yIn:int=0):Town
		{
			for(var i:int=0;i<towns.length;++i)
			{

				if(((xIn>=towns[i].Location.x)&&(yIn>=towns[i].Location.y))
								&&((xIn<=towns[i].Location.x+WorldConfig.TOWN_WIDTH)&&(yIn<=towns[i].Location.y+WorldConfig.TOWN_HEIGHT)))
				{
					return towns[i];
				}
			}
			return null
		}
		
		public function getTownByIndex(index:int):Town
		{
			if(index<towns.length&&index>=0)
			{
				return towns[index];
			}
			else
			{
				return null;
			}
		}
		
		//Finds all of the nodes that can reach the selected town
		//Will add functionality to have multiple lists of steps to get to the town
		public function findValidNeighbors(nodeIn:GraphNode,playerIn:Player):Array
		{
			resetGraph();
			BFSqueue=new Queue();
			nodeIn.Visited=true;
			for(var i:int=0;i<nodeIn.Neighbors.length;++i)
			{
				if(!(nodeIn.Neighbors[i].Visited))
				{
					BFSqueue.Enqueue(nodeIn.Neighbors[i]);
				}
				
			}
			return BFS(playerIn);
		}
		
		
		
		private function BFS(playerIn:Player):Array
		{
			var nodeIn:GraphNode;
			var validNeighbors:Array=new Array();
			while(BFSqueue.Length>0)
			{
				nodeIn=BFSqueue.Dequeue();
				nodeIn.Visited=true;
				//If they are not on the same side, stop immediatly
				if(nodeIn.MyTown.Side!=playerIn.Side)
				{
					continue;
				}
				//This means this town is on the players side
				else
				{
					//This means they own this town so add it to the list
					if(nodeIn.MyTown.Owner==playerIn.Name)
					{
						validNeighbors.push(nodeIn.MyTown);
					}
					//Add it to the list that can be stepped through
					else
					{
						for(var i:int=0;i<nodeIn.Neighbors.length;++i)
						{
							if(!(nodeIn.Neighbors[i].Visited))
							{
								BFSqueue.Enqueue(nodeIn.Neighbors[i]);
							}
							
						}
					}
				}
			}//end of while
			return validNeighbors;
			
		}
		
		
	}
	
	
}