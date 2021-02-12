import UIKit

protocol TeamsDisplayLogic: class
{
  func displayTeams(viewModel: Teams.ViewModel)
}

class TeamsViewController: UIViewController, TeamsDisplayLogic, UITableViewDelegate, UITableViewDataSource
{
  var interactor: TeamsBusinessLogic?

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
    let interactor = TeamsInteractor()
    let presenter = TeamsPresenter()
    viewController.interactor = interactor
    interactor.presenter = presenter
    presenter.viewController = viewController
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let teamDetailVC = segue.destination as? TeamDetailViewController {
        teamDetailVC.teamId = sender as? Int
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    navigationItem.title = "Teams"
    self.navigationController?.navigationBar.tintColor = UIColor.white;
    
    tableView.delegate = self
    tableView.dataSource = self
    
    getTeams()
  }
    
    func getTeams() {
        let alert = AlertFactory.loader()
        present(alert, animated: true) {
            self.interactor?.getAllTeams(request: Teams.Request())
        }
    }
  
  func displayTeams(viewModel: Teams.ViewModel)
  {
    dismiss(animated: false) {
        if !viewModel.success {
            let alert = AlertFactory.errorAlert(message: viewModel.errorMessage!)

            // show the alert
            self.present(alert, animated: true, completion: nil)
        } else {
            self.teams = viewModel.teams
            self.tableView.reloadData()
        }
    }
  }
    
    // MARK: Table view
    
    var teams: [Team] = []
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TeamTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell") as! TeamTableViewCell
        
        let team = teams[indexPath.row]
        cell.nameLabel.text = team.fullName.uppercased()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let team = teams[indexPath.row]
        
        performSegue(withIdentifier: "TeamDetailSegue", sender: team.id)
    }
}
