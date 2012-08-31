package 
 {
	import space.DEngine;
	import space.ImageResources;
	import space.CMath;
	
	/**
	 * ...
	 * @author Codir
	 */
	[SWF(width = '650', height = '420', backgroundColor = "0x000000")]
	public class Main extends DEngine 
	{
		public var aimImg:ImageResources;
		
		public function Main(_game:Game):void 
		{
			super(_game);
			
			aimImg = new ImageResources('aimImg');
			screen.addChild(aimImg);
			aimImg.x = mouseX;
			aimImg.y = mouseY;
		}
		
		override protected function update():void {
				if (shipObj[hero].img)
				{
					aimImg.x = mouseX-screen.x;
					aimImg.y = mouseY-screen.y;
					
					var aimAngle:Number = CMath.radToGrad(CMath.getAngle(shipObj[hero].img.x, shipObj[hero].img.y, aimImg.x, aimImg.y));
					shipObj[hero].gun.rotation = aimAngle + 90;
					
					if (inputObj.isDown('w'))
					{
						shipObj[hero].move();
					}
					if (inputObj.isDown('a'))
					{
						shipObj[hero].rotateLeft();
					}
					if (inputObj.isDown('d'))
					{
						shipObj[hero].rotateRight();
					}
					if (inputObj.isClick())
					{
						shipObj[hero].weapons.turret.fire();
					}
					if (inputObj.isDown('space'))
					{
						shipObj[hero].weapons.spin.fire();
					}
					
					if (shipObj[hero].fuel < 0)
					levelComplete();
				}
		}
		
		public function levelComplete(win:Boolean = false ):void 
		{					
			if(win)
				score = 1;
			else
				score = 0;
							
							
			/*if (!completeScreen)
			{
				completeScreen = new levelComplite(game, worldScale, score);
				addChild(completeScreen);
				completeScreen.x = 320;
				completeScreen.y = 200;
			}*/
		}

	}

}