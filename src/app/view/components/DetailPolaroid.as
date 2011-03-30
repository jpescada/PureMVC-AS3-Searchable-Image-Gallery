package app.view.components
{
	import app.model.vo.Photo;
	
	import com.greensock.OverwriteManager;
	import com.greensock.TweenLite;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Quart;
	import com.greensock.easing.Back;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import lib.utils.DisplayObj;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class DetailPolaroid extends Sprite
	{
		public var bg:MovieClip;
		public var holder:MovieClip;
		public var txt:TextField;
		
		private var _loader:Loader;
		private var _photo:Photo;
		private var _positionLocked:Boolean = true;
		private var _position:Point;
		
		
		public function DetailPolaroid()
		{
			super();
			
			if (stage) _init();
			else addEventListener( Event.ADDED_TO_STAGE, _init, false, 0, true );
		}
		
		public function show( photo:Photo, delay:Number ):void
		{
			_photo = photo;
			_load();
			_positionLocked = false;
			
			TweenLite.killTweensOf( this );
			TweenLite.to( this, 1, {x:_position.x, y:_position.y, ease:Quart.easeOut, delay:delay} );
		}
		
		public function hide():void
		{
			_positionLocked = true;
			
			TweenLite.killTweensOf( this );
			TweenLite.to( this, 0.5, {
				x:_position.x, 
				y:_position.y + stage.stageHeight,
				ease:Back.easeIn,
				onComplete:function():void{ holder.alpha = 0; y = _position.y + stage.stageHeight; }
			} );
		}
		
		public function updateSize(w:int, h:int):void
		{
			_position.x = Math.round(w * .5);
			_position.y = Math.round(h * .5);
			
			x = _position.x;
			
			if (!_positionLocked)
			{
				y = _position.y;
			}
			else
			{
				y = _position.y + stage.stageHeight;
			}
		}
		
		private function _init(evt:Event=null):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, _init );
			
			OverwriteManager.init( OverwriteManager.AUTO );
			_position = new Point();
			_positionLocked = true;			
			updateSize( stage.stageWidth, stage.stageHeight );			
		}
		
		private function _load():void
		{			
			txt.text = _photo.title;
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _handlePhotoLoaded );
			_loader.load( new URLRequest( _photo.urlLarge ) );
		}
		
		private function _handlePhotoLoaded(evt:Event):void
		{
			DisplayObj.removeAllChildren( holder );
			
			var bmp:Bitmap = new Bitmap(evt.target.content.bitmapData);
			bmp.smoothing = true;
			holder.addChild( bmp );
			
			TweenLite.to( holder, 0.5, {alpha:1} );
		}
	}
}