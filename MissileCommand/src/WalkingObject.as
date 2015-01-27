package  
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class WalkingObject extends Sprite
	{
		private var _walkingObject:walkingObjectArt;
		
		public function WalkingObject() 
		{
			_walkingObject = new walkingObjectArt();
			addChild(_walkingObject);
		}
		
		public function update(e:Event):void
		{
			this.x += 3;
		}
	
		
	}

}