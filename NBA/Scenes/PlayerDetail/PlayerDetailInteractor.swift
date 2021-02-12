import UIKit

protocol PlayerDetailBusinessLogic
{
  func getPlayer(request: PlayerDetail.Request)
}

class PlayerDetailInteractor: PlayerDetailBusinessLogic
{
  var presenter: PlayerDetailPresentationLogic?
  
  func getPlayer(request: PlayerDetail.Request)
  {
    let response = PlayerDetail.Response()
    presenter?.presentPlayer(response: response)
  }
}
