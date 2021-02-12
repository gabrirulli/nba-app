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
    let alert = AlertFactory.loader()
    present(alert, animated: true) {
        let request = PlayerDetail.Request(playerId: self.playerId ?? 0)
        self.interactor?.getPlayer(request: request)
    }
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
    // Dismiss loader
    dismiss(animated: false) {
        guard let info = viewModel.playerInfo else {
            let alert = AlertFactory.errorAlert(message: viewModel.errorMessage!)

            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.firstNameLabel.text = info.player.firstName
        self.lastNameLabel.text = info.player.lastName
        self.positionLabel.text = info.player.position
        
        if let heightFeet = info.player.heightFeet {
            self.heightFeetLabel.text = "\(self.heightFeetLabel.text!) \(String(heightFeet)))"
        }
        
        if let heightInches = info.player.heightInches {
            self.heightInchesLabel.text = "\(self.heightInchesLabel.text!) \(String(heightInches))"
        }
        
        if let weightPounds = info.player.weightPounds {
            self.weightPoundsLabel.text = "\(self.weightPoundsLabel.text!) \(String(weightPounds))"
        }
        
        self.astLabel.text = "\(self.astLabel.text!) \(String(info.ast))"
        self.minLabel.text = "\(self.minLabel.text!) \(info.min)"
        self.ptsLabel.text = "\(self.ptsLabel.text!) \(String(info.pts))"
        self.turnoverLabel.text = "\(self.turnoverLabel.text!) \(String(info.turnover))"
        self.rebLabel.text = "\(self.rebLabel.text!) \(String(info.reb))"
    }
  }
}
