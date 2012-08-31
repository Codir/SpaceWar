package  space.UI
{
	import flash.events.MouseEvent;
	import space.ImageResources;
	/**
	 * ...
	 * @author Codir
	 */
	public class LevelButton extends menuButton
	{
		private var game:Game;
		private var number:int;
		private var img:ImageResources;
		public var block:Boolean =  false;
		public var score:int=0;
		private var bgImage:ImageResources;
		private var medalImage:ImageResources;
		private var blockImage:ImageResources;
		
		public function LevelButton(_game:Game, _number:int, text:String="", spriteEnable:Boolean=true, color:uint=0x00ffcc, bold:Boolean=true, size:int=24, font:String="Arial", x:Number=80, y:Number=5) 
		{
			game = _game;
			number = _number;
						
			super("", spriteEnable, color, bold, size, font, x, y);
			
			img = new ImageResources("levelScreenShots" + _number, true, false, true);
			img.scaleX = 0.14;
			img.scaleY = 0.14;
			/*img.x = 90;
			img.y = 10;*/
			addChild(img);
			
			bgImage = new ImageResources("levelbuttonBg");
			bgImage.x = 0;
			bgImage.y = 0;
			bgImage.scaleX = 1.2;
			bgImage.scaleY = 1;
			addChild(bgImage);
			
			addEventListener(MouseEvent.CLICK, levelButtonHandle);
		}
		
		private function levelButtonHandle(e:MouseEvent):void 
		{
			if (!block)
			{
				game.start(number);
			}
		}
		
		public function setScore(_score:int):void
		{
			score = _score;
			
			if (medalImage !== null)
			{
				removeChild(medalImage);
			}

			if (score >= 45000)
			{
				medalImage = new ImageResources("medal3");
			}
			else if (score >= 30000)
			{
				medalImage = new ImageResources("medal2");
			}
			else if (score > 0)
			{
				medalImage = new ImageResources("medal1");
			}
			
			if (score > 0)
			{
				medalImage.x = 32;
				medalImage.y = -22;
				medalImage.scaleX = 0.5;
				medalImage.scaleY = 0.5;
				addChild(medalImage);
			}
		}
		
		public function blocked():void
		{
			block = true;
			blockImage = new ImageResources("levelButtonBlocked");
			blockImage.x = 0;
			blockImage.y = 0;
			addChild(blockImage);
			blockImage.scaleX = 1.2;
		}
		
		public function unblocked():void
		{
			block = false;
			removeChild(blockImage);
			blockImage = null;
		}
		
	}

}