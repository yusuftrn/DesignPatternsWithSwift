//Creational: Builder Pattern
//IDEA: When piecewise object construction is complicated, provide an API for doing it succintly.

import Foundation

//Life w/o builder pattern:
func main(){
	let hello = "Hello"
	var result = "<p>\(hello)</p>"
	print(result)
	
	let words = ["Hello", "whats up", "World!"]
	result = "<ul>\n"
	for word in words {
		result.append("<li> \(word) </li>\n")
	}
	result.append("</ul>")
	print(result)
}
main()

//Life with Builder Pattern:
class HTMLEelement: CustomStringConvertible {
	var name = ""
	var text = ""
	var elements = [HTMLEelement]()
	private let indentSize = 2
	
	init(){}
	
	init(name: String, text: String){
		self.name = name
		self.text = text
	}
	
	private func description(_ indent: Int) -> String {
		var result = ""
		let i = String(repeating: " ", count: indent)
		result += "\(i)<\(name)>\n"
		
		if(!text.isEmpty) {
			result += String(repeating: " ", count: indent + 1)
			result += text
			result += "\n"
		}
		
		for e in elements {
			result += e.description(indent+1)
		}
		result += "\(i)<\(name)>\n"
		return result
	}
	
	public var description: String {
		return description(0)
	}
	
}

class HTMLBuilder: CustomStringConvertible {
	private let rootName: String
	var root = HTMLEelement()
	
	init(rootName: String) {
		self.rootName = rootName
		root.name = rootName
	}
	
	func addChild(name: String, text: String){
		let e = HTMLEelement.init(name: name, text: text)
		root.elements.append(e)
	}
	
	//This operation will give us simple implementation at clientside
	func addChildFluent(name: String, text: String) -> HTMLBuilder {
		let e = HTMLEelement.init(name: name, text: text)
		root.elements.append(e)
		return self
	}
	
	var description: String {
		return root.description
	}
	
	func clear() {
		root = HTMLEelement(name: rootName, text: "")
	}
}


func runBuilder() {
	let builder = HTMLBuilder(rootName: "ul")
	builder.addChild(name: "li", text: "hello")
	builder.addChild(name: "li", text: "whats up")
	builder.addChild(name: "li", text: "World.")
	
	print("\nBuilder Pattern:")
	print(builder)
	
	//FluentBuilder:
	let builderFluent = HTMLBuilder(rootName: "ul")
	builderFluent.addChildFluent(name: "li", text: "Hey")
		.addChildFluent(name: "li", text: "it's fluent build")
		.addChildFluent(name: "li", text: "easy operation for clients.")
	
	print("Fluent Builder Pattern:")
	print(builderFluent)
}
runBuilder()
