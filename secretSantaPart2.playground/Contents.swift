import UIKit

////////////////////////////////////////////
// Secret Santa Part 2
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
    var historyOfAssignees: Array<Person>
    
    init(person: Person, assignee: Person, historyOfAssignees: Array<Person>) {
        self.person = person
        self.assignee = assignee
        self.historyOfAssignees = historyOfAssignees
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
func assignSecretSanta(list: [Person]) -> [Assignment] {
    for person in list {
        
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
        assignedPeople.append(Assignment(person: person, assignee: assignee, historyOfAssignees: [assignee]))
        
        // Remove person from availblePeople
        availablePeople.remove(at: randomIndex)
    }
    return assignedPeople
}

var secretSantaList = assignSecretSanta(list: listOfPeople)

for item in secretSantaList {
    print("\(item.person.name) is assigned to \(item.assignee.name)")
}
