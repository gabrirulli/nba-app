import Foundation
import Alamofire

class PlayersCollector {
    var numberOfPlayersHttpCalls: Int = 0
    let userDefaults = UserDefaults.standard
    
    func getPlayers() {
        let queue = DispatchQueue(label: "players.concurrentQueue", attributes: .concurrent)
        
        // Check if key `playersDownloaded` was previously saved in UserDefaults
        // If not, download all the players
        let playersDownloaded = self.userDefaults.bool(forKey: "playersDownloaded")
        if playersDownloaded == false {
            print("daje")
            DispatchQueue.global(qos: .background).async {
                self.savePlayers() {
                    for n in 1...self.numberOfPlayersHttpCalls {
                        queue.async {
                            self.savePlayers(pageNumber: n) {}
                        }
                    }
                }
            }
        }
        
        // Save the `playersDownloaded` key in UserDefaults
        self.userDefaults.set(true, forKey: "playersDownloaded")
        self.userDefaults.synchronize()
    }
    
    private func savePlayers(pageNumber: Int = 0, completionHandler: @escaping () -> Void) {
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
}
