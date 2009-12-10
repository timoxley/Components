package tests
{
	import au.com.origo.utilities.Utils;
	
	import flexunit.framework.Assert;
	
	import mx.containers.Accordion;
	import mx.controls.Button;
	
	public class TestUtils
	{
		// Reference declaration for class to test
		private var classToTestRef:Utils;
		public function TestUtils()
		{
		}
		
		[Test]
		public function testGetClassName():void {	
			Assert.assertEquals(Utils.getClassName(Button), 'Button');
			Assert.assertEquals(Utils.getClassName(new Accordion()), 'Accordion');
			Assert.assertEquals(Utils.getClassName('sdfsdf'), 'String');
			Assert.assertEquals(Utils.getClassName(null), 'null');
		}
		

		
		[Test]
		public function testIncrementNameNumber():void {
			Assert.assertEquals(Utils.incrementNameNumber('name'), 'name_2');	
			Assert.assertEquals(Utils.incrementNameNumber('name_1'), 'name_2');
			Assert.assertEquals(Utils.incrementNameNumber('name_0'), 'name_1');
			Assert.assertEquals(Utils.incrementNameNumber('name_00'), 'name_1');
			Assert.assertEquals(Utils.incrementNameNumber('name_000'), 'name_1');
			Assert.assertEquals(Utils.incrementNameNumber('name_-1'), 'name_-2');
			Assert.assertEquals(Utils.incrementNameNumber('name_100'), 'name_101');
			Assert.assertEquals(Utils.incrementNameNumber('name0'), 'name1');
			Assert.assertEquals(Utils.incrementNameNumber('name00'), 'name1');
			Assert.assertEquals(Utils.incrementNameNumber('name000'), 'name1');
			Assert.assertEquals(Utils.incrementNameNumber('name001'), 'name2');
			Assert.assertEquals(Utils.incrementNameNumber('name0011'), 'name12');
			Assert.assertEquals(Utils.incrementNameNumber('name100'), 'name101');
			Assert.assertEquals(Utils.incrementNameNumber('name000_000'), 'name000_1');
			Assert.assertEquals(Utils.incrementNameNumber('name234'), 'name235');
			Assert.assertEquals(Utils.incrementNameNumber('name_234_101'), 'name_234_102');
			Assert.assertEquals(Utils.incrementNameNumber('name_234_101_'), 'name_234_101__2');
			Assert.assertEquals(Utils.incrementNameNumber('name_234_101_z'), 'name_234_101_z_2');
			Assert.assertEquals(Utils.incrementNameNumber('Generic Node 7'), 'Generic Node 8');
			Assert.assertEquals(Utils.incrementNameNumber('Generic Node_8'), 'Generic Node_9');
		}
		
		
		[Test(expects="Error")]
		public function testIncrementNameNumberNull():void {
			Utils.incrementNameNumber(null);
		}
	}
}