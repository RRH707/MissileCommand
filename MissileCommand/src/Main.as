package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Main extends Sprite 
	{
		public var Buildi = new Building;
		public var Buildi2 = new Building;
		public var Buildi3 = new Building;
		public var Rocki = new Rocket;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Buildi.x = 50;
			Buildi.y = 400;
			addChild(Buildi);
			Buildi2.x = 325;
			Buildi2.y = 400;
			addChild(Buildi2);
			Buildi3.x = 600;
			Buildi3.y = 400;
			addChild(Buildi3);
			Rocki.x = 100;
			Rocki.y = 50;
			addChild(Rocki);
			
		}
		
	}
	
}