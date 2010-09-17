package org.flashmonkey.operations.service
{
    import flash.events.ErrorEvent;	
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;
    
    [Event(name="complete",type="flash.events.Event")]
    [Event(name="error",type="flash.events.ErrorEvent")]

    /**
     * Operation subclass that performs a REST-style XML-over-HTTP request.  The
     * request itself is a GET of name/value pairs, while the response
     * is expected to be XML.  The method may optionally be specified as POST instead.
     */
    public class XmlHttpOperation extends AbstractOperation
    {
        /** The URL to be requested by this operation. */
        [Bindable]
        public var url:String;
        
        /** The XML returned by this operation. */
        [Bindable]
        public var resultXml:XML;
        
        /** An untyped object containing request parameters to accompany the URL. */
        [Bindable]
        public var data:*;
        
        /** The URLLoader object performing the request on behalf of this operation. */
        [Bindable]
        public var loader:URLLoader;

        /** The method to be used for the operation */
        [Bindable]
        public var method:String = URLRequestMethod.GET;
        
        /**
         * Construct an XmlHttpOperation.
         * @param url the URL to request
         * @param data the data to use for the request.  If data is
         * of type String or XML, it is posted as the body of the document.
         * Otherwise it is treated as an Object whose name-value pairs supply
         * the parameters in a GET or POST.
         */
        public function XmlHttpOperation(url:String, data:* = null)
        {
            this.url = url;
            this.data = data;
        }
        
        /**
         * Initiate this operation by performing the HTTP request.
         * If any value among the parameters is XML, it is prettyprinted and the
         * method is automatically changed to a POST.
         */
        override public function execute():void
        {        	
            var request:URLRequest = new URLRequest(url);
            if (data is XML)
            {
                method = URLRequestMethod.POST;
				
				
                request.data = (data as XML).toXMLString();
            }
            else if (data is String)
            {
                method = URLRequestMethod.POST;
                request.data = data;
            }
            else if (data is Object)
            {
				method = URLRequestMethod.POST;
                var vars:URLVariables = new URLVariables();
				
                for (var p:String in data)
                {
                    var value:* = data[p];
					
                    if (value is XML)
                    {
                        vars[p] = (value as XML).toXMLString();
                    }
                    else
                    {
                        vars[p] = value.toString();
                    }
                }
				
                request.data = vars;
            }

            request.method = method;
			request.contentType="application/x-www-form-urlencoded"
											
            loader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.TEXT;
            loader.addEventListener(Event.COMPLETE, handleResult);
            loader.addEventListener(IOErrorEvent.IO_ERROR, dispatchErrorEvent);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, dispatchErrorEvent);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onStatusEvent);
            loader.load(request);
        }
		
		private function onStatusEvent(e:HTTPStatusEvent):void 
		{
			
		}
        
        /**
         * @inheritDoc 
         */
        override public function get result():*
        {
            return resultXml;
        }
        
        /**
         * Handle the result of the operation.  This is overridden by
         * subclasses to provide special processing prior to handleComplete()
         * including semantic failure detection.
         */
        protected function handleResult(e:Event):void
        {            
            dispatchCompleteEvent(new XML(loader.data));
        }
    }
}
