package  
{
	import assets.Assets;
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.display.BlendMode;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class LivesUI extends Sprite
	{
		private var items:Vector.<starling.display.Image>;
		private var _lives:int;
		
		public function LivesUI(num:int = 5) 
		{
			items = new Vector.<Image>;
			lives = num;
			
		}
		public function get lives():int
		{
			return _lives
		}
		public function set lives(num:int):void
		{
			_lives = num;
			for each(var item:Image in items)
			{
				removeChild(item);
			}
			items.splice(0, items.length);
			for (var i:int = 0; i < num; i++) 
			{
				items.push(Assets.instantiateImage("shipidle0001"));
				items[i].scaleX = items[i].scaleY = 0.3;
				items[i].blendMode = BlendMode.SCREEN;
				
				addChild(items[i]);
				items[i].x = i * items[i].width +5;
			}
		}
		
	}

}