package  space.UI
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import space.ImageResources;
	/**
	 * ...
	 * @author Codir
	 */
	public class MainMenu extends Sprite
	{
		public var playButton:menuButton = new menuButton("Play", true, 0x191100, true, 28, "Arial", 80, 5, 200);
		public var highscoresButton:menuButton = new menuButton("Highscores", true, 0x191100, true, 28, "Arial", 80, 5, 200);
		public var game:Game;
		public var bg:ImageResources = new ImageResources("menuBg", false);
		public var title:ImageResources = new ImageResources("logo1");
		
		public function MainMenu(_game:Game) 
		{
			game = _game;
			var startX:int = 100;
			var startY:int = 100;
			var step:int = 50;
			
			addChild(bg);
			bg.x = 0;
			bg.y = 0;
			
			addChild(title);
			title.x = 550;
			title.y = 80;
			title.scaleX = 1.2;
			title.scaleY = 1.2;
			
			addChild(playButton);
			playButton.x = startX;
			playButton.y = startY;
			
			//playButton.addEventListener(MouseEvent.CLICK, game.showlevelscreen);
			playButton.addEventListener(MouseEvent.CLICK, game.start);
		}
		
	}

}