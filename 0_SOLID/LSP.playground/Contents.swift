//SOLID: Liskov's Substitution Principle

import Foundation

//This implementation violate LSP:
class Rectangle: CustomStringConvertible {
	var _width = 0
	var _height = 0
	
	var width: Int {
		get { return _width }
		set(value) { _width = value }
	}
	
	var height: Int {
		get { return _height }
		set(value) { _height = value }
	}
	
	init(){}
	
	init(_ width: Int, _ height: Int){
		_width = width
		_height = height
	}
	
	var area: Int {
		return width * height
	}
	
	public var description: String {
		return "width: \(width), height: \(height)"
	}
}

class Square: Rectangle {
	override var width: Int {
		get { return _width }
		set(value) {
			_width = value
			_height = value
		}
	}
	override var height: Int {
		get { return _height }
		set(value) {
			_width = value
			_height = value
		}
	}
}

func setAndMeasure(_ rc: Rectangle){
	rc.width = 3
	rc.height = 6
	print("Expected area is 18 but got: \(rc.area)")
}

func main() {
	print("This method violates LSP:")
	
	let rc = Rectangle()
	setAndMeasure(rc)
	
	let sq = Square()
	setAndMeasure(sq)
}
main()


//Let's try to implement with LSP:

protocol Shape {
	func area() -> Int
}

class SquareLSP: Shape {
	private let size: Int
	
	init(_ size: Int) {
		self.size = size
	}
	
	func area() -> Int {
		let calculateArea = self.size * self.size
		return calculateArea
	}
}

class RectangleLSP: Shape {
	private let width: Int
	private let height: Int
	
	init(_ width: Int, _ height: Int) {
		self.width = width
		self.height = height
	}
	
	func area() -> Int {
		let calculateArea: Int = self.width * self.height
		return calculateArea
	}
}

func testLSP(){
	print("This implementation works with LSP")
	
	let rc = RectangleLSP(5, 4);
	print("Expected area is 20 and we got: \(rc.area())")
	
	let sq = SquareLSP(4);
	print("Expected area is 16 and we got: \(sq.area())")
}
testLSP()
