package screens 
{
	import assets.EmbeddedAssets;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import starling.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class StartScreen extends Screen 
	{
		
		
		static public const START_GAME:String = "startGame";
		private var textfield:TextField;
		
		public function StartScreen() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);			
			textfield = new TextField(400, 100, "Press Space To Start", "spacerangerFont" ,30,0x550000);
			textfield.hAlign = HAlign.CENTER;
			textfield.vAlign = VAlign.CENTER;
			addChild(textfield);
			textfield.x = stage.stageWidth / 2 - textfield.width / 2;
			textfield.y = stage.stageHeight / 2 - textfield.height / 2;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
				
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				dispatchEvent(new Event(START_GAME));
			}
		}
	}

}