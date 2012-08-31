package  space.UI
{
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import space.ImageResources;
	/**
	 * ...
	 * @author Codir
	 */
	public class ShipButton extends menuButton
	{
		private var game:Game;
		private var number:int;
		private var img:ImageResources;
		public var bgImage:ImageResources;
		public var popUpText:TextLabel;
		private var popUp:ImageResources = new ImageResources("shipButtonPopup");
		public var on:Boolean;
		
		public function ShipButton(ship:String, _game:Game, _number:int, text:String = "", _on:Boolean = true, spriteEnable:Boolean = false, color:uint = 0x00ffcc, bold:Boolean = true, size:int = 24, font:String = "Arial", x:Number = 80, y:Number = 5 ) 
		{
			popUpText = new TextLabel(text, 0x1C1506, false, 10, "Arial", 100);
			game = _game;
			number = _number;
			on = _on;
			text = "";
			
			if (on)
			{
				bgImage = new ImageResources("shipbuttonBG");
			}
			else
			{
				bgImage = new ImageResources("shipbuttonLock");
			}
			bgImage.x = 0;
			bgImage.y = 0;
			addChild(bgImage);
			
			super(text, spriteEnable, color, bold, size, font, x, y);
			
			img = new ImageResources(ship, true, false, true);
			img.scaleX = 1;
			img.scaleY = 1;
			
			if (ship == "airship")
			{
				img.scaleX = 0.6;
			}
			/*img.x = 90;
			img.y = 10;*/
			addChild(img);
			
			addChild(popUp);
			popUp.x = 22;
			popUp.y = -10;
			popUp.visible = false;
			popUp.scaleX = 1.4;
			addChild(popUpText);
			popUpText.x = -26;
			popUpText.y = -32;
			popUpText.visible = false;
			
			addEventListener(MouseEvent.CLICK, levelButtonHandle);
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
		}
		
		private function mouseOutHandler(e:MouseEvent):void 
		{
			if (!on)
			{
				popUp.visible = false;
				popUpText.visible = false;
			}
		}
		
		private function mouseOverHandler(e:MouseEvent):void 
		{
			if (!on)
			{
				popUp.visible = true;
				popUpText.visible = true;
			}
		}
		
		private function levelButtonHandle(e:MouseEvent):void 
		{
			if (on)
			{
				game.selectShip(number);
				game.levelscreen.rocketButton1.unSelected();
				game.levelscreen.rocketButton2.unSelected();
				game.levelscreen.rocketButton3.unSelected();
				selected();
			}
		}
		
		public function selected():void
		{
			removeChild(bgImage);
			bgImage = new ImageResources("shipButtonSelected");
			addChild(bgImage);
			removeChild(img);
			addChild(img);
		}
		
		public function unSelected():void
		{
			if (on)
			{
				removeChild(bgImage);
				bgImage = new ImageResources("shipbuttonBG");
				addChild(bgImage);
				removeChild(img);
				addChild(img);
			}
			else
			{	
				removeChild(bgImage);
				bgImage = new ImageResources("shipbuttonLock");
				addChild(bgImage);
				removeChild(img);
				addChild(img);
			}
		}
		
		public function unLock():void
		{
			on = true;
			unSelected();
		}
		
	}

}