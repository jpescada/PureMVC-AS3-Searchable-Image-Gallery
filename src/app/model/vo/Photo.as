package app.model.vo
{
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class Photo
	{
		public static const PATH_SMALL:String = "assets/photos/small/";
		public static const PATH_LARGE:String = "assets/photos/large/";
		
		public var id:String;
		public var title:String;
		public var tags:String;
		public var urlSmall:String;
		public var urlLarge:String;
		
		public function Photo(){}
	}
}