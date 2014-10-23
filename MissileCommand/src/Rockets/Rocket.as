package Rockets {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Rocket extends Sprite
	{	
		//Adding variables
		public var speed:Number = 3;
		private var moveStep:Vector3D;
		
		//Rotation of Rocket
		public function Rocket() 
		{
			var art:Rockit = new Rockit();
			art.rotation = 90;
			addChild(art);
		}
		
		//Movement of the rockets
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