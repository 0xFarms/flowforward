pub struct Canvas {

  pub let width: UInt8
  pub let height: UInt8
  pub let pixels: [String]

  init(width: UInt8, height: UInt8, pixels: [String]) {
    self.width = width
    self.height = height
    self.pixels = pixels
  }
}

pub fun display(canvas: Canvas) {
    var frame: String = "+-----+"
    log(framing)
    for e in canvas.pixels {
        log(("|").concat(e).concat("|"))
    }
    log(framing)
}

pub fun main() {
  let canvasX = Canvas(
      width: 5,
      height: 5,
      pixels: [
        "*   *",
        " * * ",
        "  *  ",
        " * * ",
        "*   *"
      ]
    )

  display(canvas: canvasX)
}

