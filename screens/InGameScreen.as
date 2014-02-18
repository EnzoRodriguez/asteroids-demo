package screens 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import calulation.MovementVector;
	import environment.Space;
	import gameObjects.Asteroid;
	import gameObjects.Ship;
	import gameObjects.Unit;
	import particles.Shot;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.events.EnterFrameEvent;
	import waves.WaveManager;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class InGameScreen extends Screen 
	{
		static public const END_GAME:String = "endGame";
		private var ship:Ship
		private var enemies:Vector.<Unit>;
		private var space:Space;
		private var playerShots:Vector.<Shot>;		
		private var assetManager:AssetManager;
		private var time:Number = 0;
		private var waveManager:WaveManager;
		private var waveSize:int = 10;
		private var waveTimer:Number = 0;
		private var waveCounter:TextField;
		private var waveNumber:Number = 1;
		
		public function InGameScreen() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			//create background
			space = new Space();
			space.numStars = 30;
			addChild(space);
			
			//create ship
			ship = new Ship();			
			addChild(ship);
			ship.x = stage.stageWidth / 2;
			ship.y = stage.stageHeight / 2;
			ship.scaleX = ship.scaleY = 0.3;
			ship.speedDecrease = 0.2;
			ship.boost = 2.5;
			ship.rotationSpeed = 200;
			ship.maxSpeed = 20;
			//ship.addEventListener(Unit.SHOOT, createShots);
			
			
			enemies = new Vector.<Unit>;
			
			//create wave manager
			waveManager = new WaveManager(this,enemies,new Point(stage.stageWidth, stage.stageHeight));
			waveManager.startPooling(1, 100);
			
			//temp
			//waveSize = 2;
			//create asteroids			
			waveManager.createWave(waveSize);
			
			
			//create shots holder
			playerShots = new Vector.<Shot>;
			
			waveCounter = new TextField(300, 100, "Wave : 1", "spacerangerFont", 20, 0xffffff);
			addChild(waveCounter);
			waveCounter.x = stage.stageWidth / 2 - waveCounter.width/2;
			waveCounter.hAlign = HAlign.CENTER;
			waveCounter.y = stage.stageHeight / 2 - waveCounter.height / 2;
			waveCounter.hAlign = VAlign.CENTER;
			
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, loop);
		}
		private function loop(e:EnterFrameEvent):void 
		{
			if (waveCounter.alpha > 0) waveCounter.alpha -= 0.01;
			
			
			var pt:Number = e.passedTime;
			var numEnemies:int = enemies.length;
			
			if(ship!=null)ship.update(pt);
			
			
			for each(var shot:Shot in playerShots) 
			{				
				shot.update(pt);
				if(!shot.isHarmless){
					if (ship != null)
					{
						if (ship.checkCollisionWith(shot))
						{
							ship.toRemove = true;
							shot.toRemove = true;
						}
					}
					for each(var enemy:Unit in enemies)
					{
						if (enemy.checkCollisionWith(shot))
						{
							//trace("collide with shot");
							shot.toRemove = true;							
							enemy.toRemove = true;
						}
					}
				}
				if (shot.toRemove)
				{
					playerShots.splice(playerShots.indexOf(shot), 1);
					shot.destroy();
				}
			}
			
			
			//get new wave from pool
			if (numEnemies == 0)
			{
				
				
				waveTimer += e.passedTime;
				if (waveTimer > 2)
				{
					waveManager.createWave(waveSize);
					waveNumber++;
					waveCounter.text = "Wave : " + waveNumber;
					waveCounter.alpha = 2;
					waveSize += 2;
					waveTimer = 0;
					
				}
				
				
								
			}
			for each(enemy in enemies)
			{
				enemy.update(pt);
				if (ship != null ) {
					if(!ship.isHarmless && !enemy.isHarmless){
						if (enemy.checkCollisionWith(ship))
						{
							//trace("collide with ship");
							enemy.toRemove = true;							
							ship.toRemove = true;
							
						}
					}
				}
				
				if (enemy.toRemove)
				{
					enemies.splice(enemies.indexOf(enemy), 1);
					enemy.explode();
				}
			}
			//trace("enemies.length" +enemies.length);
			space.update(pt);
			
			//wait for enabling shots
			if (ship != null) {
				if (ship.toRemove)
				{
					
					ship.removeEventListener(Unit.SHOOT, createShots);
					ship.explode();
					ship = null;
					time = 0;
					
				}
				if (time < 0.5)
				{
					time += pt;
				}else if(!ship.hasEventListener(Unit.SHOOT))
				{
					ship.addEventListener(Unit.SHOOT, createShots);
				}
			}else //player dies and wait to end game
			{
				time += pt;
				if (time > 3)
				{
					dispatchEvent(new Event(END_GAME));
				}
			}
		
		}
		
		private function createShots(e:Event):void 
		{		
			switch(e.data)
			{
				case "single":					
 					var shot:Shot = new Shot(new MovementVector(ship.rotation, 500), new Point(ship.x,ship.y));					
					playerShots.push(shot);
					addChild(shot);
					break;
			}
		}
		 
		
	}

}