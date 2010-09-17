package org.flashmonkey.operations.event
{
    import flash.events.ErrorEvent;
    import flash.events.Event;
    
    /**
     * General-purpose wrapper event around different kinds of error, used in the service layer.
     */
    public class OperationFaultEvent extends Event
    {
        public static const FAULT:String = "fault"
        
        public var error:ErrorEvent;
        
        public function OperationFaultEvent(type:String, error:ErrorEvent)
        {
            super(type);
            this.error = error;
        }
        
        override public function clone():Event
        {
            return new OperationFaultEvent(type, error);
        }
    }
}
