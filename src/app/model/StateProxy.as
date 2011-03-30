package app.model
{
	import app.AppFacade;
	import app.model.vo.Photo;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class StateProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "StateProxy";
		
		private var _currentPhoto:Photo;
		
		
		public function StateProxy()
		{
			super(NAME);
		}
		
		public function get currentPhoto():Photo
		{
			return _currentPhoto;
		}
		
		public function set currentPhoto(photo:Photo):void
		{
			//if (photo == null || photo == _currentPhoto) return;
			
			_currentPhoto = photo;
			
			facade.sendNotification( AppFacade.PHOTO_CHANGED, _currentPhoto );
		}
	}
}