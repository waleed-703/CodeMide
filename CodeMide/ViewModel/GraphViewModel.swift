import Foundation

class GraphViewModel : ObservableObject{
    @Published var points : [EEGgraphpoint] = []
    @Published var thetapoints : [EEGgraphpoint] = []
    @Published var alphapoints : [EEGgraphpoint] = []
    @Published var betapoints : [EEGgraphpoint] = []
    @Published var deltapoints : [EEGgraphpoint] = []
    @Published var gammapoints : [EEGgraphpoint] = []
    @Published var errorMessage : String?
    
    func getgraphdata(sessionid: String, sid: String){
        GraphModel.fetchgraphdata(sessionid: sessionid, sid: sid){result in
            DispatchQueue.main.async {
                switch result{
                case .success(let response):
                    var graphPoints : [EEGgraphpoint] = []
                    for i in 0..<response.time.count{
                        graphPoints.append(EEGgraphpoint(x: response.time[i],y: response.delta[i],bandtype: "delta"))
                        
                        graphPoints.append(EEGgraphpoint(x: response.time[i],y: response.theta[i],bandtype: "theta"))
                        
                        graphPoints.append(EEGgraphpoint(x: response.time[i],y: response.alpha[i],bandtype: "alpha"))
                        
                        graphPoints.append(EEGgraphpoint(x: response.time[i],y: response.beta[i],bandtype: "beta"))
                        
                        graphPoints.append(EEGgraphpoint(x: response.time[i],y: response.gamma[i],bandtype: "gamma"))
                    }
                    self.points = graphPoints
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription

                }
   
            }
        }
    }
    
    func gethetadata(sessionid: String, sid: String, qid: String){
        GraphModel.fetchThetadata(sessionid: sessionid, sid: sid, qid: qid){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let response):
                    self.thetapoints = zip(response.time, response.theta).compactMap { (t, v) in
                        guard let x = Double("\(t)"), let y = Double("\(v)") else { return nil }
                        return EEGgraphpoint(x: x, y: y, bandtype: response.band)
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getalphadata(sessionid: String, sid: String, qid: String){
        GraphModel.fetchalphaadata(sessionid: sessionid, sid: sid, qid: qid){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let response):
                    self.alphapoints = zip(response.time, response.alpha).compactMap { (t, v) in
                        guard let x = Double("\(t)"), let y = Double("\(v)") else { return nil }
                        return EEGgraphpoint(x: x, y: y, bandtype: response.band)
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getbetadata(sessionid: String, sid: String, qid: String){
        GraphModel.fetchbetadata(sessionid: sessionid, sid: sid, qid: qid){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let response):
                    self.betapoints = zip(response.time, response.beta).compactMap { (t, v) in
                        guard let x = Double("\(t)"), let y = Double("\(v)") else { return nil }
                        return EEGgraphpoint(x: x, y: y, bandtype: response.band)
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getdeltadata(sessionid: String, sid: String, qid: String){
        GraphModel.fetchdeltadata(sessionid: sessionid, sid: sid, qid: qid){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let response):
                    self.deltapoints = zip(response.time, response.delta).compactMap { (t, v) in
                        guard let x = Double("\(t)"), let y = Double("\(v)") else { return nil }
                        return EEGgraphpoint(x: x, y: y, bandtype: response.band)
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getgammadata(sessionid: String, sid: String, qid: String){
        GraphModel.fetchgammadata(sessionid: sessionid, sid: sid, qid: qid){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let response):
                    self.gammapoints = zip(response.time, response.gamma).compactMap { (t, v) in
                        guard let x = Double("\(t)"), let y = Double("\(v)") else { return nil }
                        return EEGgraphpoint(x: x, y: y, bandtype: response.band)
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

}
