import UIKit

enum TeamDetail
{
    struct Request {
        let teamId: Int
    }
    
    struct Response {
        let success: Bool
        let players: [Player]
    }
    
    struct ViewModel {
        let players: [Player]
        let errorMessage: String?
    }
}
