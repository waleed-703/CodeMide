import Foundation

class PPGViewModel: ObservableObject {

    // MARK: - RAW DATA
    @Published var allPPG: ppg_session?
    @Published var singlePPG: ppg_question?

    // MARK: - GRAPH DATA
    @Published var ppgPoints: [ppgdata] = []              // For full session
    @Published var questionPPGPoints: [ppgdata] = []      // For single question

    // MARK: - STATE
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - FETCH ALL (SESSION GRAPH)
    func getAllPPG(sessionID: String, sid: String) {

        isLoading = true
        errorMessage = nil

        PPGManager.fetchAllPPG(sessionID: sessionID, sid: sid) { result in
            DispatchQueue.main.async {
                self.isLoading = false

                switch result {
                case .success(let response):
                    self.allPPG = response
                    self.prepareSessionGraphData(response)

                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: - FETCH SINGLE (QUESTION GRAPH)
    func getSinglePPG(sessionID: String, sid: String, qid: String) {

        isLoading = true
        errorMessage = nil

        PPGManager.fetchSinglePPG(sessionID: sessionID, sid: sid, qid: qid) { result in
            DispatchQueue.main.async {
                self.isLoading = false

                switch result {
                case .success(let response):
                    self.singlePPG = response
                    self.prepareQuestionGraphData(response)

                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: - PREPARE SESSION GRAPH DATA (/allp)
    private func prepareSessionGraphData(_ data: ppg_session) {

        var points: [ppgdata] = []

        for i in 0..<data.time.count {

            let t = data.time[i]

            if i < data.HR.count {
                points.append(ppgdata(x: t, y: data.HR[i], type: "HR"))
            }
            if i < data.SDNN.count {
                points.append(ppgdata(x: t, y: data.SDNN[i], type: "SDNN"))
            }
            if i < data.RMSSD.count {
                points.append(ppgdata(x: t, y: data.RMSSD[i], type: "RMSSD"))
            }
            if i < data.pNN50.count {
                points.append(ppgdata(x: t, y: data.pNN50[i], type: "pNN50"))
            }
        }

        self.ppgPoints = points
    }

    // MARK: - PREPARE QUESTION GRAPH DATA (/single)
    private func prepareQuestionGraphData(_ data: ppg_question) {

        var points: [ppgdata] = []

        for i in 0..<data.HR.count {

            let t = Double(i) // ⚠️ No time array in /single → use index

            if i < data.HR.count {
                points.append(ppgdata(x: t, y: data.HR[i], type: "HR"))
            }
            if i < data.SDNN.count {
                points.append(ppgdata(x: t, y: data.SDNN[i], type: "SDNN"))
            }
            if i < data.RMSSD.count {
                points.append(ppgdata(x: t, y: data.RMSSD[i], type: "RMSSD"))
            }
            if i < data.pNN50.count {
                points.append(ppgdata(x: t, y: data.pNN50[i], type: "pNN50"))
            }
        }

        self.questionPPGPoints = points
    }
}
