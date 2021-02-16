//Creational: Factory Pattern
//A component responsible solely for the wholesale (not piecewise) creation for objects:

import Foundation

class Point: CustomStringConvertible {
	private var x, y: Double
	
	private init(x: Double, y: Double) {
		self.x = x
		self.y = y
	}
	
	private init(rho: Double, theta: Double){
		x = rho * cos(theta)
		y = rho * sin(theta)
	}
	
	var description: String {
		return "(x=\(self.x), y=\(self.y))"
	}
	
	static let factory = PointFactory.instance
	
	class PointFactory {
		
		private init() {}
		
		static let instance = PointFactory()
		
		func createCartesian(x: Double, y: Double) -> Point {
			return Point(x: x, y: y)
		}
		
		func createPolar(rho:  Double, theta: Double) -> Point {
			return Point(rho: rho, theta: theta)
		}
	}

}


func main() {
	let p = Point.factory.createPolar(rho: 1, theta: 2)
	print(p)
	let cc = Point.factory.createCartesian(x: 1, y: 2)
	print(cc)
	
	let dc = Point.factory.createCartesian(x: 3, y: 2)
	print(dc)
	
	if(cc === dc){
		print("Singleton?")
	}
}

main()
