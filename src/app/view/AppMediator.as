package app.view
{
	import app.Main;
	
	import flash.display.DisplayObject;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class AppMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "AppMediator";
		
		
		public function AppMediator(main:DisplayObject)
		{
			super(NAME, main);
			
			facade.registerMediator( new GalleryMediator( (main as Main).gallery ) );
			facade.registerMediator( new SearchBoxMediator( (main as Main).searchBox ) );
			facade.registerMediator( new DetailMediator( (main as Main).detail ) );
		}
	}
}