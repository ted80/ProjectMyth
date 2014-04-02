package myth.graphics 
{
	import myth.entity.player.PlayerType;
	import myth.gui.components.GuiButton;
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import flash.filesystem.File;
	import myth.Main;
	import myth.gui.game.GuiLoading;
	import treefortress.spriter.SpriterLoader;
	import treefortress.spriter.SpriterClip;
	import myth.lang.Lang;
	
	public class AssetList 
	{
		//textures
		[Embed(source="../../../lib/textures/player.png")]
		public static var player_textures:Class;
		[Embed(source="../../../lib/textures/fish.png")]
		public static var fish_textures:Class;
		
		//xml files
		[Embed(source="../../../lib/textures/player.xml", mimeType = "application/octet-stream")]
		public static var player_xml:Class;
		[Embed(source="../../../lib/textures/fish.xml", mimeType = "application/octet-stream")]
		public static var fish_xml:Class;
		
		//texture atlas
		public static var atlas_player:TextureAtlas;
		public static var atlas_fish:TextureAtlas;
		
		//font
		
		[Embed(source="../../../lib/font/Connie-Regular.ttf", embedAsCFF="false", fontFamily="GameFont")]
		private static const gameFont:Class;
		
		//texture loaders
		public static var assets:AssetManager;
		public static var spriterLoader:SpriterLoader;
		
		public static var currentWorldType:int = -1;
		public static var currentPlayers:Vector.<int> = new Vector.<int>;
		//private static var tileData:Vector.<int>;
		
		public static function preLoad():void
		{
			assets = new AssetManager();
			
			spriterLoader = new SpriterLoader();
			spriterLoader.completed.addOnce(onSpriterLoaded);
			spriterLoader.load([
				"spriteranims/transformation/transAnim.scml", 
				"spriteranims/player1/animLion.scml", 
				"spriteranims/player2/animFlute.scml", 
				"spriteranims/player4/animSwine.scml", 
				"spriteranims/enemydeath/enemydeaths.scml"
			]);

			var appDir:File = File.applicationDirectory;
			assets.enqueue(appDir.resolvePath("tex/background"));
			assets.enqueue(appDir.resolvePath("tex/gui"));
			assets.enqueue(appDir.resolvePath("tex/editor"));
			assets.enqueue(appDir.resolvePath("lang"));
			assets.enqueue(appDir.resolvePath("mapData"));
			assets.enqueue(appDir.resolvePath("tex/map"));
			assets.enqueue(appDir.resolvePath("tex/anim"));
				
			assets.loadQueue(function(ratio:Number):void {
				GuiLoading.progress = ratio;
				if (ratio == 1.0) {
					Lang.init();
					GuiLoading.ready++;
				}
			});
		}
		
		public static function onSpriterLoaded(loader:SpriterLoader):void 
		{
			GuiLoading.ready++;
		}
		
		public static function load():void
		{
			atlas_player = new TextureAtlas(Texture.fromBitmap(new player_textures()), XML(new player_xml()));
			atlas_fish = new TextureAtlas(Texture.fromBitmap(new fish_textures()), XML(new fish_xml()));
			//atlas_enemyRunning = new TextureAtlas(Texture.fromBitmap(new enemyRunning_textures()), XML(new enemyRunning_xml()));
			//atlas_enemy = new TextureAtlas(Texture.fromBitmap(new enemy_textures()), XML(new enemy_xml()));
		}
		
		public static function loadLevelAssets(worldType:int,player1Type:int,player2Type:int,player3Type:int):void
		{
			var load:Boolean = false;
			var appDir:File = File.applicationDirectory;
			
			if (currentWorldType != worldType) {
				load = true;
			}
			trace("currentPlayers L:"+currentPlayers.length)
			for (var i:int = 0; i < 3; i++) 
			{
				if(currentPlayers.length > 0){
					if (currentPlayers[i]==player1Type||currentPlayers[i]==player2Type||currentPlayers[i]==player3Type) {
						
					}else {
						load = true;
						break;
					}
				}
			}
			currentWorldType = worldType;
			currentPlayers[0] = player1Type;
			currentPlayers[1] = player2Type;
			currentPlayers[2] = player3Type;
			
			if (load) {
				//hier moeten alleen de assets voor een level geladen worden
				assets.enqueue(appDir.resolvePath("tex/anim"));
				
				assets.loadQueue(function(ratio:Number):void{
					trace("Loading assets, progress:", ratio);
					if (ratio == 1.0) {
						trace("Loading assets done");
						Main.world.build();
					}
				});
			}else {
				Main.world.build();
				trace("no reload needed");
			}
		}
	}
}