package org.flashmonkey.operations.service
{    
    import flash.events.Event;
    
    public class XmlFileWriteOperation extends AbstractOperation
    {
        /** The URL to be written to by this operation. */
        [Bindable]
        public var url:String;
        
        /** The XML to be written by this operation. */
        [Bindable]
        public var data:*;
        
        /**
         * Construct an XmlFileWriteOperation
         * @param url the URL to write to
         * @param data the data to use for the request.  If data is
         * of type String or XML, it is saved as the body of the file.
         */
        public function XmlFileWriteOperation(url:String, data:* = null)
        {
            this.url = url;
            this.data = data;
        }
        
        /**
         * Initiate this operation by performing the HTTP request.
         * If any value among the parameters is XML, it is prettyprinted.
         */
        override public function execute():void
        {
           /* var file:File = new File();
            file.url = url;
            var out:FileStream = new FileStream();
            out.open(file, FileMode.WRITE);
            
            if (data is XML)
            {
                out.writeUTFBytes((data as XML).toXMLString());
                out.writeUTFBytes("\n");
            }
            else if (data is String)
            {
                out.writeUTFBytes(data);
            }

            out.close();*/
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }
}