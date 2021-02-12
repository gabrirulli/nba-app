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
    let request = PlayerDetail.Request(playerId: playerId ?? 0)
    interactor?.getPlayer(request: request)
  }
    
    // MARK: display info
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var heightFeetLabel: UILabel!
    @IBOutlet weak var heightInchesLabel: UILabel!
    @IBOutlet weak var weightPoundsLabel: UILabel!
    @IBOutlet weak var astLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var blkLabel: UILabel!
    @IBOutlet weak var ptsLabel: UILabel!
    @IBOutlet weak var turnoverLabel: UILabel!
    @IBOutlet weak var rebLabel: UILabel!
    
  func displayPlayer(viewModel: PlayerDetail.ViewModel)
  {
    guard let info = viewModel.playerInfo else {
        let alert = UIAlertController(title: "Errore", message: viewModel.errorMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
        return
    }
    
    firstNameLabel.text = info.player.firstName
    lastNameLabel.text = info.player.lastName
    positionLabel.text = info.player.position
    
    if let heightFeet = info.player.heightFeet {
        heightFeetLabel.text = "\(heightFeetLabel.text!) \(String(heightFeet)))"
    }
    
    if let heightInches = info.player.heightInches {
        heightInchesLabel.text = "\(heightInchesLabel.text!) \(String(heightInches))"
    }
    
    if let weightPounds = info.player.weightPounds {
        weightPoundsLabel.text = "\(weightPoundsLabel.text!) \(String(weightPounds))"
    }
    
    astLabel.text = "\(astLabel.text!) \(String(info.ast))"
    minLabel.text = "\(minLabel.text!) \(info.min)"
    ptsLabel.text = "\(ptsLabel.text!) \(String(info.pts))"
    turnoverLabel.text = "\(turnoverLabel.text!) \(String(info.turnover))"
    rebLabel.text = "\(rebLabel.text!) \(String(info.reb))"
  }
}
