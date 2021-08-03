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

pub resource Picture {
	pub let canvas: Canvas

	init(canvas: Canvas) {
		self.canvas = canvas
	}
}

pub fun serializeStringArray(_ lines: [String]): String {
  var buffer = ""
  for line in lines {
    buffer = buffer.concat(line)
  }
  return buffer
}

pub fun display(pixels: [String]) {
	var frame: String = "+-----+"
	log(frame)
	for e in pixels {
		log(("|").concat(e).concat("|"))
	}
	log(frame)
}

pub resource Printer {
	priv var patterns: [String]
	init() {
   	self.patterns = []
	}
	pub fun print(canvas: Canvas): @Picture? {
		if self.patterns.contains(serializeStringArray(canvas.pixels)) {
			log("Picture has been printed before")
      	return nil
   	}
		self.patterns.append(serializeStringArray(canvas.pixels))
		return <- create Picture(canvas: canvas)
	}
}

pub fun main() {
	let canvas1 = Canvas(
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
	let canvas2 = Canvas(
		width: 5,
		height: 5,
		pixels: [
        "*   *",
        " * * ",
        "     ",
        " * * ",
        "*   *"
   	]
	)
	let canvas3 = Canvas(
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
	let canvas4 = Canvas(
		width: 5,
		height: 5,
		pixels: [
        "*   *",
        "     ",
        "     ",
        "     ",
        "*   *"
   	]
	)
	let smartPrint <- create Printer()

	log("Trying to print 1st pattern")
	if let picture1 <- smartPrint.print(canvas: canvas1) {
		display(pixels: canvas1.pixels)
		log("Success!")
		destroy picture1
	}

	log("Trying to print 2nd pattern")
	if let picture2 <- smartPrint.print(canvas: canvas2) {
		display(pixels: canvas2.pixels)
		log("Success!")
		destroy picture2
	}

	log("Trying to print 3rd pattern")	//repeat, shouldn't succeed
	if let picture3 <- smartPrint.print(canvas: canvas3) {
		display(pixels: canvas3.pixels)
		log("Success!")
		destroy picture3
	}

	log("Trying to print 4th pattern")
	if let picture4 <- smartPrint.print(canvas: canvas4) {
		display(pixels: canvas4.pixels)
		log("Success!")
		destroy picture4
	}

   destroy smartPrint

}
