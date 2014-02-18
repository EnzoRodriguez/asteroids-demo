package  
{
	
	import screens.Screen;
	import starling.display.Sprite;
	import screens.InGameScreen;
	import screens.StartScreen;
	import starling.events.Event
	import assets.Assets;
	import starling.events.KeyboardEvent;
	/**
	 * ...
	 * @author erwin henraat
	 * 
	 * In de volgende demo
	 * 1 Embedden van textures en creeren van Images
	 * 2 gebruiken van de assetManager en File class om art in te laden
	 * 3 gebruiken van MovieClip class en Starling.juggler om animaties af te spelen
	 * 4 gebruiken van dictionary om bijvoorbeeld verschillende snelheden en movieclips op te slaan.
	 * 5 OOP maken van de code
	 * 6 Starling wiki documentatie en starling code reference
	 * 
	 * 
	 */
	public class Root extends Sprite
	{
		private var startScreen:StartScreen;
		private var inGameScreen:InGameScreen;
		
	
		private var screen:Screen;
		public function Root():void
		{
			
						
			
			Assets.loadAssets();
			Assets.dispatcher.addEventListener(Assets.ASSETS_LOADED, done);
			
		}	
		private function placeScreen(type:String):void
		{
			switch(type)
			{
				case "start":
					screen = new StartScreen();
					screen.addEventListener(StartScreen.START_GAME, startGame);
					break;
				case "inGame":
					screen = new InGameScreen();
					screen.addEventListener(InGameScreen.END_GAME, endGame);
					break;
				
			}

			addChild(screen);
		}
		
		private function done(e:Event):void 
		{	
			
			placeScreen("start");					
			
		}				
		private function startGame(e:Event):void 
		{
			screen.destroy();
			
			placeScreen("inGame");
			
		}		
		private function endGame(e:Event):void 
		{
			screen.destroy();
			placeScreen("start");
		}
		
		
	}	
		
}

