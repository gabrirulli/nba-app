import Foundation
import Alamofire

class HttpRequestManager
{
    static func headers() -> HTTPHeaders
    {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "X-RapidAPI-Key": ProcessInfo.processInfo.environment["api_key"]!
        ]
        
        return headers
    }
    
    static func baseUrl() -> String
    {
        return "https://free-nba.p.rapidapi.com"
    }
}
