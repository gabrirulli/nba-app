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
    
    let response = TeamDetail.Response(success: success, players: teamPlayers)
    self.presenter?.presentSomething(response: response)
  }
}
