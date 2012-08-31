package space
{
        import flash.display.Bitmap;
        import flash.display.BitmapData;
        import flash.display.BitmapDataChannel;
        import flash.display.Sprite;
        import flash.events.Event;
        import flash.events.KeyboardEvent;
        import flash.geom.ColorTransform;
        import flash.geom.Matrix;
        import flash.geom.Point;
        import flash.geom.Rectangle;
        import flash.system.System;
        import flash.ui.Keyboard;
        import flash.utils.getTimer;
        import space.RND;
		import space.DeepSpaceParticle;
        
        /**
         * ...
         * @author plasma_trip
         */
        public class DeepSpace extends Sprite
        {
                private const noiseW:int = 180;
                private const noiseH:int = 120;
                private const dsWidth:int = 800;
                private const dsHeight:int = 600;
                private const starCount:int = 100;
                
                private var noiseContainer:Bitmap;
                private var starsContainer:Bitmap;
                private var stars:BitmapData;
                private var noise:BitmapData;
                private var colorTransform:ColorTransform;
                private var channels:uint;
                private var m:Matrix;
                private var offset:int;
                private var point:Point;
                private var seed:int;
                private var particles:Vector.<DeepSpaceParticle>;
                private var arr:Array;
                private var starsRect:Rectangle;
                private var noiseRect:Rectangle;
                private var destPoint:Point;
				
                public function DeepSpace():void
                {
                        if (stage) init();
                        else addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
                }
                
                private function init(e:Event = null):void
                {
                        removeEventListener(Event.ADDED_TO_STAGE, init);
                        
                        noiseRect = new Rectangle(0, 0, noiseW, noiseH);
                        starsRect = new Rectangle(0, 0, dsWidth, dsHeight);
                        destPoint = new Point(0, 0);
                        //колорТрансформ для изменения цвета шума
                        colorTransform = new ColorTransform(0.5, 0.4, 0.5, 1, -48, -48, -48, 0);
                        //какие каналы будут участвовать в формировании шума
                        channels = BitmapDataChannel.RED | BitmapDataChannel.BLUE | BitmapDataChannel.GREEN | BitmapDataChannel.ALPHA;
                        //матрица для скейла шума до необходимого размера
                        m = new Matrix(dsWidth / noiseW, 0, 0, dsHeight / noiseH);
                        point = new Point(0, 0);
                        //массив точек смешения октав
                        arr = [point, point, point, point];
                        RND.seed = 0;
                        //случайное начальное значение, используемое для создания случайных числел функцией шума Перлина
                        seed = RND.getInt(1, 100);
                        offset = 1;

                        //создаем контейнеры в которые будем выводить всю прелесть и битмапДаты для звезд и шума
                        noiseContainer = new Bitmap(new BitmapData(dsWidth, dsHeight, false, 0xFF000000));
                        noiseContainer.transform.matrix = m;
                        starsContainer = new Bitmap(new BitmapData(dsWidth, dsHeight, true, 0x00000000));
                        stars = new BitmapData(dsWidth, dsHeight, true, 0x00000000);
                        noise = new BitmapData(noiseW, noiseH, false, 0xFF000000);
                        
                        particles = new Vector.<DeepSpaceParticle>(starCount, true);
                        var i:int = starCount;
                        while ( --i > -1)
                        {
                                particles[i] = new DeepSpaceParticle();
                                particles[i].setParticle(RND.getInt(0, dsWidth), RND.getInt(0, dsHeight));
                        }
                        
                        addChild(noiseContainer);
                        addChild(starsContainer);
						updateBg();
                }
				
				public function updateBg():void
				{
                        
                        //лочим контейнеры, что бы не перерисовывался флешем во время изменений
                        noiseContainer.bitmapData.lock();
                        starsContainer.bitmapData.lock();

						
                        //собственно генерируем сам шум
                        noise.perlinNoise(noiseW, noiseH, 4, seed, false, true, channels, false, arr);
                        noise.colorTransform(noiseRect, colorTransform);
                        //очишаем битмапДату звезд
                        stars.fillRect(starsRect, 0);
                        //рисуем звезды
                        var i:int = starCount;
                        while ( --i > -1)
                        {
                                var particle:DeepSpaceParticle = particles[i];
								
                                stars.setPixel32(particle.x, particle.y, particle.color)
                                if (particle.x < 0) particle.setParticle(dsWidth, RND.getInt(0, dsHeight));
                                if (particle.x > dsWidth) particle.setParticle(0, RND.getInt(0, dsHeight));
                                if (particle.y < 0) particle.setParticle(RND.getInt(0, dsWidth), dsHeight);
                                if (particle.y > dsHeight) particle.setParticle(RND.getInt(0, dsWidth), 0);
                        }
                        //рисуем в контейнер шум и звезды
                        noiseContainer.bitmapData.copyPixels(noise, starsRect, destPoint);
                        starsContainer.bitmapData.copyPixels(stars, starsRect, destPoint);
                        //разлочим контейнеры
                        noiseContainer.bitmapData.unlock();
                        starsContainer.bitmapData.unlock();
					
				}
        }
        
}
