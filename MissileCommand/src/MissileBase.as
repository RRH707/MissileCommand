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
	public class MissileBase extends Sprite 
	{
		private var art:MovieClip;
		private var _stage:Stage;
		private var _openRoof:Boolean = false;
		
		public function MissileBase(s:Stage) 
		{
			_stage = s;
			art = new Building();
			art.scaleX = art.scaleY = 0.5;
			art.gotoAndStop("Closed");
			addChild(art);
		}
		
		public function update(e:Event):void
		{
			if (_openRoof && art.currentFrameLabel == "Closed")
			{
				art.gotoAndStop("Closed");
				_openRoof = false;
			}
		}
		
		public function openRoof():void
		{
			if (_openRoof) return;
			_openRoof = true;
			art.gotoAndPlay("Open");
		}
		
	}

}