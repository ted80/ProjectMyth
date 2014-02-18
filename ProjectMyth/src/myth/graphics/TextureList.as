package myth.graphics 
{
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	
	public class TextureList 
	{
		//textures
		[Embed(source="../../../lib/textures/gui.png")]
		public static var gui_textures:Class;
		[Embed(source="../../../lib/textures/gui_achtergrond.png")]
		public static var gui_background_textures:Class;
		[Embed(source="../../../lib/textures/player.png")]
		public static var player_textures:Class;
		[Embed(source="../../../lib/textures/backgroundtiles.png")]
		public static var background_textures:Class;
		[Embed(source="../../../lib/textures/background_sky.png")]
		public static var background2_textures:Class;
		[Embed(source="../../../lib/textures/level.png")]
		public static var level_textures:Class;
		
		//xml files
		[Embed(source = "../../../lib/textures/gui.xml", mimeType = "application/octet-stream")]
		public static var gui_xml:Class;
		[Embed(source = "../../../lib/textures/gui_achtergrond.xml", mimeType = "application/octet-stream")]
		public static var gui_background_xml:Class;
		[Embed(source="../../../lib/textures/player.xml", mimeType = "application/octet-stream")]
		public static var player_xml:Class;
		[Embed(source="../../../lib/textures/backgroundtiles.xml", mimeType = "application/octet-stream")]
		public static var background_xml:Class;
		[Embed(source="../../../lib/textures/background_sky.xml", mimeType = "application/octet-stream")]
		public static var background2_xml:Class;
		[Embed(source="../../../lib/textures/level.xml", mimeType = "application/octet-stream")]
		public static var level_xml:Class;
		
		//texture atlas
		public static var atlas_gui:TextureAtlas;
		public static var atlas_gui_background:TextureAtlas;
		public static var atlas_player:TextureAtlas;
		public static var atlas_background:TextureAtlas;
		public static var atlas_background2:TextureAtlas;
		public static var atlas_level:TextureAtlas;
		
		public static function load():void
		{
			atlas_gui = new TextureAtlas(Texture.fromBitmap(new gui_textures()), XML(new gui_xml()));
			atlas_gui_background = new TextureAtlas(Texture.fromBitmap(new gui_background_textures()), XML(new gui_background_xml()));
			atlas_player = new TextureAtlas(Texture.fromBitmap(new player_textures()), XML(new player_xml()));
			atlas_background = new TextureAtlas(Texture.fromBitmap(new background_textures()), XML(new background_xml()));
			atlas_background2 = new TextureAtlas(Texture.fromBitmap(new background2_textures()), XML(new background2_xml()));
			atlas_level = new TextureAtlas(Texture.fromBitmap(new level_textures()), XML(new level_xml()));
		}
	}
}