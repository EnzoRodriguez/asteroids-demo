package calulation 
{
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class MovementVector extends Object
	{
		public var xFactor:Number; 
		public var yFactor:Number;
		public var speed:Number;
		public function MovementVector(rot:Number = 0,  movespeed:Number = 0, calcType:String = "radians") 		
		{						
			var angle:Number; 			
			switch(calcType)
			{
				case "radians":				
					angle = rot;
					break;					
				case "degrees":
					
					angle = rot * Math.PI / 180;			
					break;
			}						
			xFactor = 0;
			yFactor = 0;
			if (movespeed > 0){
				xFactor = Math.cos(angle);			
				yFactor = Math.sin(angle);
			}
			speed = movespeed;			
		}
		
	}

}