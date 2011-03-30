package app.controller
{
	import app.model.PhotosProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class PhotoSearchCommand extends SimpleCommand implements ICommand
	{
		override public function execute(notification:INotification):void
		{
			super.execute(notification);
			
			var query:String = notification.getBody() as String;
			
			photosProxy.search( query );
		}
		
		private function get photosProxy():PhotosProxy
		{
			return facade.retrieveProxy( PhotosProxy.NAME ) as PhotosProxy;
		}
	}
}