import UIKit

enum PlayerDetail
{
    struct Request {
        let playerId: Int
    }
    
    struct Response {
        let success: Bool
        let playerInfo: PlayerStatistic?
    }
    
    struct ViewModel {
        let errorMessage: String?
        let playerInfo: PlayerStatistic?
    }
}
