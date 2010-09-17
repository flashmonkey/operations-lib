package org.flashmonkey.operations.service
{
	public class FailOnFalseOperationSequence extends OperationSequence
	{
		public function FailOnFalseOperationSequence()
		{
			super();
		}
		
		protected override function operation_completeHandler(event:OperationEvent):void {
			
			if (event.operation.result == false)
			{
				removeOperationListeners(event.operation);
				dispatchCompleteEvent(false);
			}
			else
			{
				super.operation_completeHandler(event);
			}
		}
	}
}