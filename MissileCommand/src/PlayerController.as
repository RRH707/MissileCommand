package  {
	import Factories.RocketFactory;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.ui.MouseCursor;
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	
	public class PlayerController
	{
		private var _shootFunction:Function;
		private var _stage:Stage;
		private var _buildis:Vector.<MissileBase> = new Vector.<MissileBase>;
		
		
		public function PlayerController(stage:Stage, shootFunction:Function, buildingsArray:Vector.<MissileBase>)
		{	
			_shootFunction = shootFunction;
			_stage = stage;
			_buildis = buildingsArray;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
		}
		
		//function for shooting and choosing the closest building from where to shoot.
		public function onMouseDown(e:MouseEvent):void
		{	
			var mousePos:Vector3D = new Vector3D(e.stageX, e.stageY);
			var closestDist:Number = -1;
			var closestIndx:int = -1;
			
			for (var i:int = 0; i < _buildis.length; i++)
			{	
				var position:Vector3D = new Vector3D(_buildis[i].x, _buildis[i].y);
				var distance:Number = Vector3D.distance(mousePos, position);
				
				if (closestDist < 0 || distance < closestDist )
				{
					closestDist = distance; 
					closestIndx = i;
				}
			}
			
			var closestBuildi:MissileBase = _buildis[closestIndx];
			closestBuildi.openRoof();
			var spawnPos:Vector3D = new Vector3D(closestBuildi.x, closestBuildi.y);
			var targetPos:Vector3D = new Vector3D(e.stageX, e.stageY);
			
			_shootFunction(RocketFactory.PLAYERROCKET, spawnPos, targetPos);
 
		}
		
		
		
	}

}