package org.flashmonkey.operations.event
{
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    
    /**
     * This event indicates the availability of an event dispatcher that subsequently
     * may be expected to dispatch ProgressEvents that report on the progress of some
     * asynchronous data loading operation.
     */
    public class ProgressSourceEvent extends Event
    {
        public static const PROGRESS_START:String = "progressStart";
        
        public var source:IEventDispatcher;
        
        public var sourceName:String;
        
        public function ProgressSourceEvent(type:String, source:IEventDispatcher, sourceName:String)
        {
            super(type);
            this.source = source;
            this.sourceName = sourceName;
        }
        
        override public function clone():Event
        {
            return new ProgressSourceEvent(type, source, sourceName);
        }
    }
}
