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

	log(frame)
	for e in canvas.pixels {
		log(("|").concat(e).concat("|"))
	}
	log(frame)
}

pub fun serializeStringArray(_ lines: [String]): String {

  var buffer = ""

  for line in lines {
    buffer = buffer.concat(line)
  }

  return buffer
}

pub resource Picture {
	pub let canvas: Canvas

	init(canvas: Canvas) {
		self.canvas = canvas
	}
}

pub fun main() {
	let vsdv
	let canvasX = Canvas(
	width: 5,
	height: 5,
	pixels:
	)

	display(canvas: canvasX)
}
