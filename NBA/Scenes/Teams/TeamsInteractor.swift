import Foundation
import Alamofire

protocol TeamsBusinessLogic
{
  func getAllTeams(request: Teams.Request)
}

class TeamsInteractor: TeamsBusinessLogic
{
  var presenter: TeamsPresentationLogic?
  
  func getAllTeams(request: Teams.Request)
  {
    AF.request(HttpRequestManager.baseUrl() + "/teams", headers: HttpRequestManager.headers())
        .validate()
        .responseJSON { (response: AFDataResponse<Any>) in
            var teams: [Team] = []
            var success: Bool = true
            
            switch response.result {
                case .success(let value):
                    if let JSON = value as? [String: Any] {
                        let data = JSON["data"] as! NSArray
                        
                        // Map results to array of Team
                        teams = data.map({ (team) -> Team in
                            return Team(data: team as! [String : Any])
                        })
                    }
            case .failure(_):
                success = false
            }
            
            let response = Teams.Response(success: success, teams: teams)
            self.presenter?.presentTeams(response: response)
        }
  }
}
