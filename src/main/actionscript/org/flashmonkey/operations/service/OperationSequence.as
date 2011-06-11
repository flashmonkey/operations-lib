package org.flashmonkey.operations.service
{	
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	public class OperationSequence extends AbstractOperation
	{				
		private var _operations:IList = new ArrayCollection();
		
		[Bindable] public function get pendingOperations():IList
		{
			return _operations;
		}
		public function set pendingOperations(value:IList):void 
		{
			_operations = value;
		}
		
        private var operationIndex:uint = 0;
		
		public function get index():uint 
		{
			return operationIndex;
		}
		
		private var _currentOperation:IOperation;
		
		public function get currentOperation():IOperation
		{
			return _currentOperation;
		}
		
		public function get operations():IList
		{
			return _operations;
		}
        
		public function OperationSequence()
		{
			super();
		}
		
		public function addOperation(operation:IOperation):OperationSequence 
		{
			_operations.addItem(operation);
			
			updateProgress();
			
			return this;
		}
		
		protected function updateProgress():void 
		{
			if (operationIndex == 0)
			{
				progress = 0;
			}
			else
			{
				progress = operationIndex / _operations.length;
			}
			
			dispatchProgress();
		}
		
		override public function execute():void
        {        	
            executeNextOperation();
        }
        
        /**
         * Execute the next operation in sequence, at the start of the save
         * or upon the completion of the previous operation.
         */
        private function executeNextOperation():void
        {
            if (operationIndex >= _operations.length)
            {
                dispatchComplete();
                return;
            }
            
			dispatchProgress();

            _currentOperation = _operations.getItemAt(operationIndex++) as IOperation;
            addOperationListeners(_currentOperation);
			updateProgress();
			_currentOperation.execute();
        }
		
		protected function addOperationListeners(operation:IOperation):void {
			if (operation) {
				operation.addCompleteListener(operation_completeHandler);
				operation.addErrorListener(operation_errorHandler);
			}
		}
		
		protected function removeOperationListeners(operation:IOperation):void {
			if (operation) {
				operation.removeCompleteListener(operation_completeHandler);
				operation.removeErrorListener(operation_errorHandler);
			}
		}
		
		/**
		 * Handles the completion of an operation in this queue. An <code>OperationEvent.PROGRESS</code> event is
		 * dispatched when more operations are left in the queue, or if all operations are complete an
		 * <code>OperationEvent.COMPLETE</code> is dispatched.
		 *
		 * @param event the event of the operation that completed
		 */
		protected function operation_completeHandler(o:IOperation):void {

			removeOperationListeners(o);
			
			if (_operations.length == 0) {
				dispatchComplete();
			} else {
				executeNextOperation();
			}
		}
		
		/**
		 * Handles an error from an operation in this queue.
		 */
		protected function operation_errorHandler(o:IOperation):void {
			removeOperationListeners(o);
			
			// redispatch an error from an operation in this queue
			// note: don't immediately dispatch the error if it comes from another operation queue
			// since this will cause this queue to be complete before the inner operation queue is complete
			
			if (o is OperationSequence) {
				var queue:OperationSequence = OperationSequence(o);
				var queueComplete:Boolean = (queue.progress == 1.0);
				
				if (queueComplete) {
					setTimeout(redispatchErrorAndContinue, 1, o.error);
					return; // quit here!
				}
			}
			
			redispatchErrorAndContinue(o.error);
		}
        
		private function redispatchErrorAndContinue(error:*):void {
			dispatchError(error);
			
			if (_operations.length == 0) {
				dispatchComplete();
			} else {
				executeNextOperation();
			}
		}
	}
}