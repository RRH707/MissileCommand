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
		public var Buildi = new Building;
		public var Buildi2 = new Building;
		public var Buildi3 = new Building;
		public var Rockets:Vector.<Rocket> = new Vector.<Rocket>;
		public var Backi = new Background;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Backi.x = 0;
			Backi.y = 0;
			addChild(Backi);
			Buildi.x = 80;
			Buildi.y = 400;
			addChild(Buildi);
			Buildi2.x = 350;
			Buildi2.y = 400;
			addChild(Buildi2);
			Buildi3.x = 650;
			Buildi3.y = 400;
			addChild(Buildi3);
			
			shootRocket(new Vector3D(50, -10), new Vector3D(Buildi.x, Buildi.y));
			shootRocket(new Vector3D(50, -10), new Vector3D(Buildi2.x, Buildi2.y));
			shootRocket(new Vector3D(50, -10), new Vector3D(Buildi3.x, Buildi3.y));
			
			
			addEventListener(Event.ENTER_FRAME, Update);
			
		}
		
		private function Update(e:Event):void
		{
			for each (var C:Rocket in Rockets)
			{
				C.Update(e);
			}
		}
		
		private function shootRocket(spawnPos:Vector3D, targetPos:Vector3D):void
		{
			var rocket1:Rocket = new Rocket();
			rocket1.x = spawnPos.x;
			rocket1.y = spawnPos.y;
			rocket1.setTarget(targetPos);
			addChild(rocket1);
			Rockets.push(rocket1);
		}
		
	}
	
}