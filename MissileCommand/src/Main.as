package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Main extends Sprite 
	{
		//Variables
		private var buildis:Vector.<Building> = new Vector.<Building>;
		public var Rockets:Vector.<Rocket> = new Vector.<Rocket>;
		public var Backi:Background = new Background;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
				//Adding background.
				Backi.x = 0;
				Backi.y = 0;
				Backi.scaleX = stage.stageWidth;
				Backi.scaleY = stage.stageHeight;
				addChild(Backi);
			
			//Putting the buildings in an array and placing them on stage.	
			for (var i:int = 0; i < 3; i++)
			{
				var buildi:Building = new Building();
				buildi.x = stage.stageWidth / 6 * 2 * i + 125; 
				buildi.y = 500;
				buildi.scaleX = 0.5;
				buildi.scaleY = 0.5;
				addChild(buildi);
				buildis.push(buildi);
			}
			
			//Shooting-Spawning Rockets in the direction of the buildings
			for (var i:int = buildis.length -1; i >= 0; i-- )
			{
				shootRocket(new Vector3D(0, -10), new Vector3D(buildis[i].x, buildis[i].y));
				
			}
		
				addEventListener(Event.ENTER_FRAME, Update);
			
		}
		
		
		private function Update(e:Event):void
		{	
			//Updating movement of the rocket.
			for each (var C:Rocket in Rockets)
			{
				C.Update(e);
			}
		}
		
		//Function for spawning and shooting rockets.
		private function shootRocket(spawnPos:Vector3D, targetPos:Vector3D):void
		{
			var rocket1:Rocket = new Rocket();
			rocket1.x = spawnPos.x;
			rocket1.y = spawnPos.y;
			rocket1.scaleX = 0.5;
			rocket1.scaleY = 0.5;
			rocket1.setTarget(targetPos);
			addChild(rocket1);
			Rockets.push(rocket1);
		}
		
	}
	
}