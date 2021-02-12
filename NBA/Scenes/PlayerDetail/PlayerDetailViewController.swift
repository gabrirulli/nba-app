import UIKit

protocol PlayerDetailDisplayLogic: class
{
  func displayPlayer(viewModel: PlayerDetail.ViewModel)
}

class PlayerDetailViewController: UIViewController, PlayerDetailDisplayLogic
{
  var interactor: PlayerDetailBusinessLogic?

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
    let interactor = PlayerDetailInteractor()
    let presenter = PlayerDetailPresenter()
    viewController.interactor = interactor
    interactor.presenter = presenter
    presenter.viewController = viewController
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    getPlayer()
  }
    
    var playerId: Int?
  
  func getPlayer()
  {
    let request = PlayerDetail.Request()
    interactor?.getPlayer(request: request)
  }
  
  func displayPlayer(viewModel: PlayerDetail.ViewModel)
  {
  }
}
