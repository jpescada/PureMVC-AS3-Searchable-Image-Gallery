package app.view.components
{
	import app.model.vo.Photo;
	
	import com.greensock.OverwriteManager;
	import com.greensock.TweenLite;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class Gallery extends Sprite
	{
		private var _result:Array;
		private var _polaroids:Array;
		private var _detailMode:Boolean;
		
		public function Gallery()
		{
			super();
			
			if (stage) _init();
			else addEventListener( Event.ADDED_TO_STAGE, _init, false, 0, true );
		}
		
		public function load(result:Array):void
		{
			if (_polaroids && _polaroids.length > 0) _clear();
			
			_result = result;
			_polaroids = [];
			
			var len:int = _result.length;
			for (var i:int = 0; i < len; i++)
			{
				var polaroid:Polaroid = new Polaroid( _result[i] as Photo );
				addChild( polaroid );
				_polaroids.push( polaroid );
			}
		}
		
		public function set detailMode(bool:Boolean):void
		{
			_detailMode = bool;
			
			if (bool)
			{
				_disableAll();
			}
			else
			{
				_enableAll();
			}
		}
		
		public function updateSize(w:int, h:int):void
		{
			x = Math.round((w - width) * .5);
			y = Math.round((h - height) * .5);
		}
		
		private function _init(evt:Event=null):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, _init );
			
			OverwriteManager.init( OverwriteManager.AUTO );
			TweenPlugin.activate( [BlurFilterPlugin] );
			
			updateSize( stage.stageWidth, stage.stageHeight );
		}
		
		private function _enableAll():void
		{
			var len:int = _polaroids.length;
			for (var i:int = 0; i < len; i++)
			{
				var polaroid:Polaroid = _polaroids[i] as Polaroid;
				if (polaroid.isHidden) polaroid.show();
				polaroid.enable(true);				
			}
		}
		
		private function _disableAll():void
		{
			var len:int = _polaroids.length;
			for (var i:int = 0; i < len; i++)
			{
				var polaroid:Polaroid = _polaroids[i] as Polaroid;
				polaroid.disable(true);
			}
		}
		
		private function _clear():void
		{
			var len:int = _polaroids.length;
			for (var i:int = 0; i < len; i++)
			{
				var polaroid:Polaroid = _polaroids[i] as Polaroid;
				polaroid.hide(true);
			}
		}
	}
}