import UIKit

protocol PlayerDetailPresentationLogic
{
  func presentPlayer(response: PlayerDetail.Response)
}

class PlayerDetailPresenter: PlayerDetailPresentationLogic
{
  weak var viewController: PlayerDetailDisplayLogic?
  
  func presentPlayer(response: PlayerDetail.Response)
  {
    let errorMessage: String? = response.success ? nil : "Si è verificato un errore, riprova più tardi"
    
    let viewModel = PlayerDetail.ViewModel(errorMessage: errorMessage, playerInfo: response.playerInfo)
    viewController?.displayPlayer(viewModel: viewModel)
  }
}
