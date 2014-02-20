package gameObjects 
{
	import assets.Assets;
	import calculation.MovementVector;
	import flash.geom.Point;
	import starling.display.MovieClip;
	import starling.events.Event
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Asteroid extends Unit
	{
		private var animation:MovieClip;
		public function Asteroid() 
		{
			harmlessTime = 2;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			maxSpeed = 200;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);			
			animation = Assets.instantiateMovieClip(Assets.ROCK1);
			addChild(animation);
			animation.play();
		}
		public override function update(passedTime:Number):void
		{
			
			super.update(passedTime);
			
			
		}
	}

}