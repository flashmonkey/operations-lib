package org.flashmonkey.operations.service
{    
    import flash.events.IEventDispatcher;
    
	/**
	 * Dispatched when the current <code>IOperation</code> completed succesfully.
	 * @eventType org.springextensions.actionscript.core.operation.OperationEvent.COMPLETE OperationEvent.COMPLETE
	 */
	[Event(name="operationComplete",type="org.flashmonkey.operations.service.OperationEvent")]
	/**
	 * Dispatched when the current <code>IOperation</code> encountered an error.
	 * @eventType org.springextensions.actionscript.core.operation.OperationEvent.COMPLETE OperationEvent.COMPLETE
	 */
	[Event(name="operationError",type="org.flashmonkey.operations.service.OperationEvent")]
	
	/**
	 * Dispatched after the current <code>IProgressOperation</code> received a progress update.
	 * @eventType org.springextensions.actionscript.core.operation.OperationEvent.PROGRESS OperationEvent.PROGRESS
	 */
	[Event(name="operationProgress",type="org.flashmonkey.operations.service.OperationEvent")]

    /**
     * Interface representing an operation of some sort,
     * probably but not necessarily asynchronous.  Its execute() method
     * initiates it, after which its contract requires that it
     * eventually dispatch either Event.COMPLETE or ErrorEvent.ERROR.
     * 
     */
    public interface IOperation extends IEventDispatcher
    {
        /** Displayable name for this operation */
        function get displayName():String;
        function set displayName(value:String):void;
        
        /** Result object from this operation */
        function get result():*;
		
		function get error():*;
		
		function get progress():uint;
		
		function get total():uint;
        
		/**
		 * Convenience method for adding a listener to the OperationEvent.COMPLETE event.
		 *
		 * @param listener the event handler function
		 */
		function addCompleteListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):IOperation;
		
		/**
		 * Convenience method for adding a listener to the OperationEvent.ERROR event.
		 *
		 * @param listener the event handler function
		 */
		function addErrorListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):IOperation;
		
		/**
		 * Convenience method for removing a listener from the OperationEvent.COMPLETE event.
		 *
		 * @param listener the event handler function
		 */
		function removeCompleteListener(listener:Function, useCapture:Boolean = false):void;
		
		/**
		 * Convenience method for removing a listener from the OperationEvent.ERROR event.
		 *
		 * @param listener the event handler function
		 */
		function removeErrorListener(listener:Function, useCapture:Boolean = false):void;
		
		/**
		 * Convenience method for adding a listener to the OperationEvent.PROGRESS event.
		 *
		 * @param listener the event handler function
		 */
		function addProgressListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		
		/**
		 * Convenience method for removing a listener from the OperationEvent.PROGRESS event.
		 *
		 * @param listener the event handler function
		 */
		function removeProgressListener(listener:Function, useCapture:Boolean = false):void;
		
        /**
         * Initiate this operation.  An event may be dispatched during
         * the execution of this function, or at any point afterwards.
         */
        function execute():void;
    }
}
