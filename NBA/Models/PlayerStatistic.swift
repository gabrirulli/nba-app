import Foundation

struct PlayerStatistic {
    let ast: Int
    let blk: Int
    let min: String
    let pts: Int
    let reb: Int
    let turnover: Int
    let player: Player
    
    init(data: [String: Any]) {
        ast = data["ast"] as! Int
        blk = data["blk"] as! Int
        min = data["min"] as! String
        pts = data["pts"] as! Int
        reb = data["reb"] as! Int
        turnover = data["turnover"] as! Int
        
        let playerData = data["player"] as! [String: Any]
        player = Player(data: playerData)
    }
}
