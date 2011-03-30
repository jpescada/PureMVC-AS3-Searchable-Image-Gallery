package app.view.components
{
	import app.model.vo.Photo;
	
	import com.greensock.OverwriteManager;
	import com.greensock.TweenLite;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import lib.events.UIEvent;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class Detail extends Sprite
	{
		public static const NAME:String = "Detail";
		public static const SHOW:String = NAME + "_Show";
		public static const HIDE:String = NAME + "_Hide";
		
		public var bg:MovieClip;
		public var polaroid:DetailPolaroid;
		
		private var _photo:Photo;
		
		
		public function Detail()
		{
			super();
			
			if (stage) _init();
			else addEventListener( Event.ADDED_TO_STAGE, _init, false, 0, true );
		}
		
		public function show(photo:Photo):void
		{
			_photo = photo;
			visible = true;
			
			TweenLite.killTweensOf( bg );
			TweenLite.to( bg, 0.5, {autoAlpha:1, delay:0.5} );
			
			polaroid.show( photo, 0.5);
		}
		
		public function hide():void
		{
			polaroid.hide();
			
			TweenLite.killTweensOf( bg );
			TweenLite.to( bg, 0.5, {autoAlpha:0, delay:0.5} );
		}
		
		public function updateSize(w:int, h:int):void
		{
			bg.width = w;
			bg.height = h;
			
			polaroid.updateSize(w, h);
		}
		
		private function _init(evt:Event=null):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, _init );
			
			visible = false;
			hide();
			
			OverwriteManager.init( OverwriteManager.AUTO );
			TweenPlugin.activate( [AutoAlphaPlugin] );
			updateSize( stage.stageWidth, stage.stageHeight );
			
			addEventListener( MouseEvent.CLICK, _handleClick );
		}
		
		private function _handleClick(evt:MouseEvent):void
		{
			dispatchEvent( new UIEvent( Detail.HIDE ) );
		}
	}
}