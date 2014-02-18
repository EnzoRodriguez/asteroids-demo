package environment 
{
	import assets.Assets;
	import starling.display.Image;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Star extends Image
	{
		public var speed:Number = 0;
		public function Star() 
		{
			super(Assets.instantiateTexture(Assets.SHOOTING_STAR));
		}
		
	}

}