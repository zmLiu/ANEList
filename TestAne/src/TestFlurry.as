package
{
	import com.lzm.anesdk.flurry.Flurry;

	public class TestFlurry
	{
		private var flurry:Flurry;
		
		public function TestFlurry()
		{
			flurry = new Flurry();
			flurry.startSession("NM4NWDKXB9FN627FHTNV");
			flurry.logEvent("LOGIN");
		}
	}
}