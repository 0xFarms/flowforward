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

pub fun display(pixels: [String]) {
	var frame: String = "+-----+"
	log(frame)
	for e in pixels {
		log(("|").concat(e).concat("|"))
	}
	log(frame)
}

pub fun main() {
	let pattern = [
        "*   *",
        " * * ",
        "  *  ",
        " * * ",
        "*   *"
   ]

	let canvasX = Canvas(
		width: 5,
		height: 5,
		pixels: pattern
	)

	display(pixels: pattern)
}
