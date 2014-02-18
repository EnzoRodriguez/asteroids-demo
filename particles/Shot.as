package particles 
{
	import assets.Assets;
	import calulation.MovementVector;
	import flash.geom.Point;
	import flash.media.SoundTransform;
	import gameObjects.Unit;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Shot extends Unit
	{		
		
		public function Shot(mov:MovementVector, pos:Point) 
		{
			harmlessTime = 0.1;
			maxSpeed = 1000;
			this.x = pos.x;
			this.y = pos.y;
			addChild(Assets.instantiateMovieClip(Assets.PARTICLE, 30));			
			
			movement = mov;
			var st:SoundTransform = new SoundTransform(0.3 + Math.random() * 0.7, -0.5 + Math.random());
			var r:Number = Math.ceil(Math.random() * 2);
			
			Assets.playSound(Assets["SND_LASER" + r], st);
			
		}		
		
	}

}