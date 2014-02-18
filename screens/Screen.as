package screens 
{
	import starling.display.Sprite;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Screen extends Sprite
	{
		
		public function Screen() 
		{
			
		}
		public function destroy():void
		{
			this.removeFromParent(true);
		}
	}

}