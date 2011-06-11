package org.flashmonkey.operations.service
{
	import org.osflash.signals.Signal;
	
	public class OperationSignal extends Signal
	{
		public function OperationSignal()
		{
			super(IOperation);
		}
	}
}