import Foundation

class EEGViewModel : ObservableObject{
    @Published var statusmessage : String = ""
    @Published var isStreaming : Bool = false
    @Published var isRecording : Bool = false
    @Published var errorMessage : String?
    @Published var SelfReport : String = ""
    @Published var selfReportSessionID : Int?
    
    func startstream(sessionID: String, name: String){
        EEGManager.startmuse(sessionID: sessionID, name: name){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let responce):
                    self.statusmessage = responce.status
                    self.isStreaming = responce.status.lowercased().contains("started")
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
            
        }
    }
    
    func stopstream(){
        EEGManager.stopmuse{result in
            DispatchQueue.main.async{
                switch result{
                case .success(let responce):
                    self.statusmessage = responce.status
                    self.isStreaming = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                
            }
        }
    }
    
    func startrecording(sessionID: String, questionID: String){
        EEGManager.startrecording(sessionID: sessionID,questionID: questionID){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let responce):
                    self.statusmessage = responce.status
                    self.isRecording = responce.status.lowercased().contains("started")
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func stoprecording(answers: String, gptIndex: Int){
        EEGManager.stoprecording(answers: answers,gptIndex: gptIndex){result in
            DispatchQueue.main.async {
                switch result{
                case .success(let responce):
                    self.statusmessage = responce.status
                    self.isRecording = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func sumbitselfreport(mental: Int, effort: Int , frustration: Int,comments: String){
        EEGManager.selfresponcereport(mental: mental, effort: effort, frustration: frustration, comments: comments){result in
            DispatchQueue.main.async {
                switch result{
                case .success(let response):
                    self.SelfReport = response.status
                    self.selfReportSessionID = response.sessionid
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
}
