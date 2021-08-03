import Artist from "./artist.contract.cdc"

transaction() {

  prepare(auth: AuthAccount) {

      auth.save<@Artist.Collection>(
      <- Artist.createCollection(),
      to: /storage/ArtistPictureCollection
      )
      auth.link<&{Artist.PictureReceiver}>(
        /public/ArtistPictureReceiver,
        target: /storage/ArtistPictureCollection
      )

      let success = getAccount(auth.address).getCapability(/public/ArtistPictureReceiver).check<&{Artist.PictureReceiver}>()

      if success {
        log("Success created a new PictureCollection for ".concat(auth.address.toString()).concat(" at /public/ArtistPictureReceiver"))
      }
  }
}