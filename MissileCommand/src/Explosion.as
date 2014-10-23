package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Explosion extends Sprite
	{	
		private var art:MovieClip;
		
		public function Explosion(s:Stage) 
		{
			art = new ExplosionArt();
			art.scaleX = art.scaleY = 1;
			art.gotoAndPlay(0);
			addChild(art);
		}
		
		
	}

}