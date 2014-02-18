package environment 
{
	import starling.events.Event;
	import assets.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Space extends Sprite
	{
		
		private var layers:Vector.<Image>;
		private var shootingStars:Vector.<Star>;
		public var numStars:int = 10;
		public function Space() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			layers = new Vector.<Image>;
			layers.push( Assets.instantiateImage(Assets.SPACE_LAYER_1));
			layers.push( Assets.instantiateImage(Assets.SPACE_LAYER_2));
			layers.push( Assets.instantiateImage(Assets.SPACE_LAYER_2));
			layers.push( Assets.instantiateImage(Assets.SPACE_LAYER_2));
			layers[1].y = -layers[1].height;
			
			for (var i:int = 0; i < layers.length; i++) 
			{
				layers[i].width = stage.stageWidth;
				layers[i].height = stage.stageHeight;
				addChild(layers[i]);
				if(i > 0)layers[i].x = -10 + Math.random() * stage.stageWidth + 20;
			}
			
			shootingStars = new Vector.<Star>;
			for (var j:int = 0; j < numStars; j++) 
			{
				shootingStars.push(new Star());
				shootingStars[j].speed = 3 + Math.random() * 7;
				shootingStars[j].x =  Math.random() * stage.stageWidth
				shootingStars[j].y = Math.random() * (stage.stageHeight + 200) - 100;
				addChild(shootingStars[j]);
			}			
			
		}
		public function update(frameTime:Number):void
		{
			var l:int = shootingStars.length;
			var sh:Number = stage.stageHeight;
			
			for (var i:int = 0; i < l; i++) 
			{
				shootingStars[i].y  += shootingStars[i].speed;
				
				if (shootingStars[i].y > sh + shootingStars[i].height)
				{
					shootingStars[i].y = -shootingStars[i].height - Math.random() * 500;
					shootingStars[i].x = Math.random() * stage.stageWidth;
				}
				
			}
			
			for (var j:int = 1; j <= 2; j++) 
			{
				layers[j].y += 20 * frameTime;
				if (layers[j].y > stage.stageHeight)
				{
					layers[j].y -= 2*layers[j].height;
				}
			}
		}
		
	}

}