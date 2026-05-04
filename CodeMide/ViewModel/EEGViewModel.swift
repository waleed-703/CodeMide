import Foundation

class EEGViewModel : ObservableObject{
    @Published var statusmessage : String = ""
    @Published var isStreaming : Bool = false
    @Published var isRecording : Bool = false
    @Published var errorMessage : String?
    @Published var SelfReport : String = ""
    @Published var selfReportSessionID : Int?
    @Published var isstreamconnected : Bool = false
    
    func startstream(sessionID: String, name: String){
        EEGManager.startmuse(sessionID: sessionID, name: name){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let responce):
                    self.statusmessage = responce.status
                    if responce.status.lowercased().contains("started") || responce.status.lowercased().contains("already"){
                        self.isStreaming = true
                        self.isstreamconnected = true
                    }
                    else {
                        self.isstreamconnected = false
                        self.errorMessage = "Failed To Connect Device"
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isstreamconnected = false
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
    
    func ResetAll(){
        EEGManager.resetall{result in
            DispatchQueue.main.async {
                switch result{
                case .success(let response):
                    if let status = response.status {
                        self.statusmessage = status
                    } else if let error = response.error {
                        self.errorMessage = error
                    }
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func deleteSession(sessionID: Int) {

//            isDeleting = true
            errorMessage = nil
//            deleteMessage = ""

            EEGManager.deleteSession(sessionID: sessionID) { result in
                DispatchQueue.main.async {

//                    guard let self = self else { return }
//                    self.isDeleting = false

                    switch result {

                    case .success(let response):

                        if let msg = response.message {
//                            self.deleteMessage = msg
                        } else if let err = response.error {
                            self.errorMessage = err
                        }

                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
}
