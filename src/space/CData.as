package  space
{
	import flash.net.*;
	/**
	 * ...
	 * @author Codir
	 */
	public class CData
	{
		private static var _instance:CData= new CData();
		public var cookies:SharedObject = SharedObject.getLocal("MoonDelivery");
		public var ships:Array=new Array();

		public var currentShip:int=1;
		public var currentLevel:int = 0;		
		
		public var maxShip:int=4;
		public var maxLevel:int = 15;		
		
		public var musicOn:Boolean = true;
		public var soundOn:Boolean = true;
		public var fistOn:Boolean = true;
		
		public function CData() 
		{
			init();
			if (_instance != null)
            {
                throw new Error("Singleton can only be accessed through Singleton.instance");
            }
		}
		
		private function init():void 
		{
			if(!getUserLevelData())
			{
				var levels:Array=new Array();
				for(var i:int=0;i<15;i++)
				levels[i]=0;
				setUserLevelData(levels);
			}
		}
		
		public static function get instance():CData
        {
            return _instance;
        }
		
		
		public function getUserLevelData():Array
		{
		   return cookies.data.userLevelData;
		}

		public function setUserLevelData(obj:Array):Boolean
		{
		   return Boolean(cookies.data.userLevelData=obj);
		}
		
		public function setLevelData(score:int):Boolean
		{
		   var levelData:Array = getUserLevelData();
		   if (levelData[currentLevel-1] < score) levelData[currentLevel-1] = score;
		   return Boolean(cookies.data.userLevelData=levelData);
		}
		
		public function getAllScores():int
		{
			var totalScores:int = 0;
			var levelData:Array = getUserLevelData();
			
			if (levelData)
			{
				for (var i:int = 0; i < levelData.length; i++ )
				{
					totalScores += levelData[i];
				}
			}
			
			return totalScores;
		}	
	}

}