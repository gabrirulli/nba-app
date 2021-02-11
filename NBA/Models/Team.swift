import Foundation

class Team {
    let id: Int
    let fullName: String
    let name: String
    let abbreviation: String
    let city: String
    let conference: String
    let division: String
    
    init(data: [String: Any]) {
        id = data["id"] as! Int
        fullName = data["full_name"] as! String
        name = data["name"] as! String
        abbreviation = data["abbreviation"] as! String
        city = data["city"] as! String
        conference = data["conference"] as! String
        division = data["division"] as! String
    }
}
