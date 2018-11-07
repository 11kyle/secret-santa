import UIKit

////////////////////////////////////////////
// Secret Santa Part 1
////////////////////////////////////////////

////////////////////////////////////////////
// Classes and Variables
////////////////////////////////////////////
class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

let listOfPeople = [
    Person(name: "Kyle"),
    Person(name: "Travis"),
    Person(name: "Amber"),
    Person(name: "Joshua"),
    Person(name: "Colleen")
]

class Assignment {
    var person: Person
    var assignee: Person
    
    init(person: Person, assignee: Person) {
        self.person = person
        self.assignee = assignee
    }
}

var availablePeople = [Person](listOfPeople)
var assignedPeople = [Assignment]()

////////////////////////////////////////////
// Helper function - Generates random number
////////////////////////////////////////////
func randomNumber(max: Int) -> Int {
    return Int.random(in: 0 ..< max)
}

////////////////////////////////////////////
// Make the Secret Santa List
////////////////////////////////////////////
for person in listOfPeople {
    
    // Get random index
    var randomIndex = randomNumber(max: availablePeople.count)
    
    // Get another index if person is assigned to himself/herself
    while person.name == availablePeople[randomIndex].name {
        randomIndex = randomNumber(max: availablePeople.count)
    }
    
    // check to see if the last available person will get himself/herself and make sure it doesn't happen
    if availablePeople.count == 2 {
        if listOfPeople[listOfPeople.count - 1] === availablePeople[1] {
            randomIndex = 1
        }
    }
    
    // Assign the random person to assignee
    let assignee = availablePeople[randomIndex]
    
    // Append the match to assignedPeople
    assignedPeople.append(Assignment(person: person, assignee: assignee))
    
    // Remove person from availblePeople
    availablePeople.remove(at: randomIndex)
    
    // Print the match
    print("\(person.name) is assigned to \(assignee.name)")
}
