package assets
{
	import flash.filesystem.File;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Assets 
	{		
		public static const SHIP_IDLE:String = "shipidle";
		public static const SHIP_MOVE:String = "shipmove";
		public static const ROCK1:String = "rock1";
		public static const ROCK2:String = "rock2";
		public static const SPACE_LAYER_1:String = "spaceLayer1";
		public static const SPACE_LAYER_2:String = "spaceLayer2";
		public static const SHOOTING_STAR:String = "shootingStar";
		public static const PARTICLE:String = "particle";
		public static const EXPLOSION:String = "explosion";
		
		public static const SND_LASER1:String = "laser1";
		public static const SND_LASER2:String = "laser2";
		public static const SND_EXPLODE1:String = "explode1";
		public static const SND_EXPLODE2:String = "explode2";
		public static const SND_LOOP:String = "loop";

		
		public static const ASSETS_LOADED:String = "loaded";
		public static var dispatcher:EventDispatcher = new EventDispatcher();
		private static var assetsManager:AssetManager = new AssetManager();	
	
		
		public static function loadAssets():void 
		{			
			assetsManager.enqueue(EmbeddedAssets);		
			var directory:File = File.applicationDirectory;
			assetsManager.enqueue(directory.resolvePath("assets"));			
			assetsManager.loadQueue(
				function (ratio:Number):void
				{					
					if (ratio == 1)
					{						
						dispatcher.dispatchEvent(new Event(ASSETS_LOADED));
					}
				}
			);			
		}
		public static function instantiateMovieClip(name:String, fps:int = 30):MovieClip
		{
			var clip:MovieClip = new MovieClip(assetsManager.getTextures(name), fps);
			Starling.juggler.add(clip);
			return clip;
		}
		public static function instantiateImage(name:String):Image
		{
			return new Image(assetsManager.getTexture(name));
		}
		public static function instantiateTexture(name:String):Texture
		{
			return assetsManager.getTexture(name);		
		}
		public static function playSound(name:String, st:SoundTransform, sTime:int = 0, loops = 1):SoundChannel
		{			
			return assetsManager.playSound(name, sTime, loops, st);		
		}
				
	}

}