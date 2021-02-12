import UIKit
import Alamofire

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var numberOfPlayersHttpCalls: Int = 0
    let userDefaults = UserDefaults.standard
    
    func getPlayers(pageNumber: Int = 0, completionHandler: @escaping () -> Void) {
        AF.request("\(HttpRequestManager.baseUrl())/players?page=\(pageNumber)&per_page=100", headers: HttpRequestManager.headers())
            .validate()
            .responseJSON { (response: AFDataResponse<Any>) in
                var players: [Player] = []

                switch response.result {
                    case .success(let value):
                        if let JSON = value as? [String: Any] {
                            if self.numberOfPlayersHttpCalls == 0 {
                                // Check total pages number returned by API and save it in order to get all pages and retrive every players
                                let data = JSON["meta"] as! [String: Any]
                                self.numberOfPlayersHttpCalls = data["total_pages"] as! Int
                            } else {
                                let data = JSON["data"] as! NSArray
                                // Map results to an array of Player
                                players = data.map({ (player) -> Player in
                                    return Player(data: player as! [String : Any])
                                })
                                
                                do {
                                    var savedPlayersList: [Player] = []
                                    
                                    // Get players data from local storage
                                    if let playersData = self.userDefaults.data(forKey: "players") {
                                        do {
                                            // Add players from API to the list of the players saved locally
                                            savedPlayersList = try JSONDecoder().decode([Player].self, from: playersData)
                                            players.append(contentsOf: savedPlayersList)
                                        } catch {
                                           print(error)
                                        }
                                    }
                                    
                                    // Encode players list and save it to local storage
                                    let encodedData = try JSONEncoder().encode(players)
                                    self.userDefaults.set(encodedData, forKey: "players")
                                    self.userDefaults.synchronize()
                                } catch (_) {
                                    print("error")
                                }
                            }
                            
                            completionHandler()
                        }
                case .failure(_):
                    completionHandler()
                    break
                    // Do nothing
                }
            }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Reset players list saved locally
        self.userDefaults.set([], forKey: "players")
        let queue = DispatchQueue(label: "com.app.concurrentQueue", attributes: .concurrent)
        DispatchQueue.global(qos: .background).async {
            self.getPlayers() {
                for n in 1...self.numberOfPlayersHttpCalls {
                    queue.async {
                        self.getPlayers(pageNumber: n) {}
                    }
                }
            }
        }

        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
