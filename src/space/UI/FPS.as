package space.UI
{
	import flash.system.System;
	import flash.text.TextField;
	import flash.display.Sprite;
	import flash.utils.getTimer;
	import flash.events.*;

   public class FPS extends Sprite
   {
      private var fMillisecond:uint;
      private var sMillisecond:uint;
      private var frameCount:Number;
	  private var maxFPS:Number=0;
      private var lastMeasure:Number;
      private var output:String;
      private var counterDisplay:TextField;

      public function FPS()
      {
         counterDisplay=new TextField();
		 counterDisplay.selectable = false;
		 counterDisplay.textColor = 0xFFFFFF;
         addChild(counterDisplay);
         fMillisecond=getTimer();
         sMillisecond=fMillisecond+1000;
         frameCount=0;
         output="--";
         lastMeasure=0;
         addEventListener(Event.ENTER_FRAME, enterFrame);
      }

      private function enterFrame(event:Event):void
      {
         updateCounter();
      }

      private function updateCounter():void
      {
         fMillisecond=getTimer();
         if (fMillisecond>sMillisecond)
         {
            var fps:Number = frameCount / (fMillisecond - sMillisecond + 1000) * 1000;
			maxFPS = (maxFPS+fps)/2;
			
            sMillisecond=fMillisecond+1000;
            frameCount=0;
            if (lastMeasure!=fps)
            {
               lastMeasure=fps;
               output = "FPS : " + fps.toFixed(1)+"/"+Math.round(maxFPS)+"\nMemory: "+usedMemory()+"Mb";// + "\nParticles: " + S_ParticleEmitter.active_particles_count.toFixed(1);
            }
         }
         else
         {
            frameCount+=1;
         }
         counterDisplay.text=output;
      }
	  
	  private function usedMemory():int
	  {
		  return Math.round((System.totalMemory/1024)/1024);
	  }
   }
}