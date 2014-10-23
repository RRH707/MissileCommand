package 
{
	import Factories.RocketFactory;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	import Rockets.EnemyRocket;
	import Rockets.PlayerRocket;
	import Rockets.Rocket;
	
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class Main extends Sprite 
	{
		//Variables
		private var buildis:Vector.<MissileBase> = new Vector.<MissileBase>;
		private var Rocketz:Vector.<Rocket> = new Vector.<Rocket>;
		private var Backi:Background = new Background;
		private var waves:Vector.<Wave> = new Vector.<Wave>;
		private var exploziz:Vector.<Explosion> = new Vector.<Explosion>;
		private var currentWave:int = -1;
		private var playerController:PlayerController;
		private var rocketFactory:RocketFactory;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//adding rocket factory
			rocketFactory = new RocketFactory();
			
			//Adding playerController
			playerController = new PlayerController(stage, shootRocket, buildis);
			
			//Adding background.
			Backi.x = 0;
			Backi.y = 0;
			Backi.scaleX = stage.stageWidth;
			Backi.scaleY = stage.stageHeight;
			addChild(Backi);
			
			//Putting the buildings in an array and placing them on stage.	
			for (var i:int = 0; i < 3; i++)
			{
				var buildi:MissileBase = new MissileBase(stage);
				buildi.x = stage.stageWidth / 6 * 2 * i + 115; 
				buildi.y = 600;
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
			addWave(1000, 35);
			addWave(1000, 40);
			//function for going to the next wave
			nextWave();
			
			createExplosion(50, 50);
			
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
			var target:MissileBase = buildis[randomIndex];
			var targetPos:Vector3D = new Vector3D(target.x, target.y);
			
			
			shootRocket(RocketFactory.ENEMYROCKET, spawnPos, targetPos);
			
		}
		
		private function Update(e:Event):void
		{	
			for each (var c:MissileBase in buildis)
			{
				c.update(e);
			}
			
			//Updating movement of the rocket.
			for each (var C:Rocket in Rocketz)
			{
				C.Update(e);
			}
			
			for each (var D:Explosion in exploziz)
			{
				D.Update(e);
				if (D.done)
				{
					removeExplosion(D);
				}
				
			}
			
			//Making collision for the rockets and buildings.
			if (Rocketz.length != 0) 
			{
				for (var i:int = Rocketz.length - 1; i >= 0; i--) 
				{	
					if (i >= Rocketz.length) continue;
					
					//checking for collision between buildings and enemy rockets
					if (buildis.length != 0 && Rocketz[i] is EnemyRocket)
					{
						for (var j:int = buildis.length - 1; j >= 0; j--) 
						{
							if (buildis[j].hitTestPoint(Rocketz[i].x, Rocketz[i].y, false))
							{
								createExplosion(Rocketz[i].x, Rocketz[i].y);
								createExplosion(buildis[j].x, buildis[j].y);
								removeChild(buildis[j]);
								removeChild(Rocketz[i]);
								buildis.splice(j, 1);
								Rocketz.splice(i, 1);
							
							}
						}
					}
					
					//checking for colission with other rockets
					for (var j:int = Rocketz.length - 1; j >= 0; j--)
					{
						//checking if its not the same rocket
						if (i == j || j >= Rocketz.length) continue;
						
						//calculating distance
						var offSet:Vector3D = new Vector3D(Rocketz[i].x - Rocketz[j].x, Rocketz[i].y - Rocketz[j].y); 
						
						//checking if the rockets are in colission range
						if (offSet.length <= Rocketz[i].width / 2 + Rocketz[j].width / 2)
						{
							createExplosion(Rocketz[i].x, Rocketz[i].y);
							createExplosion(Rocketz[j].x, Rocketz[j].y);
							removeChild(Rocketz[i]);
							removeChild(Rocketz[j]);
							Rocketz.splice(i, 1);
							Rocketz.splice(j, 1);
							break;
						}
						
					}
				}
			
			}
		}
		
		//Function for spawning and shooting rockets.
		private function shootRocket(type:int, spawnPos:Vector3D, targetPos:Vector3D):void
		{
			var rocket1:Rocket = rocketFactory.createRocket(type, stage);
			rocket1.x = spawnPos.x;
			rocket1.y = spawnPos.y;
			rocket1.scaleX = 0.25;
			rocket1.scaleY = 0.25;
			rocket1.setTarget(targetPos);
			addChild(rocket1);
			Rocketz.push(rocket1);
		}
		
		private function createExplosion(x:int, y:int):void
		{
			var newExplosion:Explosion = new Explosion();
			newExplosion.x = x;
			newExplosion.y = y;
			addChild(newExplosion);
			exploziz.push(newExplosion);
		}
		
		private function removeExplosion(explosion:Explosion):void
		{	
			var index:int = exploziz.indexOf(explosion);
			if (index == -1) return;
			removeChild(explosion);
			exploziz.splice(index, 1);
		}
		
	}
	
}