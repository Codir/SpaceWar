package space.UI
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Codir
	 */
	public class TextLabel extends Sprite 
	{
		public var label:TextField;
		
		public function TextLabel(text:String="",color:uint=0xFFF500,bold:Boolean=false,size:int=12,font:String="Comic Sans MS",w:int=400,h:int=0):void
		{
			label = new TextField();
			var format:TextFormat = new TextFormat();
			format.font=font;
			format.color= color;
          	format.size= size;
			format.bold= bold;
			label.defaultTextFormat = format;
          	label.setTextFormat(format);
			label.text = text;
			label.x=0;
			label.y = 0;
			label.width=w;
			if(h>0)label.height=h;
			addChild(label);
			
			label.selectable = false;
		}
	}
	
}