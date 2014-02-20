package screens 
{
	import assets.Assets;
	import assets.EmbeddedAssets;
	import environment.Space;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import starling.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import starling.events.EnterFrameEvent;
	
	import controllers.TouchController;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class StartScreen extends Screen 
	{
		
		
		static public const START_GAME:String = "startGame";
		private var textfield:TextField;
		private var space:Space;
		private var color:uint;
		private var colorAdjust:uint;
		private var st:SoundTransform = new SoundTransform(1, -1);
		private var time:Number = 0;
		private var channel:SoundChannel;
		
		public function StartScreen() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			channel = Assets.playSound(Assets.SND_LOOP, st,100,9999);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);			
			
			addChild(space = new Space());		
			
			var title:TextField = new TextField(320, 100, "Astro Infinite", "spacerangerFont", 30, 0xffffff, true); 
			title.hAlign = HAlign.CENTER;
			title.vAlign = VAlign.CENTER;
			addChild(title);
			title.x = stage.stageWidth / 2 - title.width / 2;
			title.y = stage.stageHeight / 4 - title.height / 2;
			
			color = Math.random() * 0xffffff;
			colorAdjust = Math.random() * 0xffffff;
			textfield = new TextField(320, 100, "Press Space To Start", "spacerangerFont" ,20, color);
			textfield.hAlign = HAlign.CENTER;
			textfield.vAlign = VAlign.CENTER;
			addChild(textfield);
			textfield.x = stage.stageWidth / 2 - textfield.width / 2;
			textfield.y = stage.stageHeight / 2 - textfield.height / 2;
			
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, spaceloop);
			
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(TouchController.TAP, onTap);
		}
		
		private function onTap(e:Event):void 
		{
			
			//trace("startscreen on tap!!");
			startGame();
			
			Root.DEVICE_TYPE = Root.TOUCH_DEVICE;
		}
		
		private function startGame():void 
		{
			this.removeEventListener(Event.ENTER_FRAME, spaceloop);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.removeEventListener(TouchController.TAP, onTap);
			dispatchEvent(new Event(START_GAME));			
			channel.stop();
		}
		
		private function spaceloop(e:EnterFrameEvent):void 
		{
			time += e.passedTime;
			space.update(e.passedTime);			
			color += colorAdjust;
			textfield.color = color;
			
			
			if (time > 0.1)
			{
				time = 0;
				if(st.pan < 1){
					st.pan += 0.1;
				}else {
					st.pan = -1;
				}
				channel.soundTransform = st;
			}
		
		}
				
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				Root.DEVICE_TYPE = Root.KEY_DEVICE;
				startGame();
			}
		}
	}

}