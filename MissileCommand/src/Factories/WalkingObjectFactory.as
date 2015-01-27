package Factories 
{
	/**
	 * ...
	 * @author Rishaad Hausil
	 */
	public class WalkingObjectFactory 
	{
		public function addWalkingObject(x:int, y:int):WalkingObject
		{
			var newWalkingObject:WalkingObject = new WalkingObject();
			newWalkingObject.x = x;
			newWalkingObject.y = y;
			return newWalkingObject;
		}
		
	}

}