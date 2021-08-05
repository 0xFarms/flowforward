access(all) contract SomeContract {
    pub var testStruct: SomeStruct      //	read and write access: all (testStruct can be accessed from anywhere in contract, any external script and/or any transaction)

    pub struct SomeStruct {
        // 4 Variables
        //
        pub(set) var a: String  	    // read/write scope: all (var a can be read/modified from anything/anywhere)

        pub var b: String	            // read scope: all (read from anywhere in contract, any script, any transaction)
							            //	write scope: can only be overwritten in current + inner scope

        access(contract) var c: String	// read scope: anywhere in contract
										//	write scope: current and inner scope only. ie: questsAreFun() cannot overwrite it even though in same contract

        access(self) var d: String	    // read scope: current and inner scope only
									    //	write scope: current and inner scope only

        // 3 Functions
        //
        pub fun publicFunc() {}	        // access scope: all (anywhere in contract, any script, any transaction)

        access(self) fun privateFunc() {}	// access scope: current and inner scope only

        access(contract) fun contractFunc() {}	// access scope: anywhere in containing contract, no external calls allowed

        pub fun structFunc() {	        // structFunc() can be accessed by anything with access to SomeStruct
            // Area 1
            // variables with read scope - a, b, c, d
            // variable with write scope - a, b, c, d
            // functions with access - anything can access this function (public/access(all))
        }

        init() {
            self.a = "a"
            self.b = "b"
            self.c = "c"
            self.d = "d"
        }
    }

    pub resource SomeResource {	    // SomeResource can be created by anything that has access to SomeContract
        pub var e: Int				// e can be read by everyone but 'set' only by resourceFunc and own init()

        pub fun resourceFunc() {	// resourceFunc() can be accessed by anything that has access to SomeResource
            // Area 2
            // variables with read scope - a, b, c, e
            // variables with write scope - a, e, , any other vars created inside this func
            // functions with access - anything can access this function (public/access(all))
        }

        init() {
            self.e = 17
        }
    }

    pub fun createSomeResource(): @SomeResource {	// can be accessed by anything that has access to SomeContract
        return <- create SomeResource()
    }

    pub fun questsAreFun() {	// can be accessed from anything that has access to SomeContract
        // Area 3
        // variables with read scope - a, b, c, SomeResource.e
        // variables with write scope - a, any other vars created inside this func
        // functions with access - anything can access this function (public/access(all))
        log(self.testStruct.a)  //works
        log(self.testStruct.b)  //works
        log(self.testStruct.c)  //works
        // log(self.testStruct.d)  //doesn't work - private access
        let res: @SomeResource <- create SomeResource()   //works
        log(res.e)                                        //works
        // res.e = 98                                        //doesn't work - would need pub(set)
        destroy res
    }

    init() {
        self.testStruct = SomeStruct()
    }
}