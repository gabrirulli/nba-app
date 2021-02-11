import UIKit

enum Teams
{
    struct Request {}
    
    struct Response {
        let success: Bool
        let teams: [Team]
    }
    
    struct ViewModel {
        let success: Bool
        let errorMessage: String?
        let teams: [Team]
    }
}
