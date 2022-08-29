import UIKit
import brscan_sdk_documento_ios

final class DocSDKViewController: UIViewController {

    private var documentStep: DocumentStep
    private var sdkViewController: CapturarDocumentoViewController

    init(documentStep: DocumentStep) {
        self.documentStep = documentStep
        sdkViewController = CapturarDocumentoViewController(
            chave: "",
            cropDocumento: true,
            validaDocumento: true,
            wizard: false,
            aceitaAB: false,
            tiposDocumentosAceitos: ["cnh", "rg"],
            segurancaExtra: true,
            segurancaExtraSslPinning: true,
            segurancaExtraRootCheck: true,
            timeoutCapturaManual: 60,
            telaSelecaoDocumento: false,
            resolucao: "low",
            dicaSlide: false,
            ladoDocumentoAceito: documentStep.rawValue,
            tipoRetorno: "base64",
            telaPreview: false,
            scoreMinimo: 60,
            customizacaoTexto: ConfiguracaoTextoDocumento(),
            retornarErros: true,
            verificarLuminosidade: true,
            tempoDelayMensagem: 0,
            acessibilidade: true,
            segurancaExtraEmulatorCheck: true,
            tokenTentativa: 1
        )
        
        super.init(nibName: nil, bundle: nil)
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSDKViewController()
        setupConstraints()
    }

    private func showPreview(with data: [[String : Any]]) {
        let previewViewController = PreviewViewController(
            with: data,
            currentDocumentStep: documentStep
        )
        navigationController?.pushViewController(previewViewController, animated: true)
    }
    
    private func setupSDKViewController() {
        sdkViewController.delegate = self
        addChild(sdkViewController)
        view.addSubview(sdkViewController.view)
        sdkViewController.didMove(toParent: self)
    }
    
    private func setupConstraints(){
        sdkViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sdkViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sdkViewController.view.bottomAnchor.constraint (equalTo: view.bottomAnchor).isActive = true
        sdkViewController.view.rightAnchor.constraint (equalTo: view.rightAnchor).isActive = true
    }
}

// MARK: SDK Delegate
extension DocSDKViewController: CapturarDocumentoViewControllerDelegate {
    func documentCallbackListener(_ documentCallback: [String : Any]) {
        print("PP: Novo ERRO \(documentCallback)")
    }

    func sucesso(_ documento: [[String : Any]]) {
        print("PP: SUCESSO \(documento.description)")
        showPreview(with: documento)
    }

    func erro(_ erro: [String : Any]) {
        print("PP: ERRO DIC \(erro)")

        if let desc = erro["descricao"] as? String {
            print("Descrição = \(desc)")
        }
        fecharTelaDeDocumento()
    }
    
    func fecharTelaDeDocumento() {
        navigationController?.popToRootViewController(animated: true)
    }
}
