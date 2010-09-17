package org.flashmonkey.operations.service
{
    /**
     * Abstract class representing a filter operating around an underlying operation,
     * for instance to parse its result or handle its outcome in some specialized way.
     */
    public class FilterOperation extends AbstractOperation
    {
        private var _operation:IOperation;
        
        public function FilterOperation(operation:IOperation)
        {
            _operation = operation;
            _operation.addCompleteListener(dispatchCompleteEvent);
            _operation.addErrorListener(dispatchErrorEvent);
            _operation.addErrorListener(dispatchErrorEvent);
        }
        
        /**
         * Initiate this Operation.  An event may be dispatched during
         * the execution of this function, or at any point afterwards.
         */
        override public function execute():void
        {
            _operation.execute();
        }
        
        /**
         * On success, return the result of this operation.
         *//*
        override public function get result():*
        {
            return _operation.result;
        }*/
        
        /**
         * The underlying operation for this FilterOperation. 
         */
        public function get operation():IOperation
        {
            return _operation;
        }
   }
}
