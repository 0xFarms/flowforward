import ArtistV2 from 0x01cf0e2f2f715450

pub fun main(address: Address): [ArtistV2.Canvas] {
  let account = getAccount(address)
  let printerRef = account
    .getCapability<&{ArtistV2PicturePrinter}>(/public/ArtistV2PicturePrinter)
    .borrow()
    ?? panic("Couldn't borrow Picture Receiver reference.")

  return printerRef.getCanvases()
}
