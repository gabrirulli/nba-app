import Foundation

struct Player: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let position: String
    let teamId: Int
    
    init(data: [String: Any]) {
        id = data["id"] as! Int
        firstName = data["first_name"] as! String
        lastName = data["last_name"] as! String
        position = data["position"] as! String
        
        let team = data["team"] as! [String: Any]
        teamId = team["id"] as! Int
    }
}
