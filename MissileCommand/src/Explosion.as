package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Explosion extends Sprite
	{	
		public var done:Boolean = false;
		private var art:MovieClip;
		
		public function Explosion() 
		{
			art = new ExplosionArt();
			art.scaleX = art.scaleY = 1;
			art.gotoAndPlay(0);
			addChild(art);
		}
		
		public function Update(e:Event):void
		{
			if (art.currentFrameLabel == "Done")
			{
				done = true;
				 
			}
		}
		
		
		
		
		
	}

}