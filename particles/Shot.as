package particles 
{
	import assets.Assets;
	import calculation.MovementVector;
	import flash.geom.Point;
	import flash.media.SoundChannel;
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
		
		public function Shot() 
		{	
			harmlessTime = 0.1;
			maxSpeed = 1000;
		
			addChild(Assets.instantiateMovieClip(Assets.PARTICLE, 30));					
			
			//sound
			var st:SoundTransform = new SoundTransform(0.3 + Math.random() * 0.7, 1);
			var r:Number = Math.ceil(Math.random() * 2);			
			var c:SoundChannel = Assets.playSound(Assets["SND_LASER" + r], st,0,1);
			
		}		
		
	}

}