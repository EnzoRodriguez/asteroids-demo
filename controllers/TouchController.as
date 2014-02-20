package controllers 
{
	import flash.geom.Point;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class TouchController
	{
		static public const SWIPE:String = "swipe";
		static public const TAP:String = "tap";

		private var _stage:Stage;
		private var _ship:Sprite;
		
		
		public function TouchController(stage:Stage) 
		{
			_stage = stage;
			_stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var tap:Touch = e.getTouch(_stage, TouchPhase.ENDED);
			
			var moved:Touch = e.getTouch(_stage, TouchPhase.MOVED);
			if (moved != null)
			{
				var m:Point = moved.getMovement(_stage);
				if (m.x < -10 || m.x > 10)
				{
					_stage.dispatchEventWith(SWIPE, false, ""+m.x);
				}
				
			}
			if (tap != null)
			{
				_stage.dispatchEventWith(TAP);
			}
		
		}
		
	}

}