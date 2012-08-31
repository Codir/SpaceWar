package space.UI
{
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import space.ImageResources;
	
	/**
	 * ...
	 * @author Codir
	 */
	public class menuButton extends Sprite 
	{
		public var bg:ImageResources = new ImageResources("menuButtonBg", false);
		
		public function menuButton(text:String="", spriteEnable:Boolean=false, color:uint=0x00ffcc, bold:Boolean=true, size:int=24, font:String="Arial", x:Number=80, y:Number=5, _width:int=150):void
		{		
			if (spriteEnable)
			{
				addChild(bg);
				bg.x = x-10;
				bg.y = y;
			}
			
			var label:TextField = new TextField();
			var format:TextFormat = new TextFormat();
			format.font=font;
			format.color= color;
          	format.size= size;
			format.bold= bold;
			label.defaultTextFormat = format;
          	label.setTextFormat(format);
			label.text = text;
			label.x = x;
			label.y = y;
			label.width=_width;
			label.height=50;
			addChild(label);
			label.mouseEnabled = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHendler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHendler);
		}
		
		private function mouseOutHendler(e:MouseEvent):void 
		{
			Mouse.cursor = "auto";
		}
		
		private function mouseOverHendler(e:MouseEvent):void 
		{
			Mouse.cursor = "button";
		}
	}
	
}