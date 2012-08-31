package space 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Codir
	 */
	public class buttonsPanel extends Sprite
	{
		private var bg:ImageResources = new ImageResources("buttonsBg");
		private var game:Game;
		public var buttons:Vector.<actionButton> = new Vector.<actionButton>;
		
		public function buttonsPanel(_game:Game) 
		{
			game = _game;
			addChild(bg);
			bg.x = 100;
			bg.y = 0;
			
			var menuButtonImg:actionButton = new actionButton("menuButtonImg", 0, game);
			addChild(menuButtonImg);
			menuButtonImg.x = 50;
			menuButtonImg.y = 0;
			var replayButton:actionButton = new actionButton("replayButton", 1, game);
			addChild(replayButton);
			replayButton.x = 95;
			replayButton.y = 0;
			var musicButton:actionButton = new actionButton("musicButton", 2, game);
			addChild(musicButton);
			musicButton.x = 140;
			musicButton.y = 0;
			var soundButton:actionButton = new actionButton("soundButton", 3, game);
			addChild(soundButton);
			soundButton.x = 185;
			soundButton.y = 0;
			
		}
		
		public function show():void
		{
			//addChild(bg);
		}
		
		public function hide():void
		{
			//removeChild(bg);
		}
		
	}

}