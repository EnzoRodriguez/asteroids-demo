package gameObjects 
{
	import assets.Assets;
	import calulation.MovementVector;
	import flash.media.SoundTransform;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import flash.geom.Point;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Unit extends Sprite
	{
		static public const SHOOT:String = "shoot";
		public var movement:MovementVector = new MovementVector(0,0);
		private var rotSpeed:Number = 0;
		private var pt:Number = 0;
		private var time:Number = 0;
		public var speedDecrease:Number = 0;
		public var maxSpeed:Number = 10;
		public var boost:Number = 2;
		public var harmlessTime:Number = 0.5;
		private var explosion:MovieClip;
		private var harmless:Boolean = true;
		private var blinkTimer:Number = 0;
		public var toRemove:Boolean = false;
		
		public function Unit() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function set isHarmless(b:Boolean):void
		{
			harmless = b;
		}
		public function get isHarmless():Boolean
		{
			return harmless;
		}
		
		
		private function init(e:Event):void 
		{
		
			removeEventListener(Event.ADDED_TO_STAGE, init);
		
			this.pivotX = this.width / 2;
			this.pivotY = this.height / 2;			
			
			explosion = Assets.instantiateMovieClip(Assets.EXPLOSION);
			explosion.stop();
			explosion.scaleX = explosion.scaleY = 0.4;
			
			explosion.pivotX = explosion.width / 2;
			explosion.pivotY = explosion.height / 2;
					
		}
		public function teleport():void
		{	
			//teleport mechanic
			
			
			if (stage != null)
			{
   			if (this.x > stage.stageWidth + this.width) this.x = -this.width;
			if (this.x < - this.width) this.x = stage.stageWidth + this.width;
			if (this.y > stage.stageHeight + this.width) this.y = -this.width;
			if (this.y < - this.width) this.y = stage.stageHeight + this.width;		
			}else
			{
				//trace(this + "still in vector");
			}
		}
		public function addMoveForce(mVec:MovementVector):void
		{
			//add force to movement vector
			movement.xFactor += mVec.xFactor;
			movement.yFactor += mVec.yFactor;
			movement.speed += mVec.speed;		
			
		}
		public function brake(force:Number):void
		{
			if (movement.speed >= force) movement.speed -= force;
			if (movement.speed == 0)
			{
				movement.xFactor = 0;
				movement.yFactor = 0;
			}
		}
		
		private function move():void
		{
			//movement			
			if (movement.speed > maxSpeed) movement.speed = maxSpeed;				
			this.x += movement.xFactor * movement.speed * pt;
			this.y += movement.yFactor * movement.speed * pt;
			
			if (movement.speed > 0) 
			{ 
				
				movement.speed -= speedDecrease;
			}
			else
			{
				movement.xFactor = 0;
				movement.yFactor = 0;
			}
			
		}
		public function rotate(spd:Number):void
		{
			//rotate mechanic		
			rotSpeed = spd;						
		}
		
		public function autofire(reloadTime:Number):void		
		{
			//shoot mechanic
			time += pt;
			if (time > reloadTime)
			{
				dispatchEventWith(SHOOT,false,"single");
				time = 0;
			}			
		}
		public function checkCollisionWith(target:Sprite):Boolean
		{
			var p1:Point = new Point(this.x, this.y);
			var p2:Point = new Point(target.x, target.y);
			if (Point.distance(p1, p2) < this.width/2 + target.width/2) { 
				
				
				return true 
				
			};
			return false;
		}
		
		public function update(passedTime:Number):void
		{
			pt = passedTime;
			if (time < harmlessTime)
			{
				time += pt;
				blink();
				
			}else if(harmless)
			{
				this.alpha = 1;
				harmless = false;				
			}
			
			
			this.rotation += rotSpeed / 180 * Math.PI * passedTime;  //rotSpeed is in graden per seconde, dat wordt hier omgezet in radians per frame
			move();			
			teleport();
			
			
		}
		
		private function blink():void 
		{
			blinkTimer += pt;
			if (blinkTimer > 0.3)
			{
				blinkTimer = 0;
				if (this.alpha == 1)
				{
					this.alpha = 0.2;
				}
				else
				{
					this.alpha = 1;
				}
			}
		}
		public function explode():void
		{
			addChild(explosion);			
			explosion.play();
			
			explosion.addEventListener(Event.COMPLETE, destroy);
			
			var r:int = Math.ceil(Math.random() * 2);
			Assets.playSound(Assets["SND_EXPLODE" + r],new SoundTransform(this.scaleX));
			
			
		}
		
		public function destroy(e:Event = null):void 
		{
			
			if (e != null) explosion.removeEventListener(Event.COMPLETE, destroy);			
			this.removeFromParent(true);
		}
		
	}

}