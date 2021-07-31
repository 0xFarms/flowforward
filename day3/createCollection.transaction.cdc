import ArtistV2 from 0x01cf0e2f2f715450

transaction {
    prepare(signer1: AuthAccount) {

    }

	pre {
		sendingAccount.balance > 0
	}

    execute {
        // ...
    }

    post {
        // ...
    }
}