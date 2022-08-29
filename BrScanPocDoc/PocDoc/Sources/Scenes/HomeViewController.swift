import UIKit

final class HomeViewController: UIViewController {

    private var nc: UINavigationController
    
    // MARK: - UI
    
    private lazy var btnDocSDK: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SDK Doc", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.1370031536, green: 0.3350041509, blue: 0.2176305652, alpha: 1)
        button.addTarget(self, action: #selector(openDocSDK), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializers
    init() {
        self.nc = UINavigationController()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = #colorLiteral(red: 0.07774543017, green: 0.7801540494, blue: 0.4376209974, alpha: 1)
        self.view = view
    }

    override func viewDidLoad() {
        buildViewHierarchy()
        setupConstraints()
    }
    
    // MARK: - Private methods
    private func buildViewHierarchy() {
        view.addSubview(btnDocSDK)
    }

    private func setupConstraints() {
        btnDocSDK.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnDocSDK.widthAnchor.constraint(equalToConstant: 100).isActive = true
        btnDocSDK.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnDocSDK.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc private func openDocSDK() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(DocSDKViewController(documentStep: .documentFront), animated: true)
    }
}
