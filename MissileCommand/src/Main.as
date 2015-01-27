package 
{
	import adobe.utils.ProductManager;
	import Factories.RocketFactory;
	import Factories.WalkingObjectFactory;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	import flash.text.TextField;
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
		private var buildis:Vector.<MissileBase>;
		private var Rocketz:Vector.<Rocket>;
		private var Backi:Background;
		private var waves:Vector.<Wave>;
		private var exploziz:Vector.<Explosion>;
		private var currentWave:int = -1;
		private var playerController:PlayerController;
		private var rocketFactory:RocketFactory;
		private var _menu:Menu;
		private var _gameSound:gameSound;
		private var boomSound:explosionSound;
		private var _walkingObject:WalkingObject;
		private var _spawnTimer:Timer;
		private var _walkingObjFactory:WalkingObjectFactory;
		private var _walkingObjects:Vector.<WalkingObject>;
		private var _score:int;
		private var _scoreText:TextField;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			createMenu(stage);
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
			if (_walkingObjects.length != 0)
			{
				for (var i = _walkingObjects.length - 1; i >= 0; i--)
				{
					_walkingObjects[i].update(e);
					if (_walkingObjects[i].x > stage.stageWidth)
					{
						removeChild(_walkingObjects[i]);
						_walkingObjects.splice(i, 1);
					}
				}
			}
			
			
			if (buildis.length <= 0)
			{
				removeGame();
				createMenu(stage);
			}
			
			
			//Updating the animation of the missileBase.
			for each (var c:MissileBase in buildis)
			{
				c.update(e);
			}
			
			//Updating movement of the rocket.
			for each (var C:Rocket in Rocketz)
			{
				C.Update(e);
			}
			
			//Updating the explosions so they get removed when they are done.
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
							_score += 10;
							break;
						}
						
					}
				}
			
			}
			
			_scoreText.text = "Score : " + _score;
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
		
		
		//creating explosions.
		private function createExplosion(x:int, y:int):void
		{
			
			var newExplosion:Explosion = new Explosion();
			boomSound.play(0, 1);
			newExplosion.x = x;
			newExplosion.y = y;
			addChild(newExplosion);
			exploziz.push(newExplosion);
		}
		
		//removing the explosions.
		private function removeExplosion(explosion:Explosion):void
		{	
			var index:int = exploziz.indexOf(explosion);
			if (index == -1) return;
			removeChild(explosion);
			exploziz.splice(index, 1);
		}
		
		private function createGame(e:Event):void
		{
			buildis = new Vector.<MissileBase>;
			Rocketz = new Vector.<Rocket>;
			Backi = new Background;
			waves = new Vector.<Wave>;
			exploziz = new Vector.<Explosion>;
			currentWave = -1;
			boomSound = new explosionSound();
			_spawnTimer = new Timer(4000, 0);
			_walkingObjFactory = new WalkingObjectFactory();
			_walkingObjects = new Vector.<WalkingObject>();
			_scoreText = new TextField();
			
			_scoreText.text = "Score : " + _score;
			_scoreText.x = 700;
			_scoreText.y = 36;
			_scoreText.textColor = 0xFFFFFF;
			
			_spawnTimer.addEventListener(TimerEvent.TIMER, spawnObject);
			_spawnTimer.start();
			removeChild(_menu);
			_gameSound = new gameSound();
			_gameSound.play(0, 999);
			
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
			addWave(1000, 45);
			addWave(1000, 50);
			addWave(1000, 60);
			addWave(1000, 70);
			addWave(1000, 80);
			addWave(1000, 90);
			addWave(1000, 100);
			//function for going to the next wave
			nextWave();
			
			addChild(_scoreText);
		}
		
		private function spawnObject(e:TimerEvent):void 
		{
			var newObj:WalkingObject = _walkingObjFactory.addWalkingObject( -100, 560);
			addChild(newObj);
			_walkingObjects.push(newObj);
		}
		
		private function createMenu(stage):void
		{
			_menu = new Menu(stage);
			addChild(_menu);
			_menu.addEventListener("startGame", createGame);
		}
		
		private function removeGame():void
		{
			rocketFactory = null;
			playerController.removeEventListenur();
			playerController = null;
			
			for (var i:int = buildis.length - 1; i >= 0; i--)
			{
				removeChild(buildis[i]);
				buildis.splice(i, 1);
			}
			
			for (var i:int = exploziz.length - 1; i >= 0; i--)
			{
				removeChild(exploziz[i]);
				exploziz.splice(i, 1);
			}
			
			for (var i:int = Rocketz.length - 1; i >= 0; i--)
			{
				removeChild(Rocketz[i]);
				Rocketz.splice(i, 1);
			}
			
			for (var i:int = waves.length - 1; i >= 0; i--)
			{
				waves[i].removeEventListener(Wave.Shoot, onWaveShoot);
				waves[i].removeEventListener(Wave.Done, onWaveDone);
				waves.splice(i, 1);
			}
			
			for (var i:int = _walkingObjects.length - 1; i >= 0; i--)
			{
				removeChild(_walkingObjects[i]);
				_walkingObjects.splice(i, 1);
			}
			
			_spawnTimer.removeEventListener(TimerEvent.TIMER, spawnObject);
			
			buildis = null;
			
			removeEventListener(Event.ENTER_FRAME, Update);
			
			removeChild(Backi);
			Backi = null;
			_walkingObjFactory = null;
			_walkingObjects = null;
		}
		
	}
	
}