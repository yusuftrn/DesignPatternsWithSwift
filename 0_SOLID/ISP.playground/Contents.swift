//SOLID: Interface Segregation Principle

import Foundation

class Document {
	let name: String
	
	init(_ name: String) {
		self.name = name
	}
}

protocol Printer {
	func printOut(d: Document)
}

protocol Scanner {
	func scan(d: Document)
}

protocol Fax {
	func fax(d: Document)
}

class OrdinaryPrinter: Printer {
	func printOut(d: Document) {
		print("Printed: \(d.name)")
	}
	//No requiment to any other protocols
}

class DoubleFunctionMachine: Printer, Scanner {
	func printOut(d: Document) {
		print("Printed: \(d.name)")
	}
	func scan(d: Document) {
		print("Scanned: \(d.name)")
	}
	//No requiment to fax protocol
}

class MultiFunctionMachine: Printer, Scanner, Fax {
	func printOut(d: Document) {
		print("Printed: \(d.name)")
	}
	func scan(d: Document) {
		print("Scanned: \(d.name)")
	}
	func fax(d: Document) {
		print("Document \(d.name) is sended with fax")
	}
}

func main() {
	let doc = Document("Secrets_Of_Universe.pdf")
	print("one protocol job:")
	let printer = OrdinaryPrinter()
	printer.printOut(d: doc)
	
	
	let printerAndScanner = DoubleFunctionMachine()
	print("two protocol job:")
	printerAndScanner.scan(d: doc)
	printerAndScanner.printOut(d: doc)
	
	let expensiveMachine = MultiFunctionMachine()
	print("three protocol job:")
	expensiveMachine.scan(d: doc)
	expensiveMachine.fax(d: doc)
	expensiveMachine.printOut(d: doc)
}

main()
