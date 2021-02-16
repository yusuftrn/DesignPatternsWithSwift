import Foundation
import XCTest

class Person: CustomStringConvertible {
	var id: Int
	var name: String
	
	init(called name: String, withId id: Int) {
		self.name = name
		self.id = id
	}
	
	var description: String {
		return "Name: \(self.name), ID: \(self.id)"
	}
}

class PersonFactory {
	private var id = 0
	
	func createPerson(name: String) -> Person {
		let p = Person(called: name, withId: id)
		id += 1
		return p
	}
}

class Evaluate {
	func simpleTest() {
		let pf = PersonFactory()
		
		let p1 = pf.createPerson(name: "Chris")
		print(p1.description)
		
		let p2 = pf.createPerson(name: "Sarah")
		print(p2.description)
	}
}
let test = Evaluate()
test.simpleTest()

