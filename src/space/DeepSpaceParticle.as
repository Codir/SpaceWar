package space 
{
	/**
	 * ...
	 * @author Codir
	 */
	public class DeepSpaceParticle
	{
			public var x:int = 0;
			public var y:int = 0;
			public var v:int = 0;
			public var color:uint;
			
			public function DeepSpaceParticle()
			{
			}
			
			public function setParticle(setX:int, setY:int):void
			{
					x = setX;
					y = setY;
					v = RND.getInt(1, 10);
					color = (51 * v - 255) << 24 | 0xFF << 16 | 0xFF << 8 | 0xFF;
			}
	}

}