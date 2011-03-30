package app.model
{
	import app.AppFacade;
	
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class StageProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "StageProxy";
		private var _timer:Timer;
		
		public function StageProxy(data:Stage)
		{
			super(NAME, data);
						
			_init();
		}
		
		public function get stage():Stage
		{
			return getData() as Stage;
		}
		
		public function get stageWidth():int
		{
			return stage.stageWidth;
		}
		
		public function get stageHeight():int
		{
			return stage.stageHeight;
		}
		
		private function _init():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode	= StageScaleMode.NO_SCALE;
			stage.showDefaultContextMenu = false;
			
			stage.addEventListener( Event.RESIZE, _handleStageResize );
		}
		
		private function _handleStageResize(evt:Event=null):void
		{
			facade.sendNotification( AppFacade.STAGE_RESIZE, this );
		}
	}
}