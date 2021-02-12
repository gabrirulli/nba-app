import UIKit
import Alamofire

protocol TeamDetailBusinessLogic
{
  func getPlayers(request: TeamDetail.Request)
}

class TeamDetailInteractor: TeamDetailBusinessLogic
{
  var presenter: TeamDetailPresentationLogic?
  
  // MARK: Do something
  
  func getPlayers(request: TeamDetail.Request)
  {
    var teamPlayers: [Player] = []
    var success: Bool = true
    
    if let playersData = UserDefaults.standard.data(forKey: "players") {
        do {
            let allPlayers = try JSONDecoder().decode([Player].self, from: playersData)
            teamPlayers = allPlayers.filter {
                $0.teamId == request.teamId
            }
        } catch {
           success = false
        }
    }
    
    let response = TeamDetail.Response(success: success, players: teamPlayers)
    self.presenter?.presentSomething(response: response)
  }
}
