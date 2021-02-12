import UIKit

protocol TeamDetailPresentationLogic
{
  func presentSomething(response: TeamDetail.Response)
}

class TeamDetailPresenter: TeamDetailPresentationLogic
{
  weak var viewController: TeamDetailDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: TeamDetail.Response)
  {
    let errorMessage: String? = response.success ? nil : "Si è verificato un errore, riprova più tardi"
    
    let viewModel = TeamDetail.ViewModel(players: response.players, errorMessage: errorMessage)
    viewController?.displayPlayers(viewModel: viewModel)
  }
}
