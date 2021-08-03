import Artist from 0x01

transaction() {

  let newPrint: @Artist.Picture?
  let myCollection: &{Artist.PictureReceiver}

  prepare(auth: AuthAccount) {

    // created canvas here for convenience
    let myCanvas: Artist.Canvas = Artist.Canvas(width: 5, height: 5, pixels: "5000000000000000000000000")

    // create reference to Artist.Printer
    let artistPrinterRef = getAccount(0x01) // 0x01 needs to be hardcoded in since that's where the Printer is
                    .getCapability(/public/ArtistPicturePrinter)
                    .borrow<&Artist.Printer>()
                    ?? panic("Couldn't borrow /public/ArtistPicturePrinter")

    // create picture and move reference of it to newPrint object
    self.newPrint <- artistPrinterRef.print(width: myCanvas.width, height: myCanvas.height, pixels: myCanvas.pixels)
        ?? panic("Duplicates cannot be processed")

    // get reference to personal Collection resource. if not 0x01, account must have created a collection prior to calling this transaction or this will fail
    self.myCollection = getAccount(auth.address)
                        .getCapability<&{Artist.PictureReceiver}>(/public/ArtistPictureReceiver)
                        .borrow()
                        ?? panic("Couldn't borrow /public/ArtistPictureReceiver")

  }

  execute {
    // if no pic or duplicate, destroy newPrint object
    if self.newPrint == nil {
        destroy self.newPrint
    } else {
      // move newPrint in to Collection in storage
      self.myCollection.deposit(picture: <- self.newPrint!)
      log("Saved new picture to your collection")
    }
  }
}