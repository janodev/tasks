
import UIKit

public class Coordinator: UIResponder
{
    enum Screen {
        case login
        case tasks
    }
    
    private(set) var navigationController: UINavigationController!
    
    init(screen: Screen){
        super.init()
        self.navigationController = UINavigationController(rootViewController: controller(screen: screen))
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isHidden = true
    }
    
    func show(screen: Screen){
        navigationController.show(controller(screen: screen), sender: self)
    }
    
    func alert(title: String, message: String, okAction: @escaping (UIAlertAction) -> Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: okAction))
        navigationController.present(alert, animated: true, completion: nil)
    }
    
    func controller(screen: Screen) -> UIViewController {
        switch screen {
        case .login:
            let interactor = LoginInteractor(coordinator: self)
            return LoginViewController(url: LoginDetails.loginURL, navigationDelegate: interactor)
        case .tasks:
            let interactor = TasksInteractor()
            return TasksViewController(interactor: interactor)
        }
    }
}
