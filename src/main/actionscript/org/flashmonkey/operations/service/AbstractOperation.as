package org.flashmonkey.operations.service
{    
    import flash.events.EventDispatcher;
    
    /**
     * Abstract class representing an operation of some sort,
     * probably but not necessarily asynchronous.  Its execute() method
     * initiates it, after which its contract requires that it
     * eventually dispatch either Event.COMPLETE or ErrorEvent.ERROR.
     * 
     */
    public class AbstractOperation extends EventDispatcher implements IOperation
    {
		// --------------------------------------------------------------------
		//
		// Constructor
		//
		// --------------------------------------------------------------------
		
		public function AbstractOperation() {
			super(this);
		}
		
		// --------------------------------------------------------------------
		//
		// Implementation: IOperation: Properties
		//
		// --------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function get result():* {
			return _result;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get error():* {
			return _error;
		}
		
		// --------------------------------------------------------------------
		//
		// Implementation: IProgressOperation: Properties
		//
		// --------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function get progress():uint {
			return _progress;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get total():uint {
			return _total;
		}
		
		// --------------------------------------------------------------------
		//
		// Implementation: IOperation: Methods
		//
		// --------------------------------------------------------------------
		
		/**
		 * @inhertiDoc
		 */
		public function addCompleteListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):IOperation {
			addEventListener(OperationEvent.COMPLETE, listener, useCapture, priority, useWeakReference);
			
			return this;
		}
		
		/**
		 * @inhertiDoc
		 */
		public function addErrorListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):IOperation {
			addEventListener(OperationEvent.ERROR, listener, useCapture, priority, useWeakReference);
			
			return this;
		}
		
		/**
		 * @inhertiDoc
		 */
		public function removeCompleteListener(listener:Function, useCapture:Boolean = false):void {
			removeEventListener(OperationEvent.COMPLETE, listener, useCapture);
		}
		
		/**
		 * @inhertiDoc
		 */
		public function removeErrorListener(listener:Function, useCapture:Boolean = false):void {
			removeEventListener(OperationEvent.ERROR, listener, useCapture);
		}
		
		// --------------------------------------------------------------------
		//
		// Implementation: IProgressOperation: Methods
		//
		// --------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function addProgressListener(listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			addEventListener(OperationEvent.PROGRESS, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeProgressListener(listener:Function, useCapture:Boolean = false):void {
			removeEventListener(OperationEvent.PROGRESS, listener, useCapture);
		}
		
		// --------------------------------------------------------------------
		//
		// Public Properties
		//
		// --------------------------------------------------------------------
		
		// ----------------------------
		// result
		// ----------------------------
		
		private var _displayName:String;
		
		/**
		 * A name for this operation to be shown by the Controller to be shown
		 * to indicate its progress or status.
		 */
		public function get displayName():String
		{
			return _displayName;
		}
		
		public function set displayName(value:String):void
		{
			_displayName = value;
		}
		
		// ----------------------------
		// result
		// ----------------------------
		
		private var _result:*;
		
		/**
		 * Sets the result of this operation.
		 *
		 * @param value the result of this operation
		 */
		public function set result(value:*):void {
			if (value !== result) {
				_result = value;
			}
		}
		
		// ----------------------------
		// error
		// ----------------------------
		
		private var _error:*;
		
		/**
		 * Sets the error of this operation
		 *
		 * @param value the error of this operation
		 */
		public function set error(value:*):void {
			if (value !== error) {
				_error = value;
			}
		}
		
		// ----------------------------
		// progress
		// ----------------------------
		
		private var _progress:uint;
		
		/**
		 * Sets the progress of this operation.
		 *
		 * @param value the progress of this operation
		 */
		public function set progress(value:*):void {
			if (value !== progress) {
				_progress = value;
			}
		}
		
		// ----------------------------
		// total
		// ----------------------------
		
		private var _total:uint;
		
		/**
		 * Sets the total amount of progress this operation should make before being done.
		 *
		 * @param value the total amount of progress this operation should make before being done
		 */
		public function set total(value:*):void {
			if (value !== total) {
				_total = value;
			}
		}
		
		// --------------------------------------------------------------------
		//
		// Protected Methods
		//
		// --------------------------------------------------------------------
		
		/**
		 * Convenience method for dispatching a <code>OperationEvent.PROGRESS</code> event.
		 * @return true if the event was dispatched; false if not
		 */
		protected function dispatchProgressEvent():void {
			dispatchEvent(OperationEvent.createProgressEvent(this));
		}
		
		/**
		 * Convenience method for dispatching a <code>OperationEvent.COMPLETE</code> event.
		 *
		 * @return true if the event was dispatched; false if not
		 */
		public function dispatchCompleteEvent(result:* = null):Boolean {
			if (result != null) {
				this.result = result;
			}
			return dispatchEvent(OperationEvent.createCompleteEvent(this));
		}
		
		/**
		 * Convenience method for dispatching a <code>OperationEvent.ERROR</code> event.
		 * 
		 * @return true if the event was dispatched; false if not
		 */
		public function dispatchErrorEvent(error:* = null):Boolean {
			if (error) {
				this.error = error;
			}
			return dispatchEvent(OperationEvent.createErrorEvent(this));
		}
        
        /**
         * Initiate this Operation.  An event may be dispatched during
         * the execution of this function, or at any point afterwards.
         */
        public function execute():void
        {
        }
   }
}
