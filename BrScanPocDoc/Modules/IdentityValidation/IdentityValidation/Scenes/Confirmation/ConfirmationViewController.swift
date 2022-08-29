import Foundation
import UIKit

public final class ConfirmationViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var feedbackImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Clock")
        imageView.heightAnchor.constraint(equalToConstant: 176).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 176).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.text = "Validação em análise"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.text = "Estamos analisando as fotos que você enviou e, em até xx minutos, vamos te informar o resultado por notificação e e-mail, beleza?"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Ok, entendi", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.07774543017, green: 0.7801540494, blue: 0.4376209974, alpha: 1)
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationController?.isNavigationBarHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    public override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        self.view = view
    }
    
    // MARK: - Private methods
    @objc private func didTapConfirm() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupConstraints() {
        view.addSubview(feedbackImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(confirmButton)

        NSLayoutConstraint.activate([
            feedbackImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feedbackImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
        ])
    }
}
