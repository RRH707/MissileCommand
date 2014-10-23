package Factories 
{
	import flash.display.Stage;
	import Rockets.EnemyRocket;
	import Rockets.PlayerRocket;
	import Rockets.Rocket;
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class RocketFactory 
	{	
		public static const PLAYERROCKET:int = 0;
		public static const ENEMYROCKET:int = 1;
		
		public function createRocket(type:int, stage:Stage):Rocket
		{
			switch (type) 
			{
				case PLAYERROCKET:
					return new PlayerRocket();
				break;
				case ENEMYROCKET:
					return new EnemyRocket();
				break;
			}
			return null;
		}
		
		
	}

}