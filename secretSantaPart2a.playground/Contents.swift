import UIKit

////////////////////////////////////////////
// Secret Santa Part 1
////////////////////////////////////////////

////////////////////////////////////////////
// Classes and Variables
////////////////////////////////////////////
class Person {
    var name: String
    var unavailableNames: [String]
    
    init(name: String, unavailableNames: [String]) {
        self.name = name
        self.unavailableNames = unavailableNames
    }
}

let listOfPeople = [
    Person(name: "Kyle",
           unavailableNames: []),
    Person(name: "Travis",
           unavailableNames: []),
    Person(name: "Amber",
           unavailableNames: []),
    Person(name: "Joshua",
           unavailableNames: [])/*,
    Person(name: "Colleen",
           unavailableNames: ["Colleen"]),
    Person(name: "Kevin",
           unavailableNames: ["Kevin"]),
    Person(name: "Patty",
           unavailableNames: ["Patty"])*/
]

// Assign Variables
var availablePeople = [Person](listOfPeople)
var generatedList = [String]()

////////////////////////////////////////////
// Helper function - Generates random number
////////////////////////////////////////////
func getRandomNumber(max: Int) -> Int {
    return Int.random(in: 0 ..< max)
}

////////////////////////////////////////////
// Make the Secret Santa List
////////////////////////////////////////////
func assignSecretSanta(list: [Person]) -> [String] {
        
    availablePeople = [Person](listOfPeople)
        
    for person in list {
        
        // Get random index
        var randomIndex = getRandomNumber(max: availablePeople.count)
        // Assign variables
        let a: String = person.name
        var b: [String] = availablePeople[randomIndex].unavailableNames
        var c: String = availablePeople[randomIndex].name
        
        // Get another name if it is unavailable
        while b.contains(a) || a == c {
            // Randomize
            randomIndex = getRandomNumber(max: availablePeople.count)
            b = availablePeople[randomIndex].unavailableNames
            c = availablePeople[randomIndex].name
        }
        // Edge case: check to see if the last person will get himself/herself and prevent it
        if availablePeople.count == 2 {
            if listOfPeople[listOfPeople.count - 1] === availablePeople[1] {
                randomIndex = 1
            }
        }
        
        // Assign the random person to assignee
        let assignee = availablePeople[randomIndex]
        
        // Remove person from availblePeople
        availablePeople.remove(at: randomIndex)
        
        // Print the match
        let matchString: String = "\(person.name) is assigned to \(assignee.name)"
        
        // Append the string to the generatedList
        generatedList.append(matchString)
        
        // Add name to unavailableNames
        person.unavailableNames += [assignee.name]
    }
    return generatedList
}

// Call secretSantaList function
var secretSantaList = assignSecretSanta(list: listOfPeople)

// Print the matchs
for match in generatedList {
    print(match)
}
