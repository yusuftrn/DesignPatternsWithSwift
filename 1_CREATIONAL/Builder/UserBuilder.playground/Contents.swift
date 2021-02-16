
import Foundation

public class User {
	private final var firstName: String //required
	private final var lastName: String //required
	private final var age: Int?	//optional
	private final var phone: String?	//optional
	private final var address: String?	//optional
	
	init(_ userBuilder: UserBuilder) {
		self.firstName = userBuilder.firstName
		self.lastName = userBuilder.lastName
		self.age = userBuilder.age
		self.phone = userBuilder.phone
		self.address = userBuilder.address
	}
}

public class UserBuilder: CustomStringConvertible {
	public var firstName: String
	public var lastName: String
	public var age: Int?
	public var phone: String?
	public var address: String?
	
	public init(_ firstName: String, _ lastName: String) {
		self.firstName = firstName
		self.lastName = lastName
	}
	
	public func setAge(_ age: Int) -> UserBuilder {
		self.age = age
		return self
	}
	
	public func setPhone(_ phone: String) -> UserBuilder {
		self.phone = phone
		return self
	}
	
	public func setAddress(_ address: String) -> UserBuilder {
		self.address = address
		return self
	}
	
	public func build() -> UserBuilder {
		let user = UserBuilder(firstName, lastName)
		validateUserObject(user)
		return user
		
	}
	
	private func validateUserObject(_ user: UserBuilder) {
		print("\n User data validated: \(user.firstName)")
	}
	
	public var description: String {
		return ("UserBuilder{ firstName =  \(firstName), lastName = \(lastName), age = \(age), phone = \(phone), address = \(address) }");
	}
}

func main() {
	let user1 = UserBuilder("Yusuf", "Turan")
	user1.setAge(28).setPhone("00905551212").setAddress("123 Fake Adress").build()
	print(user1)
	
	let user2 = UserBuilder("Jack", "Ma")
	user2.setAge(40).setPhone("0055444").build()
	//no adress details.
	print(user2)
	
	let user3 = UserBuilder("Harry", "Potter").build()
	//no age
	//no phone
	//no address
	print(user3)
	
}

main()
