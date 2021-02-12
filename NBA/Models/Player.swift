import Foundation

struct Player: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let position: String
    let heightFeet: Int?
    let heightInches: Int?
    let weightPounds: Int?
    let teamId: Int
    
    init(data: [String: Any]) {
        id = data["id"] as! Int
        firstName = data["first_name"] as! String
        lastName = data["last_name"] as! String
        position = data["position"] as! String
        heightFeet = data["height_feet"] as? Int
        heightInches = data["height_inches"] as? Int
        weightPounds = data["weight_pounds"] as? Int
        
        if let team = data["team"] as? [String: Any] {
            teamId = team["id"] as! Int
        } else {
            teamId = data["team_id"] as! Int
        }
    }
}
