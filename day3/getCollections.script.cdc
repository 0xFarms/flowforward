import Artist from "./artist.contract.cdc"

pub fun main() {
    //load PublicAccount object from each account.
    let accounts = [
        getAccount(0x01cf0e2f2f715450),
        getAccount(0x179b6b1cb6755e31),
        getAccount(0xf3fcd2c1a78f5eee)
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