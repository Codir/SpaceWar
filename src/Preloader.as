package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.utils.ByteArray;
	import mx.core.ByteArrayAsset;
	import space.UI.menuButton;
	import space.UI.TextLabel;
	
	/**
	 * ...
	 * @author Codir
	 */
	[SWF(width = '650', height = '420', backgroundColor = "0x000000")]
	public class Preloader extends MovieClip 
	{
		private var playBattonFlag:Boolean = false;
		
		public var loadbar:TextLabel = new TextLabel("0%", 0x191100, true, 26, "Arial", 100, 0);
		public var playBatton:menuButton = new menuButton("Play", false, 0xFFAD00, true, 36);
		public var loader:Loader = new Loader;
		public var img:MovieClip;
		
		[Embed(source = "assets/MovieClips/loadIndicator.swf", mimeType = "application/octet-stream")]
		public static const loadIndicator:Class;
		
		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			var classVar:Class = getDefinitionByName( "Preloader_loadIndicator") as Class;
			var swfImg:ByteArrayAsset = new classVar();
			
			loader.contentLoaderInfo.addEventListener(Event.INIT,loadCompleteListener,false,0,true);
			loader.loadBytes(swfImg);
			
			addChild(loadbar);
			loadbar.x = 280;
			loadbar.y = 200;
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			var percent:int = Math.round(e.bytesLoaded / (e.bytesTotal/100));
			loadbar.label.text = percent + "%";
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			playBattonFlag = true;
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			if(img)
			removeChild(img);
			removeChild(loadbar);
			loadbar = null;
			addChild(playBatton);
			playBatton.x = 200;
			playBatton.y = 200;
			
			playBatton.addEventListener(MouseEvent.CLICK, playGame);
		}
		
		private function playGame(e:MouseEvent):void
		{
			removeChild(playBatton);
			playBatton = null;
			var mainClass:Class = getDefinitionByName("Game") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
		private function loadCompleteListener(e:Event):void {
			if (!playBattonFlag)
			{
				img = MovieClip(loader.content);
				addChild(img);
				img.x = 230;
				img.y = 158;
				removeChild(loadbar);
				addChild(loadbar);
			}
		}
		
	}
	
}