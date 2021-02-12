import UIKit

protocol TeamDetailDisplayLogic: class
{
  func displayPlayers(viewModel: TeamDetail.ViewModel)
}

class TeamDetailViewController: UIViewController, TeamDetailDisplayLogic, UITableViewDelegate, UITableViewDataSource
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
    if let playerDetailVC = segue.destination as? PlayerDetailViewController {
        playerDetailVC.playerId = sender as? Int
    }
  }
  
  // MARK: View lifecycle
    
    var teamId: Int?
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    
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
        players = viewModel.players
        tableView.reloadData()
        return
    }
    
    let alert = AlertFactory.errorAlert(message: errorMessage)

    // show the alert
    self.present(alert, animated: true, completion: nil)
  }
    
    // MARK: table view
    var players: [Player] = []
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlayerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell") as! PlayerTableViewCell
        
        let player = players[indexPath.row]
        cell.positionLabel.text = player.position
        cell.firstNameLabel.text = player.firstName
        cell.lastNameLabel.text = player.lastName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = players[indexPath.row]
        
        performSegue(withIdentifier: "PlayerDetailSegue", sender: player.id)
    }
}
