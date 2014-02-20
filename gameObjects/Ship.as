package gameObjects 
{
	import assets.Assets;
	import calculation.MovementVector;
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import controllers.TouchController;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Ship extends Unit
	{
		
		private var idleAnimation:MovieClip;
		private var moveAnimation:MovieClip;
		
		private var rotSpeed:Number = 0;
		private var lastRot:Number = 0;
		private var moving:Boolean = false;
		private var cooldown:Number = 0;
		private var accelerate:Boolean = false;
		private var braking:Boolean = false;
		private var lives:int = 5;
		public var rotationSpeed:Number = 180;
		
		public function get livesLeft():int
		{
			return lives;
		}
		public function set livesLeft(num:int):void
		{
			lives = num;
		}
		public function Ship() 
		{						
			harmlessTime = 2;
			idleAnimation = Assets.instantiateMovieClip(Assets.SHIP_IDLE);
			moveAnimation = Assets.instantiateMovieClip(Assets.SHIP_MOVE);
			addChild(idleAnimation);
			addChild(moveAnimation);			
			idleAnimation.play();
			moveAnimation.play();
			moveAnimation.visible = false;		
			
			//addMoveForce(new MovementVector(this.rotation, 500))
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
		}		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, kDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, kUp);
			stage.addEventListener(TouchController.TAP, onTap);
			stage.addEventListener(TouchController.SWIPE, onSwipe);
		}
		
		private function onSwipe(e:Event):void 
		{
			
			var strength:Number = Number(e.data);
			//trace("strength : " + strength);
			
			rotate(rotationSpeed * strength / 50);
		}
		
		private function onTap(e:Event):void 
		{
			dispatchEventWith(SHOOT, false, "single");
		}
		
		private function kDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.LEFT)
			{				
				rotate(-rotationSpeed);				
			}
			if (e.keyCode == Keyboard.RIGHT)
			{
				rotate(rotationSpeed);
			}
			if (e.keyCode == Keyboard.UP)
			{
				accelerate = true;
				
			}
			if (e.keyCode == Keyboard.DOWN)
			{
				braking = true;
			}
			
		}	
		private function kUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.RIGHT)
			{
				
				rotate(0);				
			}			
			if (e.keyCode == Keyboard.UP)
			{
				accelerate = false;
			}
			if (e.keyCode == Keyboard.DOWN)
			{
				braking = false;
			}

			if (e.keyCode == Keyboard.SPACE)
			{
				dispatchEventWith(SHOOT, false, "single");
						
			}
		}				
		public override function update(passedTime:Number):void
		{			
			
			
			if (accelerate) addMoveForce(new MovementVector(this.rotation, boost));
			if (braking) brake(1);
			super.update(passedTime);
			//autofire(5);	
			animate();
					
		}	
		
		private function animate():void 
		{
			if (movement == null)
			{
				idleAnimation.visible = true;
				moveAnimation.visible = false;
			
				
			}else
			{
				if (movement.speed > 5)
				{
					if (idleAnimation.visible)
					{
						idleAnimation.visible = false;
						moveAnimation.visible = true;
					}
				}
				else
				{
					if (!idleAnimation.visible)
					{
						idleAnimation.visible = true;
						moveAnimation.visible = false;
					}
				}
			}
			
			
		}
		public override function explode():void
		{
			if (lives > 0)
			{
				lives--;
			}
			else
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, kDown);
				stage.removeEventListener(KeyboardEvent.KEY_UP, kUp);
			
				super.explode();
			}
			
			
			
		}
		
	}

}