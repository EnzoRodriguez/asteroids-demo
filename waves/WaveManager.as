package waves 
{
	import calulation.MovementVector;
	import flash.geom.Point;
	import gameObjects.Asteroid;
	import gameObjects.Unit;
	import starling.events.EventDispatcher;
	import starling.events.EnterFrameEvent;
	import starling.display.Sprite;
	import gameObjects.Unit;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class WaveManager extends EventDispatcher
	{
		public var pool:Vector.<Unit> = new Vector.<Unit>;
		private var _targetVector:Vector.<Unit>;
		private var passedTime:Number = 0;
		private var pooling:Boolean = false;
		private var time:Number = 0;
		private var poolInterval:Number = 5;
		private var maximumPoolSize:Number = 0;
		private var _stageSize:Point;
		private var _targetSprite:Sprite;
		public function WaveManager(targetSprite:Sprite, targetVector:Vector.<Unit>, stageSize:Point):void 
		{
			_targetSprite = targetSprite;
			_stageSize = stageSize;
			_targetVector = targetVector; 
			
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, loop);
		}
		public function startPooling(interval:Number, maxPoolSize:Number = 100):void
		{
			maximumPoolSize = maxPoolSize;
			pooling = true;
			poolInterval = interval;
		}
		private function loop(e:EnterFrameEvent):void 
		{
			var currPoolSize:int = pool.length;
			
			
			if (pooling && currPoolSize < maximumPoolSize)
			{
				//trace("addTime" + time);
				//trace("pool interval" + poolInterval);
				time += e.passedTime;
				if (time > poolInterval)
				{
				//	trace("pool unit");
					time = 0;
					
					poolUnit();
				}
				
				
			}
		}
			
		private function poolUnit():void 
		{
			
			var asteroid:Unit = new Asteroid();
			pool.push(asteroid);	
			_targetSprite.addChild(asteroid);
			asteroid.visible = false;
			
			
		}		
		public function createWave(total:Number):void
		{
			var poolSize:int = pool.length;
			var numFromPool:int = total;
			
			var newWave:Vector.<Unit> = new Vector.<Unit>;
			if (total > poolSize) numFromPool = poolSize;
			
			
			for (var i:int = 0; i < numFromPool; i++) 
			{
				var popped:Unit = pool.pop();
				popped.visible = true;		
				newWave.push(popped);
			}
			for (i = 0; i < total-numFromPool; i++) 
			{
				var fresh:Unit = new Asteroid();
				_targetSprite.addChild(fresh);
				newWave.push(fresh);				
			}
			for each(var asteroid:Asteroid in newWave)
			{
				_targetVector.push(asteroid);
				asteroid.x = Math.random() * _stageSize.x;
				asteroid.y = Math.random() * _stageSize.y;
				
				asteroid.scaleX = asteroid.scaleY = 0.2 + Math.random() * 0.3;
				
				var speed:Number =  10000 + Math.random() * 5000;
				var rot:Number = Math.PI * Math.random();
				
				asteroid.addMoveForce(new MovementVector(rot, speed));
				

			}
			
			
			
		}
		
	}

}