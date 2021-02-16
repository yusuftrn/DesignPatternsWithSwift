import Foundation

protocol Creator {
	func factoryMethod() -> Product
	func someOperation() -> String
}


extension Creator {
	func someOperation() -> String {
		let product = factoryMethod()
		return "Creator: The same creator's code has just worked with " + product.operation()
	}
}

class ConcreteCreator1: Creator {
	public func factoryMethod() -> Product {
		return ConcreteProduct1()
	}
}

class ConcreteCreator2: Creator {
	public func factoryMethod() -> Product {
		return ConcreteProduct2()
	}
}

protocol Product {
	func operation() -> String
}

class ConcreteProduct1: Product {
	func operation() -> String {
		return "{Result of the ConcreteProduct1}"
	}
}

class ConcreteProduct2: Product {
	func operation() -> String {
		return "{Result of the ConcreteProduct2}"
	}
}

class Client {
	static func someClientCode(creator: Creator) {
		print("Client: I'm not aware of the creator's class, but it still works.\n"
				+ creator.someOperation())
	}
}

print("App: Launched with the ConcreteCreator1.")
Client.someClientCode(creator: ConcreteCreator1())

print("\nApp: Launched with the ConcreteCreator2.")
Client.someClientCode(creator: ConcreteCreator2())
