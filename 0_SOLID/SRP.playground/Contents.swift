//SOLID: Single Resposibility Principle
import Foundation

class Journal: CustomStringConvertible {
	var entries: [String] = []
	var count = 0
	
	func addEntry(_ text: String) -> Int {
		count += 1
		entries.append("\(count): \(text)")
		return (count - 1)
	}
	
	func removeEntry(_ index: Int) {
		entries.remove(at: index)
	}
	
	var description: String {
		return entries.joined(separator: "\n")
	}
	
	func save(_ filename:  String, _ overwrite: Bool = false){
		//save to a file
	}
	
	func load(_ filename: String) {}
	func load(_ url: URL) {}
}

class Persistence {
	func saveToFile(_ journal: Journal, _ filename: String, _ overwrite: Bool = false) {
		print("\n\nFile saved:\n\(journal)\nto \(filename)")
	}
}

func main() {
	let j = Journal()
	let _ = j.addEntry("I cried today")
	let bug = j.addEntry("I ate a bug")
	let x = j.addEntry("Hey this is third message")
	print(j.description)
	
	j.removeEntry(bug)
	print("====")
	print(j.description)
	
	print("====")
	let fourtData = j.addEntry("Yo read this")
	print(j.description)
	
	let p = Persistence()
	let filename = "usr/doc/file.txt"
	p.saveToFile(j, filename, false)
}
main()

/*
OUTPUTS:
1: I cried today
2: I ate a bug
3: Hey this is third message
====
1: I cried today
3: Hey this is third message
====
1: I cried today
3: Hey this is third message
4: Yo read this


File saved:
1: I cried today
3: Hey this is third message
4: Yo read this
to usr/doc/file.txt
*/
