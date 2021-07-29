import Artist from 0x01

pub fun main() {
    let accounts = [
        getAccount(0x01),
        getAccount(0x02),
        getAccount(0x03),
        getAccount(0x04),
        getAccount(0x05)
    ]
    for account in accounts {
        let collectionRef = account
            .getCapability(/public/ArtistPictureCollection)
            .borrow<&Artist.Collection>()

        if collectionRef == nil {
            log("Account ".concat(account.address.toString()).concat(" doesn't have a colection"))
        } else {
            var pictureNumber = 1
            log("Account ".concat(account.address.toString()).concat(" pictures"))
            for canvas in collectionRef!.getCanvases() {
                var rowIndex = 0
                while rowIndex < canvas.height {
                    let row = canvas.pixels.slice(
                        from: rowIndex * canvas.width,
                        upTo: (rowIndex + 1) * canvas.width
                    )
                    log(row)
                    rowIndex = rowIndex +1
                }
            pictureNumber = pictureNumber + 1
            }
        }
    }
}