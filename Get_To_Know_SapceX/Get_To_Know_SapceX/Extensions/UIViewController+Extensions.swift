import UIKit

extension UIViewController {
    
    func addCloseButton() {
        let barButton = UIBarButtonItem(image: UIImage(named: "nav_close"), style: .plain, target: self, action: #selector(_closeTapped))
        navigationItem.leftBarButtonItem = barButton
        navigationItem.rightBarButtonItems = nil
    }
    
    @IBAction private func _closeTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    var alertController: UIAlertController? {
        guard let alert = UIApplication.topViewController() as? UIAlertController else { return nil }
        return alert
    }
    
    
    func canPerformSegue(withIdentifier id: String) -> Bool {
        guard let segues = self.value(forKey: "storyboardSegueTemplates") as? [NSObject] else { return false }
        return segues.first { $0.value(forKey: "identifier") as? String == id } != nil
    }

    /// Performs segue with passed identifier, if self can perform it.
    func performSegueIfPossible(id: String?, sender: AnyObject? = nil) {
        guard let id = id, canPerformSegue(withIdentifier: id) else { return }
        self.performSegue(withIdentifier: id, sender: sender)
    }
    
    func showErrorAlert() {
        
    }
    
}
