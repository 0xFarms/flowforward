access(all) contract SomeContract {
    pub var testStruct: SomeStruct

    pub struct SomeStruct {
        // 4 Variables
        //
        pub(set) var a: String  	//	read scope: all (anywhere in contract, any script, any transaction)
		  									//	write scope: all (anywhere in contract, any script, any transaction)

        pub var b: String	// read scope: all (anywhere in contract, any script, any transaction)
									//	write scope: contract's current and inner scope (where it was defined)

        access(contract) var c: String	// read scope: anywhere in contract
													//	write scope: current and inner scope

        access(self) var d: String	// read scope: current and inner scope
												//	write scope: current and inner scope

        // 3 Functions
        //
        pub fun publicFunc() {}	// read scope: all (anywhere in contract, any script, any transaction)
											//	write scope: all (anywhere in contract, any script, any transaction)

        access(self) fun privateFunc() {}	// read scope: current and inner scope
														//	write scope: current and inner scope

        access(contract) fun contractFunc() {}	// read scope: anywhere in contract
																//	write scope: anywhere in contract


        pub fun structFunc() {	// structFunc() can be accessed from any thing that has access to SomeStruct
            // Area 1
            // variables with read scope - a, b, c, d
            // variable with write scope - a, b, c, d
            // functions with access -  publicFunc, privateFunc, contractFunc
        }

        init() {
            self.a = "a"
            self.b = "b"
            self.c = "c"
            self.d = "d"
        }
    }

    pub resource SomeResource {	// SomeResource can be accessed from any thing that has access to SomeContract
        pub var e: Int				// e can be accessed from any thing that has access to SomeResource

        pub fun resourceFunc() {	// resourceFunc() can be accessed from any thing that has access to SomeResource
            // Area 2
            // variables with read scope - a, b, c
            // variable with write scope - a
            // functions with access -  publicFunc, contractFunc
        }

        init() {
            self.e = 17
        }
    }

    pub fun createSomeResource(): @SomeResource {	// can be accessed from any thing that has access to SomeContract
        return <- create SomeResource()
    }

    pub fun questsAreFun() {	// can be accessed from any thing that has access to SomeContract
        // Area 3
        // variables with read scope - a, b, c
        // variable with write scope - a
        // functions with access -  publicFunc, contractFunc
    }

    init() {
        self.testStruct = SomeStruct()
    }
}