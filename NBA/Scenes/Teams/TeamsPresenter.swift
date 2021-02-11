import UIKit

protocol TeamsPresentationLogic
{
  func presentTeams(response: Teams.Response)
}

class TeamsPresenter: TeamsPresentationLogic
{
  weak var viewController: TeamsDisplayLogic?
    
  func presentTeams(response: Teams.Response)
  {
    let errorMessage: String? = response.success ? nil : "Si è verificato un errore, riprova più tardi"
    
    let viewModel = Teams.ViewModel(success: response.success, errorMessage: errorMessage, teams: response.teams)
    viewController?.displayTeams(viewModel: viewModel)
  }
}
