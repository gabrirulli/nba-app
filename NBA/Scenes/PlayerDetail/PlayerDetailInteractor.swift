import UIKit
import Alamofire

protocol PlayerDetailBusinessLogic
{
  func getPlayer(request: PlayerDetail.Request)
}

class PlayerDetailInteractor: PlayerDetailBusinessLogic
{
  var presenter: PlayerDetailPresentationLogic?
  
  func getPlayer(request: PlayerDetail.Request)
  {
    AF.request(HttpRequestManager.baseUrl() + "/stats?per_page=1&player_ids=\(request.playerId)", headers: HttpRequestManager.headers())
        .validate()
        .responseJSON { (response: AFDataResponse<Any>) in
            var playerInfo: PlayerStatistic?
            var success: Bool = true
            
            switch response.result {
                case .success(let value):
                    if let JSON = value as? [String: Any] {
                        // Map result to PlayerStatistic object
                        let data = JSON["data"] as! NSArray
                        
                        playerInfo = PlayerStatistic(data: data[0] as! [String : Any])
                    }
            case .failure(_):
                success = false
            }
            
            let response = PlayerDetail.Response(success: success, playerInfo: playerInfo)
            self.presenter?.presentPlayer(response: response)
        }
  }
}
