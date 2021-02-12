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
    let viewModel = PlayerDetail.ViewModel()
    viewController?.displayPlayer(viewModel: viewModel)
  }
}
