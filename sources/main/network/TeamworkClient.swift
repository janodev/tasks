
import Foundation

public class TeamworkClient: ApiClient
{
    init?(authentication: Authentication?){
        guard let authentication = authentication else { return nil }
        let session = TeamworkClient.createSession(authorizationHeader: authentication.authorizationHeader)
        guard let baseURL = URL(string: "https://" + authentication.company + ".teamwork.com") else {
            return nil
        }
        super.init(session: session, baseURL: baseURL)
    }
    
    override init(session: URLSessionProtocol, baseURL: URL){
        super.init(session: session, baseURL: baseURL)
    }
    
    static func createSession(authorizationHeader: [String: String]) -> URLSession {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = authorizationHeader
        config.httpAdditionalHeaders?["Accept"] = "application/json"
        return URLSession(configuration: config)
    }
    
    func allTasks(completion: @escaping ApiResultCompletion<AllTasksResponse>) {
        let resource = Resource(path: "/tasks.json")
        fetch(resource: resource) { (result: ApiResult<AllTasksResponse>) in
            self.complete(completion: completion, result: result)
        }
    }
    
    func taskLists(completion: @escaping ApiResultCompletion<TaskListsResponse>) {
        let resource = Resource(path: "/tasklists.json")
        fetch(resource: resource) { (result: ApiResult<TaskListsResponse>) in
            self.complete(completion: completion, result: result)
        }
    }
    
    func complete<T>(completion: @escaping ApiResultCompletion<T>, result: ApiResult<T>){
        switch result {
        case .success(_):
            completion(result)
        case .error(let e):
            completion(.error(e))
        }
    }
}
