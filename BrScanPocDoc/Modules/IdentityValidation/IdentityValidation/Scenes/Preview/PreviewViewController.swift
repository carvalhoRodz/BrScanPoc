import Foundation
import UIKit

public final class PreviewViewController: UIViewController {
        
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.text = "A foto ficou nítida?"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Sim", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.07774543017, green: 0.7801540494, blue: 0.4376209974, alpha: 1)
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Tirar outra", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .black
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cancelButton, confirmButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Private Properties
    
    private var currentDocumentStep: DocumentStep
    
    // MARK: - Initializers
    
    init(with data: [[String : Any]], currentDocumentStep: DocumentStep) {
        self.currentDocumentStep = currentDocumentStep
        super.init(nibName: nil, bundle: nil)
        setData(with: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    public override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        self.view = view
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        constraintUI()
    }
    
    // MARK: - Private methods
    
    private func setData(with data: [[String : Any]]) {
        guard let data = data[0]["imagem"] as? String,
              let imageData = Data(base64Encoded: data) else { return }
        previewImageView.image = UIImage(data: imageData)
    }
    
    @objc private func didTapCancel() {
        // navigationController?.popViewController(animated: true)
    }
    
    private func constraintUI() {
        view.addSubview(titleLabel)
        view.addSubview(previewImageView)
        view.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            previewImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 31),
            previewImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            previewImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonsStackView.topAnchor.constraint(equalTo: previewImageView.bottomAnchor, constant: 24),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
        ])
    }

    @objc
    func nextStep() {
        switch currentDocumentStep {
        case .documentFront:
            navigationController?.pushViewController(DocSDKViewController(documentStep: .documentBack), animated: true)
        case .documentBack:
            navigationController?.pushViewController(ConfirmationViewController(), animated: true)
        }
    }
}
