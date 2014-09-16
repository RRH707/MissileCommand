package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Main extends Sprite 
	{
		//Variables
		private var buildis:Vector.<Building> = new Vector.<Building>;
		public var Rockets:Vector.<Rocket> = new Vector.<Rocket>;
		public var Backi:Background = new Background;
		public var waves:Vector.<Wave> = new Vector.<Wave>;
		public var currentWave:int = -1;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			//Adding background.
			Backi.x = 0;
			Backi.y = 0;
			Backi.scaleX = stage.stageWidth;
			Backi.scaleY = stage.stageHeight;
			addChild(Backi);
			
			//Putting the buildings in an array and placing them on stage.	
			for (var i:int = 0; i < 3; i++)
			{
				var buildi:Building = new Building();
				buildi.x = stage.stageWidth / 6 * 2 * i + 125; 
				buildi.y = 500;
				buildi.scaleX = 0.5;
				buildi.scaleY = 0.5;
				addChild(buildi);
				buildis.push(buildi);
				
			}
			
			addEventListener(Event.ENTER_FRAME, Update);
			
			//making waves. interval + amount of rockets
			addWave(1000, 10);
			addWave(1000, 15);
			addWave(1000, 20);
			addWave(1000, 25);
			addWave(1000, 30);
			//function for going to the next wave
			nextWave();
		}
		
		//adding waves and variables
		private function addWave(shootInterval:int, amount:int):void
		{
			var newWave:Wave = new Wave(shootInterval, amount);
			newWave.addEventListener(Wave.Shoot, onWaveShoot);
			newWave.addEventListener(Wave.Done, onWaveDone);
			waves.push(newWave);
		}
		
		//spawning rockets at every wave
		private function onWaveShoot(e:Event):void
		{
			SpawnEnemyRockey();
		}
		
		//calling the function nextwave
		private function onWaveDone(e:Event):void
		{
			trace("Wave is done: " + currentWave);
			nextWave();
		}
		
		//adding waves and returning function
		private function nextWave():void
		{
			if (currentWave == waves.length - 1) return; 
			currentWave++;
			waves[currentWave].start();
		}
		
		//spawning rockets towards the buildings
		private function SpawnEnemyRockey():void
		{
			if (buildis.length == 0) return;
			
			
			var spawnPos:Vector3D = new Vector3D(Math.random() * stage.stageWidth, -10);
			
			var randomIndex:int = Math.random() * buildis.length;
			var target:Building = buildis[randomIndex];
			var targetPos:Vector3D = new Vector3D(target.x, target.y);
			
			
			shootRocket(spawnPos, targetPos);
			
		}
		
		private function Update(e:Event):void
		{	
			
			//Updating movement of the rocket.
			for each (var C:Rocket in Rockets)
			{
				C.Update(e);
			}
			
			//Making collision for the rockets and buildings.
			if (Rockets.length != 0) 
			{
				for (var i:int = Rockets.length - 1; i >= 0; i--) 
				{
					if (buildis.length != 0)
					{
						for (var j:int = buildis.length - 1; j >= 0; j--) 
						{
							if (buildis[j].hitTestPoint(Rockets[i].x, Rockets[i].y, false))
							{
								removeChild(buildis[j]);
								removeChild(Rockets[i]);
								buildis.splice(j, 1);
								Rockets.splice(i, 1);
							}
							
						}
					}
				}
			
				
			}
		}
		
		//Function for spawning and shooting rockets.
		private function shootRocket(spawnPos:Vector3D, targetPos:Vector3D):void
		{
			var rocket1:Rocket = new Rocket();
			rocket1.x = spawnPos.x;
			rocket1.y = spawnPos.y;
			rocket1.scaleX = 0.5;
			rocket1.scaleY = 0.5;
			rocket1.setTarget(targetPos);
			addChild(rocket1);
			Rockets.push(rocket1);
		}
		
	}
	
}