package app.view.components
{
	import app.model.vo.Photo;
	
	import com.greensock.OverwriteManager;
	import com.greensock.TweenLite;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.DropShadowFilterPlugin;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import lib.events.UIEvent;
	import lib.utils.Math2;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class Polaroid extends Sprite
	{
		public static const NAME:String = "Polaroid";
		public static const CLICK:String = NAME + "_Click";
		
		public var holder:MovieClip;
		public var bg:MovieClip;
		public var isHidden:Boolean;
		
		private var _photo:Photo;
		private var _loader:Loader;
		private var _lockedStatus:Boolean;
		
		
		public function Polaroid(photo:Photo)
		{
			super();
			
			_photo = photo;
			
			if (stage) _init();
			else addEventListener( Event.ADDED_TO_STAGE, _init, false, 0, true );
		}
		
		public function show():void
		{
			parent.setChildIndex( this, parent.numChildren-1 );
			
			TweenLite.killTweensOf( this );
			
			if (mouseEnabled == false)
			{
				x = Math.round( stage.stageWidth * .5 );
				y = Math.round( stage.stageHeight + 200 );
			}
			
			TweenLite.to( this, Math2.randRange(0.8,1.4), 
			{
				x:Math2.randRange(100,860), 
				y:Math2.randRange(150,500), 
				rotation:Math2.randRange(-45,45),
				scaleX:1,
				scaleY:1,
				onComplete:function():void{ isHidden = false; enable(); }
			});
			
			TweenLite.killTweensOf( bg );
			TweenLite.to( bg, 0.2, { dropShadowFilter:{distance:1, blurX:8, blurY:8} } );
		}
		
		public function hide(destroy:Boolean=false, invertDirection:Boolean=false):void
		{
			disable();
			
			var targetY:int = invertDirection ? stage.stageHeight+300 : -stage.stageHeight+300;
			TweenLite.killTweensOf( this );
			TweenLite.to( this, 0.5, 
			{
				x:Math2.randRange(200,760), 
				y:targetY, 
				rotation:Math2.randRange(-90,90),
				scaleX:1,
				scaleY:1,
				onComplete:function():void{ isHidden = true; if (destroy) _destroy(); }
			});
			
			TweenLite.killTweensOf( bg );
			TweenLite.to( bg, 0.2, { dropShadowFilter:{distance:1, blurX:8, blurY:8} } );
		}
		
		public function enable(force:Boolean=false):void
		{
			if (force) _lockedStatus = false;
			
			if (_lockedStatus) return;
			
			isHidden = false;
				
			mouseEnabled = true;
			
			addEventListener( MouseEvent.MOUSE_OVER, _handleMouseOver );
			addEventListener( MouseEvent.MOUSE_OUT, _handleMouseOut );
			addEventListener( MouseEvent.CLICK, _handleMouseClick );
		}
		
		public function disable(force:Boolean=false):void
		{
			if (force) _lockedStatus = true;
			
			mouseEnabled = false;
			
			removeEventListener( MouseEvent.MOUSE_OVER, _handleMouseOver );
			removeEventListener( MouseEvent.MOUSE_OUT, _handleMouseOut );
			removeEventListener( MouseEvent.CLICK, _handleMouseClick );
		}
		
		private function _destroy():void
		{
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, _handlePhotoLoaded );
			
			removeEventListener( MouseEvent.MOUSE_OVER, _handleMouseOver );
			removeEventListener( MouseEvent.MOUSE_OUT, _handleMouseOut );
			removeEventListener( MouseEvent.CLICK, _handleMouseClick );
			
			parent.removeChild( this );
		}
		
		private function _init(evt:Event=null):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, _init );
			
			OverwriteManager.init( OverwriteManager.AUTO );
			TweenPlugin.activate( [DropShadowFilterPlugin] );
			
			x = Math.round( stage.stageWidth * .5 );
			y = Math.round( stage.stageHeight + 200 );
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _handlePhotoLoaded );
			_loader.load( new URLRequest( _photo.urlSmall ) );
			
			buttonMode = true;
			mouseChildren = false;
			
			addEventListener( MouseEvent.MOUSE_OVER, _handleMouseOver );
			addEventListener( MouseEvent.MOUSE_OUT, _handleMouseOut );
			addEventListener( MouseEvent.CLICK, _handleMouseClick );
			
			isHidden = true;
			disable();
		}
		
		private function _handlePhotoLoaded(evt:Event):void
		{
			var bmp:Bitmap = new Bitmap(evt.target.content.bitmapData);
			bmp.smoothing = true;
			holder.addChild( bmp );
			bmp.x = - Math.round( bmp.width * .5 );
			bmp.y = - Math.round( bmp.height * .5 );
			
			show();
		}
		
		private function _handleMouseOver(evt:MouseEvent):void
		{
			parent.setChildIndex( this, parent.numChildren-1 );
			
			TweenLite.killTweensOf( this );
			TweenLite.to( this, 0.2, {scaleX:1.1, scaleY:1.1} );
			TweenLite.killTweensOf( bg );
			TweenLite.to( bg, 0.2, { dropShadowFilter:{distance:5, blurX:15, blurY:15} } );
		}
		
		private function _handleMouseOut(evt:MouseEvent):void
		{
			TweenLite.killTweensOf( this );
			TweenLite.to( this, 0.2, {scaleX:1, scaleY:1} );
			TweenLite.killTweensOf( bg );
			TweenLite.to( bg, 0.2, { dropShadowFilter:{distance:1, blurX:8, blurY:8} } );
		}
		
		private function _handleMouseClick(evt:MouseEvent):void
		{
			disable();
			hide( false, true );
			trace("@ "+ NAME +"._handleMouseClick() | id: "+ _photo.id);
			dispatchEvent( new UIEvent( Polaroid.CLICK, _photo ) );
		}
	}
}