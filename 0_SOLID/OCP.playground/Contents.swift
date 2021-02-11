//SOLID: Open Closed Principle
import Foundation

enum Color {
	case red
	case green
	case blue
}

enum Size {
	case small
	case medium
	case large
	case huge
}

class Product {
	var name: String
	var color: Color
	var size: Size
	
	init(_ name: String, _ color: Color, _ size: Size) {
		self.name = name
		self.color = color
		self.size = size
	}
}

//This is when you dont use OCP:
class ProductFilter {
	func filterByColor(_ products: [Product], _ color: Color) -> [Product] {
		var result = [Product]()
		for p in products {
			if p.color == color {
				result.append(p)
			}
		}
		return result
	}
	
	//and your boss comes you to filter by size: when you don't use OCP you break the function
	//copy the filterByColor code and modificate like this:
	func filterBySize(_ products: [Product], _ size: Size) -> [Product] {
		var result = [Product]()
		for p in products {
			if p.size == size {
				result.append(p)
			}
		}
		return result
	}
}

//Let's try to OCP:
//use protocols for specifitation:
protocol Specification {
	associatedtype T
	func isSatisfied(_ item: T) -> Bool
}

protocol Filter {
	associatedtype T
	func filter<Spec: Specification>(_ items: [T], _ spec: Spec) -> [T] where Spec.T == T;
}

class ColorSpecification: Specification {
	typealias T = Product
	let color: Color
	init(_ color: Color){
		self.color = color
	}
	
	func isSatisfied(_ item: Product) -> Bool {
		return item.color == color
	}
}

class SizeSpecification: Specification {
	typealias T = Product
	let size: Size
	init(_ size: Size){
		self.size = size
	}
	
	func isSatisfied(_ item: Product) -> Bool {
		return item.size == size
	}
}

class AndSpecification<T, SpecA: Specification, SpecB: Specification>: Specification
where SpecA.T == SpecB.T, T == SpecA.T, T== SpecB.T {
	
	let first: SpecA
	let second: SpecB
	
	init(_ first: SpecA, _ second: SpecB) {
		self.first = first
		self.second = second
	}
	
	func isSatisfied(_ item: T) -> Bool {
		return first.isSatisfied(item) && second.isSatisfied(item)
	}
}

class BetterFilter: Filter {
	typealias T = Product
	
	func filter<Spec: Specification>(_ items: [Product], _ spec: Spec) -> [T] where Spec.T == T {
		var res = [Product]()
		for i in items{
			if spec.isSatisfied(i){
				res.append(i)
			}
		}
		return res
	}
}

func main(){
	let apple = Product("Apple", .green, .small)
	let tree = Product("Tree", .green, .large)
	let house = Product("House", .blue, .large)
	
	let products  = [apple, tree, house]
	
	let productFilter = ProductFilter()
	print("Green products (old):")
	for p in productFilter.filterByColor(products, .green){
		print("- \(p.name) is green.")
	}
	
	let betterFilter = BetterFilter()
	print("Green products (OCP - new):")
	for p in betterFilter.filter(products, ColorSpecification(.green)) {
		print("- \(p.name) is \(Color.green)")
	}
	
	print("Large blue items (OCP - opened for extends):")
	for p in betterFilter.filter(products, AndSpecification(ColorSpecification(.blue), SizeSpecification(.large))){
		print(" - \(p.name) is large and blue")
	}
}

main()
