package app.view.components
{
	import com.greensock.TweenLite;
	import com.greensock.plugins.AutoAlphaPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	import lib.events.UIEvent;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class SearchBox extends Sprite
	{
		public static const NAME:String = "SearchBox";
		public static const SUBMIT:String = NAME + "_Submit";
		
		public var base:MovieClip;
		public var btn:SimpleButton;
		public var txtBg:MovieClip;
		public var txt:TextField;
		
		private const _DEFAULT_TEXT:String = "search for photos";
		private const _DEFAULT_COLOR:int = 0xCCCCCC;
		private const _ACTIVE_COLOR:int = 0x666666;
		private var _position:Point;
		private var _positionLocked:Boolean;
		
		
		public function SearchBox()
		{
			super();
			
			if (stage) _init();
			else addEventListener( Event.ADDED_TO_STAGE, _init, false, 0, true );
		}
		
		public function updateSize(w:int, h:int):void
		{
			_position.x = Math.round((w - width) * .5);
			_position.y = 10;
			
			x = _position.x;
			
			if (!_positionLocked)
			{
				y = _position.y;
			}
			else
			{
				y = - 300;
			}
		}
		
		public function showStatus():void
		{
			TweenLite.killTweensOf( base.status );
			TweenLite.to( base.status, 0.3, {y:20} );
		}
		
		public function hideStatus():void
		{
			TweenLite.killTweensOf( base.status );
			TweenLite.to( base.status, 0.3, {y:0} );
		}
		
		private function _init(evt:Event=null):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, _init );
			
			TweenPlugin.activate( [AutoAlphaPlugin] );
			_addListeners();
			
			btn.alpha = 0;
			btn.visible = false;
			
			base.status.y = 0;
			
			txt.restrict = "a-zA-Z 0-9";
			
			_position = new Point();
			_positionLocked = true;	
			updateSize( stage.stageWidth, stage.stageHeight );
			
			_show();
		}
		
		private function _show():void
		{
			_positionLocked = false;
			TweenLite.to( this, 1, {y:_position.y} );
		}
		
		private function _addListeners():void
		{
			txt.addEventListener( FocusEvent.FOCUS_IN, _handleFocusIn );
			txt.addEventListener( FocusEvent.FOCUS_OUT, _handleFocusOut );
			
			
			btn.addEventListener( MouseEvent.CLICK, _handleButtonClick );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, _handleKeyDown );
		}
		
		private function _handleFocusIn(evt:FocusEvent):void
		{
			if (txt.text == _DEFAULT_TEXT)
			{
				txt.text = "";
				txt.textColor = _ACTIVE_COLOR;
				
				TweenLite.killTweensOf( btn );
				TweenLite.to( btn, 0.2, {autoAlpha:1} );
			}			
		}
		
		private function _handleFocusOut(evt:FocusEvent):void
		{
			if (txt.text == "")
			{
				txt.text = _DEFAULT_TEXT;
				txt.textColor = _DEFAULT_COLOR;
				
				TweenLite.killTweensOf( btn );
				TweenLite.to( btn, 0.2, {autoAlpha:0} );
			}
		}
		
		private function _handleKeyDown(evt:KeyboardEvent):void
		{
			if (evt.keyCode == Keyboard.ENTER && stage.focus == txt )
			{
				_dispatchSubmit();
			}
		}
		
		private function _handleButtonClick(evt:MouseEvent):void
		{
			_dispatchSubmit();
		}
		
		private function _dispatchSubmit():void
		{
			hideStatus();
			
			var query:String = (txt.text != _DEFAULT_TEXT) ? txt.text : "";
			dispatchEvent( new UIEvent( SearchBox.SUBMIT, query ) );
		}
	}
}