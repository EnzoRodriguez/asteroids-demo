package assets
{
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class EmbeddedAssets 
	{
		[Embed(source = "../../bin/assets/space_background_1.png")]
		public static const spaceLayer1:Class;
		[Embed(source = "../../bin/assets/space_background_2.png")]
		public static const spaceLayer2:Class;
		[Embed(source = "../../bin/assets/shooting_star.png")]
		public static const shootingStar:Class;

		[Embed(source = "../../bin/assets/spaceranger.ttf", embedAsCFF="false", fontFamily="spacerangerFont")]
		public static const spacerangerFont:Class;
		
		
	}

}