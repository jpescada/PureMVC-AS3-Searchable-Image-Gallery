package app.model
{
	import app.AppFacade;
	import app.model.vo.Photo;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * 		
	 * 		@author	Joao Pescada [joaopescada.com | hi@joaopescada.com]
	 * 
	 */
	public class PhotosProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "PhotosProxy";
		
		private const _DATA_URL:String = "assets/xml/photos.xml";
		private var _data:XML;
		private var _query:String;
		private var _result:Array;
		private var _photosList:XMLList;
		private var _photosLen:int;
		
		public function PhotosProxy()
		{
			super(NAME);
		}
		
		public function search(query:String):void
		{
			trace("@ "+ NAME +".search("+ query +")");
			
			_query = query;
			
			if (!_data)
			{
				_loadData();
				return;
			}
			
			_result = [];
			
			// if query is defined, filter photos
			if (_query != null && _query.length > 0)
			{
				var queryWords:Array = _query.split(" ");
				var queryWordsLen:int = queryWords.length;
				
				for (var i:int = 0; i < _photosLen; i++)
				{
					var photoXML:XML = _photosList[i] as XML;
					var photoTags:Array = photoXML.tags.toString().split(" ") as Array;
					var photoTagsLen:int = photoTags.length;
					
					// loop through queryWords
					for (var j:int = 0; j < queryWordsLen; j++)
					{
						// loop through photoTags
						for (var k:int = 0; k < photoTagsLen; k++)
						{
							// compare photoTag with queryWord
							if (photoTags[k] == queryWords[j])
							{
								var photo:Photo = _getPhotoFromXML( photoXML );
								
								// check if photo is already in _result
								if ( _getIndexById( _result, photo.id ) == -1 )
								{
									_result.push( photo );
								}
							}
						}
					}
				}
			}
			// otherwise return all photos
			else
			{
				for (var m:int = 0; m < _photosLen; m++)
				{
					_result.push( _getPhotoFromXML( _photosList[m] ) );
				}
			}
			
			trace("@ "+ NAME +".search("+ query +") | total photos:"+ _result.length);
			sendNotification( AppFacade.PHOTO_SEARCH_RESULT, _result );
		}
		
		public function get result():Array
		{
			return _result;
		}
		
		private function _getIndexById(array:Array, id:String):int
		{
			for (var i:int = 0; i < array.length; i++) 
			{
				if (array[i].id == id) return i;
			}
			return -1;
		}
		
		private function _loadData():void
		{
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest( _DATA_URL );
			
			loader.addEventListener( IOErrorEvent.IO_ERROR, _handleError );
			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, _handleError );
			loader.addEventListener( ProgressEvent.PROGRESS, _handleProgress );
			loader.addEventListener( Event.COMPLETE, _handleComplete );
			
			try
			{
				loader.load( request );
			}
			catch (err:Error)
			{
				trace("@ "+ NAME +"._loadData() | Unable to load "+ request.url.toString() +" ("+ err.errorID +" | "+ err.name +" | "+ err.message +")");
			}
		}
		
		private function _getPhotoFromXML(xml:XML):Photo
		{
			if (!xml) { trace("@ "+ NAME +"._getPhotoFromXML() | invalid xml"); return null; }
			
			var photo:Photo = new Photo();
			photo.id = xml.@id;
			photo.title = xml.title;
			photo.tags = xml.tags;
			photo.urlSmall = Photo.PATH_SMALL + xml.@id +".jpg";
			photo.urlLarge = Photo.PATH_LARGE + xml.@id +".jpg";
				
			return photo;
		}
		
		private function _handleComplete(evt:Event):void
		{
			trace("@ "+ NAME +"._handleComplete()");
			
			_data = new XML( evt.target.data );
			
			_photosList = _data.photos..photo as XMLList;
			_photosLen = _photosList.length();
			
			search( _query );
		}
		
		private function _handleProgress(evt:ProgressEvent):void
		{
			var percent:int = Math.round( ( evt.bytesLoaded / evt.bytesTotal ) * 100 );
			trace("@ "+ NAME +"._handleProgress() | "+ percent +"%");
			// TODO: send notification to update preloader?
		}
		
		private function _handleError(evt:ErrorEvent):void
		{
			trace("@ "+ NAME +"._handleError() | "+ evt.type +" | "+ evt.text);
		}
	}
}