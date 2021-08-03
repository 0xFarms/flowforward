import Artist from 0x01

pub fun main() {
    //load PublicAccount object from each account.
    let accounts = [
        getAccount(0x01),
        getAccount(0x02),
        getAccount(0x03),
        getAccount(0x04),
        getAccount(0x05)
    ]
    //
    for account in accounts {
        let collection = account
            .getCapability<&{Artist.PictureReceiver}>(/public/ArtistPictureReceiver)
        if (!collection.check()) {
            log("Account ".concat(account.address.toString()).concat(" doesn't have a collection."))
        } else {
            log(collection.borrow()!.getCanvases()) // forced unwrap to access getCanvases. checked nil condition right before this so hope not a problem
        }
    }
}