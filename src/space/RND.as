package space
{

        public class RND {
                static private var pSeed:uint;
                
                static public function set seed(val:uint):void {
                        if (val != 0) pSeed = val;
                        else pSeed = uint(Math.random() * uint.MAX_VALUE);
                }
                static public function get seed():uint {
                        return pSeed;
                }
                static public function getInt(min:int, max:int):int {
                        pSeed = 214013 * pSeed + 2531011;
                        return min + (pSeed ^ (pSeed >> 15)) % (max - min + 1);
                }
                static public function getFloat(min:Number, max:Number):Number {
                        pSeed = 214013 * pSeed + 2531011;
                        return min + (pSeed >>> 16) * (1.0 / 65535.0) * (max - min);
                }
        }
}