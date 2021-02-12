import UIKit

protocol TeamDetailDisplayLogic: class
{
  func displayPlayers(viewModel: TeamDetail.ViewModel)
}

class TeamDetailViewController: UIViewController, TeamDetailDisplayLogic
{
  var interactor: TeamDetailBusinessLogic?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = TeamDetailInteractor()
    let presenter = TeamDetailPresenter()
    viewController.interactor = interactor
    interactor.presenter = presenter
    presenter.viewController = viewController
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
  }
  
  // MARK: View lifecycle
    
    var teamId: Int?
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    getTeamPlayers()
  }
  
  func getTeamPlayers()
  {
    let request = TeamDetail.Request(teamId: teamId!)
    interactor?.getPlayers(request: request)
  }
  
  func displayPlayers(viewModel: TeamDetail.ViewModel)
  {
    guard let errorMessage = viewModel.errorMessage else {
        return
    }
    
    // create the alert
    let alert = UIAlertController(title: "Errore", message: errorMessage, preferredStyle: UIAlertController.Style.alert)

    // add an action (button)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

    // show the alert
    self.present(alert, animated: true, completion: nil)
  }
}
