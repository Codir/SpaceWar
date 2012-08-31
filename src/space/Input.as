package space 
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Codir
	 */
	public class Input 
	{
		private var state:DEngine;
		public var keyboardKeys:Array = new Array();
		public var mouseKeys:Array = new Array();
		
		public function Input(_state:DEngine) 
		{
			state = _state;
			state.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			state.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			state.stage.root.addEventListener(KeyboardEvent.KEY_DOWN, keyboardDownHandler);
			state.stage.root.addEventListener(KeyboardEvent.KEY_UP, keyboardUpHandler);
		}
		
		public function isDown(key:String):Boolean
		{
			if (keyboardKeys[key] != null)
			{
				return keyboardKeys[key];
			}
			else
			{
				return false;
			}
		}
		
		public function isClick(key:String = 'left'):Boolean
		{
			if (mouseKeys[key] != null)
			{
				return mouseKeys[key];
			}
			else
			{
				return false;
			}
		}
		
		private function keyboardUpHandler(e:KeyboardEvent):void 
		{
			switch (e.keyCode)
			{
				case Keyboard.SPACE: keyboardKeys['space'] = false; break;
				default: keyboardKeys[String.fromCharCode(e.charCode)] = false;
			}
		}
		
		private function keyboardDownHandler(e:KeyboardEvent):void 
		{
			switch (e.keyCode)
			{
				case Keyboard.SPACE: keyboardKeys['space'] = true; break;
				default: keyboardKeys[String.fromCharCode(e.charCode)] = true;
			}
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			mouseKeys['left'] = false;
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			mouseKeys['left'] = true;
		}
		
	}

}