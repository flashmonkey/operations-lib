package org.flashmonkey.operations.service
{
	import org.flashmonkey.operations.service.dummy.DummyOperation;
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;

	public class AbstractOperationTest
	{		
		private var _operation:DummyOperation;
		
		private var _executed:Boolean;
		
		[Before]
		public function setUp():void
		{
			_operation = new DummyOperation();
			_executed = false;
		}
		
		[After]
		public function tearDown():void
		{
			_operation = null;
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testAddCompleteListener():void 
		{
			var returnedOperation:IOperation = _operation.addCompleteListener(completeListener);
			
			assertThat("The returned operation should be the same object the listener was added to", _operation, equalTo(returnedOperation));
		}
		
		private function completeListener(o:IOperation):void 
		{
			
		}
	}
}