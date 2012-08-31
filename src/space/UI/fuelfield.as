package space.UI 
{
	import flash.display.Sprite;
	
	public class fuelfield extends Sprite {
		public var bar:Sprite;
		
		public function fuelfield(i:Number, height:int, color:uint) {
			var rect:Sprite = new Sprite();
			rect.graphics.beginFill(color);
      		rect.graphics.drawRect(0,24,i+2,height+2);
      		addChild(rect);
			
			var rect2:Sprite = new Sprite();
			rect2.graphics.beginFill(0x000000);
      		rect2.graphics.drawRect(1,25,i,height);
      		addChild(rect2);
			
			bar= new Sprite();
			bar.graphics.beginFill(color);
      		bar.graphics.drawRect(1,25,i,height);
      		addChild(bar);
		}
		
		public function setWidth(width:Number):void 
		{
			if (width > 0)
			bar.scaleX = width;
			else
			bar.scaleX = 0;
		}

	}
	
}
