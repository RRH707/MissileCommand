package  
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.StageDisplayState;
	
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Menu extends Sprite
	{
		private var _menuScreen:menuArt;
		private var _playButton:playButtonArt;
		private var _fullScreenButton:fullScreenButtonArt;
		private var _stage:Stage;
		
		public function Menu(s:Stage) 
		{
			_stage = s;
			
			_stage.addEventListener(MouseEvent.CLICK, onClick);
			
			_menuScreen = new menuArt();
			_playButton = new playButtonArt();
			_fullScreenButton = new fullScreenButtonArt();
			
			_playButton.x =  s.stageWidth / 2;
			_playButton.y = s.stageHeight / 2;
			_fullScreenButton.x = _playButton.x;
			_fullScreenButton.y = _playButton.y + 50;
			
			
			addChild(_menuScreen);
			addChild(_playButton);
			addChild(_fullScreenButton);
		}
		
		private function onClick(e:MouseEvent):void
		{
			if (e.target == _playButton)
			{
				dispatchEvent(new Event("startGame"));
			}
			
			if (e.target == _fullScreenButton)
			{
				_stage.displayState = StageDisplayState.FULL_SCREEN;
			}
		
		}
		
	}

}