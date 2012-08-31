package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import space.buttonsPanel;
	import space.CScreens.LeaderBoard;
	import space.CScreens.levelScreen;
	import space.MusicManager;
	import space.UI.FPS;
	import space.UI.MainMenu;
	import space.CData;
	
	/**
	 * ...
	 * @author Codir
	 */
	[Frame(factoryClass = "Preloader")]
	[SWF(width = '650', height = '420', backgroundColor = "0x000000")]
	
	public class Game extends Sprite
	{
		public var state:Main;
		public var mainMenu:MainMenu;
		public var data:CData;
		public var levelscreen:levelScreen;
		public var fps:FPS = new FPS();
		public var musicManager:MusicManager;
		public var leaderBoardScreen:LeaderBoard;
		
		
		public function Game() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event = null):void  {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			musicManager = new MusicManager(this);
			data = CData.instance;
			showMainMenu();
		}
		
		public function showlevelscreen(level:*=false):void
		{
			if (mainMenu)
			{
				removeChild(mainMenu);
				mainMenu = null;
			}
			
			//musicManager.play("MenuMusic", 0.3, true);
			levelscreen = new levelScreen(this);
			addChild(levelscreen);
		}
		
		public function start(level:*=false):void
		{
			//musicManager.play("GameMusic", 0.3, true);
			if (levelscreen)
			{
				removeChild(levelscreen);
				levelscreen = null;
			}
			
			if (!level) level = data.currentLevel;
			data.currentLevel = level;
			var ship:int = data.currentShip;
			
			state = new Main(this);
			addChild(state);
			
			//Add UI
			/*addChild(fps);
			fps.x = 550;
			fps.y = 50;*/
		}
		
		public function restart():void
		{
			deleteLevel();
			start(data.currentLevel);
		}
		
		
		public function nextLevel():void
		{
			deleteLevel();
			data.currentLevel += 1;
			start(data.currentLevel);
		}
		
		public function exitToMenu():void
		{
			deleteLevel();
			showMainMenu();
		}
		
		public function exitToLevelScreen():void
		{
			deleteLevel();
			showlevelscreen();
		}
		
		public function deleteLevel():void
		{
			if (levelscreen)
			{
				removeChild(levelscreen);
				levelscreen = null;
			}
			if (state)
			{
				state.soundManager.stopAll(true);
				removeChild(state);
				state = null;
			}
		}
		
		public function showMainMenu():void
		{
			//musicManager.play("MenuMusic", 0.3, true);
			mainMenu = new MainMenu(this);
			addChild(mainMenu);
		}
		
		public function selectShip(_number:int):void
		{
			data.currentShip = _number;
		}
		
		public function showLeaderBoard(table:Array = null):void
		{
			leaderBoardScreen = new LeaderBoard(this, table);
			addChild(leaderBoardScreen);
		}
		
		public function hideLeaderBoard():void
		{
			removeChild(leaderBoardScreen);
			leaderBoardScreen = null;
		}
	}

}