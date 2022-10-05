
import UIKit


class DetailViewController: UIViewController {
    let viewModel: MemoListViewModelWithCombine
    
    private var text: UILabel = UILabel()
    private var  mainTextView = UITextView()
    private var saveButton = UIButton()
    
    let mainTextViewPlaceHolder = "텍스트를 입력하세요"
    
    // 모델
    let memoManager = CoreDataRepositoryWithCombine.shared
    var memoData = MemoData()
    
    required init(viewModel: MemoListViewModelWithCombine) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("here?")
        setupNVC()
        configureUI()
    }
    
    func setupNVC() {
        self.navigationItem.title = "할 일 작성"
    }
    
    
    func configureUI() {
        view.backgroundColor = .white
        drawTextView()
        drawBtn()
//        drawText()
    }
    
    func drawTextView() {
        view.addSubview(mainTextView)
        mainTextView.delegate = self
        mainTextView.translatesAutoresizingMaskIntoConstraints = false
        
        mainTextView.text = mainTextViewPlaceHolder
        mainTextView.textColor = .lightGray
        
        mainTextView.layer.borderWidth = 1.0
        mainTextView.layer.borderColor = UIColor.black.cgColor
        mainTextView.layer.cornerRadius = 8
        
        
        mainTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        mainTextView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    
    func drawBtn() {
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton.addTarget(self, action: #selector(saveBtnClicked), for: .touchUpInside)
        saveButton.setTitle("Save Button", for: .normal)
        saveButton.setTitleColor(.blue, for: .normal)
        
        
        saveButton.topAnchor.constraint(equalTo: mainTextView.bottomAnchor, constant: 12).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc func saveBtnClicked() {
        // TODO: 이후 데이터 존재할 경우와(Update) 생성인 경우의 분기 처리
        
        print("save btn clicked")
        print(mainTextView.text)
        
        let memoText = mainTextView.text
        viewModel.createMemoData(memoText: memoText) 
        
        self.navigationController?.popViewController(animated: true) 
//        memoManager.createMemoData(memoText: memoText) {
//            self.viewModel.loadMemoData()
//            print("[create] \(self.mainTextView.text)")
//            self.navigationController?.popViewController(animated: true)
//        }
    }
    
    func drawText() {
        view.addSubview(text)

        // MARK: No StoryBoard setup
        text.translatesAutoresizingMaskIntoConstraints = false

        // MARK: UI Component attribute setup
        text.text = "Detail View"
        

        // MARK: UI Component Layout setup
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
    // MARK: 다른 곳 터치시 editor 종료 시점 알리기 -> 키보드 내리기 등에서 사용가능 할 듯
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension DetailViewController: UITextViewDelegate {
    
    // MARK: mainTextView act like placeHolder
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if mainTextView.text == mainTextViewPlaceHolder {
            mainTextView.text = nil
            mainTextView.textColor = .black
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스 홀더처럼 입력하기 위해서 조건 확인
        if mainTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            mainTextView.text = "텍스트를 여기에 입력하세요."
            mainTextView.textColor = .lightGray
        }
    }
}
