import Foundation

class BPViewModel : ObservableObject{
    @Published var baselineBP : BPData?
    @Published var errorMessage : String?
    @Published var isbaselinesaved : Bool = false
    
    @Published var endBP : EndBP?
//    @Published var postBP : EndBP?
    @Published var history : [(BPData,EndBP)] = []
    
    
    func measurebaselinebp(){
        BPManager.measurebaseline(){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let data):
                    self.baselineBP = data
                    self.isbaselinesaved = true
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isbaselinesaved = false
                }
            }
            
        }
    }
    
    func measureendbp(){

        BPManager.measurepostbp(){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let data):
                    self.endBP = data
//                    self.postBP = postBP
                    guard let baselineBP = self.baselineBP else{
                        return
                    }
                    self.history.append((baselineBP,data))
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    
                }
            }
        }
    }
}
