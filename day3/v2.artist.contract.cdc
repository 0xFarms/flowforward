pub contract ArtistV2 {

  //NEW W1Q5 ************************************************
  pub event PicturePrintSuccess(pixels: String)
  pub event PicturePrintFailure(pixels: String)
  //************************************************/NEW W1Q5

  pub struct Canvas {

    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: String

    init(width: UInt8, height: UInt8, pixels: String) {
      self.width = width
      self.height = height
      self.pixels = pixels
    }
  }

  pub resource Picture {

    pub let canvas: Canvas

    init(canvas: Canvas) {
      self.canvas = canvas
    }
  }

  pub resource Printer {

    pub let width: UInt8
    pub let height: UInt8
    pub let prints: {String: Canvas}

    init(width: UInt8, height: UInt8) {
      self.width = width;
      self.height = height;
      self.prints = {}
    }

    pub fun print(canvas: Canvas): @Picture? {
      // Canvas needs to fit Printer's dimensions.
      if canvas.pixels.length != Int(self.width * self.height) {
        return nil
      }

      // Printer is only allowed to print unique canvases.
      if self.prints.containsKey(canvas.pixels) == false {
        let picture <- create Picture(canvas: canvas)
        self.prints[canvas.pixels] = canvas
        emit PicturePrintSuccess(pixels: canvas.pixels)
        return <- picture
      } else {
        emit PicturePrintFailure(pixels: canvas.pixels)
        return nil
      }
    }
  }

  //NEW W1Q3 ************************************************
  pub resource Collection {
    // create array to store pictures
    pub let pictures: @[Picture]

    // deposit (append) each Picture into array
    pub fun deposit(picture: @Picture) {
      self.pictures.append(<- picture)
    }

    // to return all the stored canvases
    pub fun getCanvases(): [Canvas] {
      var canvases: [Canvas] = []
      var index = 0
      while index < self.pictures.length {
        canvases.append(self.pictures[index].canvas)
        index = index + 1
      }
      return canvases
    }

    //init fields
    init() {
      self.pictures <- []
    }

    //destroy current Picture resource
    destroy() {
      destroy self.pictures
    }
  }
  //************************************************/NEW W1Q3

  init() {
    self.account.save(
      <- create Printer(width: 5, height: 5),
      to: /storage/ArtistV2PicturePrinter
    )
    self.account.link<&Printer>(
      /public/ArtistV2PicturePrinter,
      target: /storage/ArtistV2PicturePrinter
    )
  }
}