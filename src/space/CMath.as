package space
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Codir
	 */
	public final class CMath
	{
		
		public static function getDistance(x:Number, y:Number, x1:Number, y1:Number):Number {
			if (x && y && x1 && y1)
				return Math.round(Point.distance(new Point(x, y), new Point(x1, y1)));
			else
				return 0;
		}

		/**
		 * Возвращает угол между двумя точками радианах.
		 * 
		 * @param x1, y1 - координаты первой точки.
		 * @param x2, y2 - координаты второй точки.
		 * 
		 * @return угол между двумя точками в радианах.
		 */
		public static function getAngle(x1:Number, y1:Number, x2:Number, y2:Number, norm:Boolean = true):Number
		{
			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;
			var angle:Number = Math.atan2(dy, dx);
			
			if (norm)
			{
				if (angle < 0)
				{
					angle = Math.PI * 2 + angle;
				}
				else if (angle >= Math.PI * 2)
				{
					angle = angle - Math.PI * 2;
				}
			}
			
			return angle;
		}
		
		/**
		 * Возвращает угол между двумя точками в градусах.
		 * 
		 * @param x1, y1 - координаты первой точки.
		 * @param x2, y2 - координаты второй точки.
		 * 
		 * @return угол между двумя точками в градусах.
		 */
		public static function getAngleDeg(x1:Number, y1:Number, x2:Number, y2:Number, norm:Boolean = true):Number
		{
			var dx:Number = x2 - x1;
			var dy:Number = y2 - y1;
			var angle:Number = Math.atan2(dy, dx) / Math.PI * 180;
			
			if (norm)
			{
				if (angle < 0)
				{
					angle = 360 + angle;
				}
				else if (angle >= 360)
				{
					angle = angle - 360;
				}
			}
			
			return angle;
		}
		
		public static function gradToRad(angle:Number):Number
		{
			if (angle)
				return angle * Math.PI / 180;
			else
				return 0;
		}
		
		public static function radToGrad(rad:Number):Number
		{
			if(rad)
				return rad * 180 / Math.PI;
			else
				return 0;
		}
		
		/**
		 * Возвращает случайное число в диапазоне от lower до upper.
		 * 
		 * @param lower - наименьшее число диапазона.
		 * @param upper - наибольшее число диапазона.
		 * 
		 * @return случайное целое число.
		 */
		public static function random(lower:Number, upper:Number):Number
		{
			return Math.round(Math.random() * (upper - lower)) + lower;
		}
		
		/**
		 * Сравнивает два значения с заданной погрешностью.
		 * 
		 * @param a, b - сравниваемые значения.
		 * @param diff - допустимая погрешность.
		 * 
		 * @return возвращает true если значения равны, или false если не равны.
		 */
		public static function equal(a:Number, b:Number, diff:Number = 0.00001):Boolean
		{
			return (Math.abs(a - b) <= diff);
		}
	}

}