package space 
{
	import Box2D.Common.Math.b2Vec2;
	import flash.utils.getDefinitionByName;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author Codir
	 */
	public class Weapon 
	{
		public var ammoType:String;
		public var power:int;
		public var state:DEngine;
		public var RoF:int;
		public var cooldown:Boolean = true;
		public var cooldownTimer:Timer;
		public var shots:int = -1;
		public var ammoSize:int = 2;
		public var turret:Boolean;

		public function Weapon(_power:int, _ammoSize:int, _RoF:int, _ammoType:String, _state:DEngine, _turret:Boolean = true)
		{
			turret = _turret;
			RoF = _RoF;
			power=_power;
			ammoType = _ammoType;
			ammoSize = _ammoSize;
			state = _state;
			cooldownTimer = new Timer(60000 / RoF);
			cooldownTimer.addEventListener(TimerEvent.TIMER, cooldownTimerHendler);
		}

		public function fire():void
		{
			if (cooldown&&(shots>0||shots==-1))
			{
				cooldown = false;
				cooldownTimer.start();
				var impulse:b2Vec2 = new b2Vec2();
				if (turret) {
				impulse.x = power * Math.cos(CMath.gradToRad(state.shipObj[state.hero].gun.rotation-90));
				impulse.y = power * Math.sin(CMath.gradToRad(state.shipObj[state.hero].gun.rotation - 90));
				} else {
				impulse.x = power * Math.cos(state.shipObj[state.hero].body.GetAngle());
				impulse.y = power * Math.sin(state.shipObj[state.hero].body.GetAngle());	
				}
				
				var x:Number = state.shipObj[state.hero].body.GetPosition().x*state.worldScale + 40;
				var y:Number = state.shipObj[state.hero].body.GetPosition().y * state.worldScale + 40;
				
				var position:b2Vec2 = new b2Vec2(x, y);
				var classVar:Class = getDefinitionByName("space::" + ammoType) as Class;
				new classVar(position, ammoSize, '', impulse, state.world,  state.worldScale, state, 1000);
			}
		}
		
		private function cooldownTimerHendler(e:Event):void 
		{
			cooldown = true;
			cooldownTimer.stop();
		}
		
		public function addShots(_shots:int):void
		{
			if (shots!=-1) 
				shots += _shots;
		}
		
		public function reduceShots(_shots:int):void
		{
			if (shots > 0) 
				shots -= _shots;
		}
		
	}

}