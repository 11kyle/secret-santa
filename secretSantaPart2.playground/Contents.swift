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

var availablePeople = [Person](listOfPeople)

////////////////////////////////////////////
// Helper function - Generates random number
////////////////////////////////////////////
func getRandomNumber(max: Int) -> Int {
    return Int.random(in: 0 ..< max)
}

enum SecretSantaError: Error {
    case tooFewNames(namesNeeded: Int)
}
////////////////////////////////////////////
// Make the Secret Santa List
////////////////////////////////////////////
func assignSecretSanta(list: [Person]) throws -> [String] {
    
    guard list.count >= 4 else {
        throw SecretSantaError.tooFewNames(namesNeeded: 4)
    }
    
    var generatedList = [String]()
    
    finish: for var index in 0...1 {
        
        availablePeople = [Person](listOfPeople)

        label: for person in list {
            
            // Get random index
            var randomIndex = getRandomNumber(max: availablePeople.count)
            // Assign variables
            let currentPersonName: String = person.name
            var currentPersonUnavailableNames: [String] = person.unavailableNames
            var randomPersonName: String = availablePeople[randomIndex].name
            
            // Get another name if it is unavailable
            while currentPersonUnavailableNames.contains(randomPersonName) || currentPersonName == randomPersonName {
                // Randomize
                randomIndex = getRandomNumber(max: availablePeople.count)
                currentPersonUnavailableNames = person.unavailableNames
                randomPersonName = availablePeople[randomIndex].name
                
                // Edge case: check to see if the last person will get himself/herself and start over if true
                if availablePeople.count == 1 {
                    if currentPersonUnavailableNames.contains(randomPersonName) || currentPersonName == randomPersonName {
                        index = 0
                        generatedList = []
                        // Clear unavailableNames from each person in the list
                        for person in listOfPeople {
                            person.unavailableNames.removeAll()
                        }
                        //print("ERROR 1: Can't be assigned to self! : Restart") Was used for debugging
                        break label
                    }
                }
                // Edge case: check to see if second to last person will get himself/herself or an unavailable and start over if true
                if availablePeople.count == 2 && currentPersonUnavailableNames.contains(randomPersonName) {
                    // Select the only other option
                    //print("NOTICE 1: \(randomPersonName)") : Was used for debugging
                    randomIndex = randomIndex == 1 ? 0 : 1
                    randomPersonName = availablePeople[randomIndex].name
                    //print("NOTICE 2: \(randomPersonName)") : Was used for debugging
                    if currentPersonName == randomPersonName && currentPersonUnavailableNames.contains(randomPersonName) {
                        index = 0
                        generatedList = []
                        // Clear unavailableNames from each person in the list
                        for person in listOfPeople {
                            person.unavailableNames.removeAll()
                        }
                        //print("ERROR 2: Can't be assigned! : End of Program") Was used when debugging
                        break label
                    }
                }
            }

            // Assign the random person to assignee
            let assignee = availablePeople[randomIndex]
            
            // Remove person from availblePeople
            availablePeople.remove(at: randomIndex)
            
            // Print the match
            let matchString: String = "\(person.name) is assigned to \(assignee.name)"
            //print(matchString)
            
            // Append the string to the generatedList
            generatedList.append(matchString)
            
            // Add name to unavailableNames
            person.unavailableNames += [assignee.name]
            
            // If SUCCESS exit loop
            if generatedList.count == list.count {
                //print("End of program") Was used for debugging
                break finish
            }
        }
    }
    return generatedList
}





// Call secretSantaList function
var secretSantaList = try assignSecretSanta(list: listOfPeople)

// Print the matchs
for match in secretSantaList {
    print(match)
}
print()



// Call secretSantaList function
var secretSantaList2 = try assignSecretSanta(list: listOfPeople)

// Print the matchs
for match in secretSantaList2 {
    print(match)
}
print()



// Call secretSantaList function
var secretSantaList3 = try assignSecretSanta(list: listOfPeople)

// Print the matchs
for match in secretSantaList3 {
    print(match)
}
print()
