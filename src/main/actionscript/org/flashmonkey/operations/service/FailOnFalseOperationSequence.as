package org.flashmonkey.operations.service
{
	public class FailOnFalseOperationSequence extends OperationSequence
	{
		public function FailOnFalseOperationSequence()
		{
			super();
		}
		
		protected override function operation_completeHandler(o:IOperation):void {
			
			if (o.result == false)
			{
				removeOperationListeners(o);
				dispatchComplete(false);
			}
			else
			{
				super.operation_completeHandler(o);
			}
		}
	}
}