package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author ...
	 */
	public class Wave extends Sprite 
	{	
		public static const Shoot:String = "shoot";
		public static const Done:String = "done";
		
		private var _waveTimer:Timer;
		private var _shootInterval:int;
		private var _rocketsAmount:int;
		private var _rocketCount:int = 0;
		
		//making the shoot interval and amount of rockets for the wave
		public function Wave(shootInterval:int, amountRockets:int) 
		{
			_shootInterval = shootInterval;
			_rocketsAmount = amountRockets;
			_waveTimer = new Timer(shootInterval, 0);
			_waveTimer.addEventListener(TimerEvent.TIMER, waveSpawn); 
		}
		
		//adding wave timer + rocket count
		private function waveSpawn(e:TimerEvent):void
		{
			dispatchEvent(new Event(Wave.Shoot));
			_rocketCount++;
			if (_rocketCount == _rocketsAmount)
			{
				_waveTimer.stop();
				dispatchEvent(new Event(Wave.Done));
			}
		}
		
		//starting the first wave
		public function start():void
		{
			_waveTimer.start();
		}
		
		
	}

}