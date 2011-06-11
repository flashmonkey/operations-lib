package org.flashmonkey.operations.service
{
	public class NullOperation extends AbstractOperation
	{
		public function NullOperation()
		{
			super();
		}
		
		public override function execute():void
		{
			dispatchComplete();
		}
	}
}