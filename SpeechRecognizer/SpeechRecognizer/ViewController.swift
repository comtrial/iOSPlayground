//
//  ViewController.swift
//  SpeechRecognizer
//
//  Created by 최승원 on 2022/10/06.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate, UITextViewDelegate {
    private var button = UIButton()
    private var sttTextView = UITextView()
    let sttTextViewPlaceHolder = "아래 버튼을 클릭하세요"
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechRecognizer.delegate = self
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        drawButton()
        drawTextView()
    }
    
    func drawButton() {
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
    
        button.setTitle("click to ready for speak", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(btnClicked), for: .touchDown)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    func drawTextView() {
        view.addSubview(sttTextView)
        
        sttTextView.translatesAutoresizingMaskIntoConstraints = false
        sttTextView.isUserInteractionEnabled = false
        sttTextView.delegate = self
        sttTextView.font = UIFont.init(name: "Avenir", size: 18)
        sttTextView.text = sttTextViewPlaceHolder
        sttTextView.textColor = .lightGray
        
        NSLayoutConstraint.activate([
            sttTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sttTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sttTextView.heightAnchor.constraint(equalToConstant: 100),
            sttTextView.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    @objc func btnClicked() {
        print("click")
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            button.isEnabled = false
            button.setTitle("Start Recognition", for: .normal)
            button.backgroundColor = .systemBlue
        } else {
            startRecording()
            button.setTitle("Stop Recognition", for: .normal)
            button.backgroundColor = .systemGray
        }
    }
    
    func startRecording() {
            
            if recognitionTask != nil {
                recognitionTask?.cancel()
                recognitionTask = nil
            }
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.record)
                try audioSession.setMode(AVAudioSession.Mode.measurement)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            } catch {
                print("audioSession properties weren't set because of an error.")
            }
            
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            let inputNode = audioEngine.inputNode
        
//            guard let inputNode = audioEngine.inputNode else {
//                fatalError("Audio engine has no input node")
//            }
            
            guard let recognitionRequest = recognitionRequest else {
                fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
            }
            
            recognitionRequest.shouldReportPartialResults = true
            
            recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
                
                var isFinal = false
                
                if result != nil {
                    print(result)
                    self.sttTextView.text = result?.bestTranscription.formattedString
                    isFinal = (result?.isFinal)!
                }
                
                if error != nil || isFinal {
                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    
                    self.recognitionRequest = nil
                    self.recognitionTask = nil
                    
                    self.button.isEnabled = true
                }
            })
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
                self.recognitionRequest?.append(buffer)
            }
            
            audioEngine.prepare()
            
            do {
                try audioEngine.start()
            } catch {
                print("audioEngine couldn't start because of an error.")
            }
            
            sttTextView.text = "Say something, I'm listening!"
            
        }
        
        
       
        func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
            if available {
                button.isEnabled = true
            } else {
                button.isEnabled = false
            }
        }
}

