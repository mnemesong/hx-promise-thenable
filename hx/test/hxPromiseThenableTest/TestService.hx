package hxPromiseThenableTest;

import hxThenable.Thenable;
import hxThenable.ThenableFactory;

using Lambda;

interface ITestIO extends ThenableFactory {
	public function readLnInt() : Thenable<Int>;

	public function printLnInt( i : Int ) : Thenable<{}>;
}

class TestService {

	private var io : ITestIO;

	public function new(
		io : ITestIO
	) {
		this.io = io;
	}

	public function mySimpleScript() : Thenable<{}> {
		return this.io.all( [
			this.io.readLnInt(),
			this.io.readLnInt()
		] )
			.map( iii -> iii.map( i -> i + 10 ) )
			.map( iii -> {
				iii.iter( i -> this.io.printLnInt( i ) );
				return {};
			} );
	}
}
