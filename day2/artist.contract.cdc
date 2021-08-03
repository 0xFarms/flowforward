pub contract Artist {

//NEW W1Q3 ************************************

  pub resource interface PictureReceiver {
    pub fun deposit(picture: @Picture)
    pub fun getCanvases(): [Canvas]
  }

  pub resource Collection: PictureReceiver {
    pub let pictures: @[Picture]

    pub fun deposit(picture: @Picture) {
      self.pictures.append(<- picture)
    }
    pub fun withdraw(pixels: String): @Picture? {
      var index = 0
      while index < self.pictures.length {
        if self.pictures[index].canvas.pixels == pixels {
          return <- self.pictures.remove(at: index)
        }
        index = index + 1
      }

      return nil
    }
    pub fun getCanvases(): [Canvas] {
      var canvases: [Canvas] = []
      var index = 0
      while index < self.pictures.length {
        canvases.append(
          self.pictures[index].canvas
        )
        index = index + 1
      }

      return canvases;
    }

    init() {
      self.pictures <- []
    }
    destroy() {
      destroy self.pictures
    }
  }

  pub fun createCollection(): @Collection {
    return <- create Collection()
  }

//************************************ /NEW W1Q3

  // defines Canvas structure
  pub struct Canvas {

    pub let width: Int
    pub let height: Int
    pub let pixels: String

    init(width: Int, height: Int, pixels: String) {
      self.width = width
      self.height = height
      self.pixels = pixels
    }
  }

  // A resource that will store a single canvas
  pub resource Picture {

    pub let canvas: Canvas

    init(canvas: Canvas) {
      self.canvas = canvas
    }

  }

  // Printer ensures that only one picture can be printed for each canvas.
  // It also ensures each canvas is correctly formatted (dimensions and pixels).
  pub resource Printer {
    pub let prints: {String: Canvas}

    init() {
      self.prints = {}
    }

    // possible synonyms for the word "canvas"
    pub fun print(width: Int, height: Int, pixels: String): @Picture? {
      // Canvas can only use visible ASCII characters.
      for symbol in pixels.utf8 {
        if symbol < 32 || symbol > 126 {
          return nil
        }
      }

      // Printer is only allowed to print unique canvases.
      if self.prints.containsKey(pixels) == false {
        let canvas = Canvas(
          width: width,
          height: height,
          pixels: pixels
        )
        let picture <- create Picture(canvas: canvas)
        self.prints[canvas.pixels] = canvas

        return <- picture
      } else {
        return nil
      }
    }
  }

  init() {
    self.account.save(
      <- create Printer(),
      to: /storage/ArtistPicturePrinter
    )
    self.account.link<&Printer>(
      /public/ArtistPicturePrinter,
      target: /storage/ArtistPicturePrinter
    )

    self.account.save(
      <- self.createCollection(),
      to: /storage/ArtistPictureCollection
    )
    self.account.link<&{PictureReceiver}>(
      /public/ArtistPictureReceiver,
      target: /storage/ArtistPictureCollection
    )
  }
}