package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Rocket extends Sprite
	{
		public var speed:Number = 10;
		private var moveStep:Vector3D;
		
		public function Rocket() 
		{
			var art:Rockit = new Rockit();
			art.rotation = 90;
			addChild(art);
		}
		
		public function Update(e:Event):void
		{
			this.x  += moveStep.x * speed;
			this.y += moveStep.y * speed;
			
			
		}
		
		public function setTarget(target:Vector3D):void
		{	
			//calculating move direction
			moveStep = new Vector3D(target.x - this.x, target.y - this.y);
			moveStep.normalize();
			//calculating rotation
			var rad:Number = Math.atan2(moveStep.y, moveStep.x);
			this.rotation = rad * 180 / Math.PI;
		}
		
	}

}