import SwiftUI

struct HomeScreen: View {
    
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @StateObject var viewModel = ReportViewModel()
//    @State var stname = ""
//    @State var semno = ""
    @AppStorage("studentName") var stname = ""
    @AppStorage("semesterNo") var semno = ""
//    @AppStorage("studentId") var studentId : Int = 0
    let studentId : Int
    @State var quiz = false
    @State var allreports = false
    @State var stprofile = false
    @State var report = false
    @State var reports: [Report] = []
    @State var errormessage = ""
    @State var showerror = false
    let sessionid : Int
    var body: some View {
            ZStack{
                teal.ignoresSafeArea()
                
                    
                VStack{
                    VStack(spacing: 20){
                        VStack(alignment: .leading,spacing: 4)
                        {
                            HStack(spacing:105){
                                Spacer()
                                Image("codemide")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
//                                Spacer()
                                
                                NavigationLink(destination: LoginScreen(),
                                    label: {
                                    Text("Logout")
                                        .fontWeight(.bold)
                                })
//                                .padding(.horizontal,3)
                            }
                            VStack(alignment: .leading, spacing: 4){
                                Text("\(stname)!")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Text(semno.isEmpty ? "" : "Semester \(semno)")
                                    .font(.title2)
                                    .fontWeight(.semibold)

                            }
                            .padding(.horizontal)
                            
                            ScrollView{
                                VStack(alignment: .leading){
                                    Text("Student Dashboard")
                                        .foregroundStyle(teal)
                                        .font(.title)
                                        .fontWeight(.semibold)

//                                    NavigationLink(destination: QuestionTabView(),
//                                                   label: {
//                                        HStack {
//                                            Image(systemName: "play")
//                                                .foregroundStyle(Color.white)
//
//                                            Text("Start New Session")
//                                                .fontWeight(.semibold)
//                                        }
//                                        .frame(maxWidth: .infinity)
//                                        .padding(.vertical,16)
//                                        .foregroundStyle(Color.white)
//                                        .background(teal)
//                                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
//                                    })

                                    VStack(alignment: .leading,spacing : 10){
                                        Text("Student Session Details")
                                            .font(.title)
                                            .foregroundStyle(teal)
                                            .fontWeight(.semibold)
                                        
                                        HStack{
                                            Text("Last Session Summary")
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(teal)
                                            
                                            
                                            Spacer()
                                            
//                                            NavigationLink(destination: AllReportsScreen(studentId : studentId),
//                                                           label: {
//                                                HStack{
//                                                    Text("See All")
//                                                        .font(.caption)
//                                                    Image(systemName: "chevron.right")
//                                                    
//                                                }
//                                                .foregroundStyle(Color.white)
//                                                .padding(.horizontal,10)
//                                                .padding(.vertical, 6)
//                                                .background(teal)
//                                                .clipShape(Capsule())
//                                                
//                                            })
                                            
                                            NavigationLink(destination: ComparisonReport(studentId: studentId, sessionid: sessionid),
                                                           label: {
                                                HStack{
                                                    Text("See Report")
                                                        .font(.caption)
                                                    Image(systemName: "chevron.right")
                                                    
                                                }
                                                .foregroundStyle(Color.white)
                                                .padding(.horizontal,10)
                                                .padding(.vertical, 6)
                                                .background(teal)
                                                .clipShape(Capsule())
                                                
                                            })
                                            
                                        }
                                        
                                        ScrollView{
                                            if reports.isEmpty{
                                                VStack{
                                                    Spacer()
                                                    Text("No Session History Found!")
                                                        .foregroundStyle(.gray)
            //                                            .multilineTextAlignment(.center)
                                                    Spacer()
                                                    
                                                }
                                                .frame(minHeight: 400)
                                                .padding(.horizontal,70)
                                            }
                                            VStack {
                                                ForEach(reports){report in
                                                    stressCard(report: report)
                                                }
                                            }
                                            
                                            }
                                        .onAppear{
                                            loadreports()
                                        }

                                    }
                                }
                                .padding(16)
                                .background(Color.white)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(12)
//                                .padding(.horizontal,8)
                            }
                            
                            
                        }
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                }
//                .onAppear{
//                    stname = UserDefaults.standard.string(forKey: "studentName") ?? ""
//                    let sem = UserDefaults.standard.string(forKey: "semesterNo") ?? ""
//                    semno = "Semester\(sem)"
//                }
                .onAppear {
                    loadStudentInfo()
                }
                .onChange(of: UserDefaults.standard.integer(forKey: "studentId")) { _ in
                    loadStudentInfo()
                }

            }
        }
    func loadStudentInfo() {
        stname = UserDefaults.standard.string(forKey: "studentName") ?? ""

        semno = UserDefaults.standard.string(forKey: "semesterNo") ?? ""

    }
    



    
//    func loadreports(){
////        let studentId = UserDefaults.standard.integer(forKey: "studentId")
//        print("Fetching reports for ID: \(studentId)")
//        ReportManager.fetchtopreports(studentId: studentId){result in
//            switch result{
//            case .success(let data):
////                print("report")
//                self.reports = data
//                
//            case .failure(let error):
////                print("error",error)
//                self.errormessage = error.localizedDescription
//                self.showerror = true
//            }
//        }
//    }
    func loadreports(){

        print("Fetching reports for ID: \(studentId)")

        ReportManager.fetchtopreports(
            studentId: studentId
        ){ result in

            DispatchQueue.main.async {

                switch result {

                case .success(let data):

                    print("✅ Reports Received")
                    print(data)

                    self.reports = data

                case .failure(let error):

                    print("❌ Report Error")
                    print(error)

                    self.errormessage =
                    error.localizedDescription

                    self.showerror = true
                }
            }
        }
    }
        func dashboardTile(title: String, icon: String) -> some View{
            VStack(spacing: 10){
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .font(.title2)
                    .foregroundStyle(Color.white)
//                    .frame(width: 45, height: 45)
                    .background(teal)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                
                Text(title)
                    .font(.footnote)
                    .foregroundStyle(Color.white)
            }
            .padding(12)
            .background(teal)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(teal.opacity(0.25))
            )
            
        }
        
    func stressCard(report: Report) -> some View{
            VStack(spacing: 14){
                HStack{
                    Text("Date: \(report.date ?? "--")")
                        .font(.subheadline)
                        .foregroundStyle(Color.black)
                    
                    Spacer()
                    NavigationLink(destination: ReportScreen(sid: studentId, sessionid: report.sessionId),
                    label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.teal)
                            .font(.title)
                            .padding(.horizontal,8)
                    })

                }
                
                HStack(spacing: 10){
                    metrichip(title: "\(report.afterQuestionBP ?? "--")\nmmHg",icon: "cuff")
//                        .frame(width: 125, height: 120)
                    metrichip(
                        title: String(format: "%.2f\nbpm", report.heartRate ?? 0),
                        icon: "ppg")
//                        .frame(width: 110, height: 150)
                    metrichip(title: "\(Int(report.sdnn ?? 0))\nms", icon: "heart")
                        .frame(width: 100, height: 90)


                }
                .frame(maxWidth: .infinity)
                
                
                HStack{
                    Spacer()
                    Text("Stress Level :")
                        .font(.subheadline)
                        .foregroundStyle(Color.black)
                    Text(stressLevelText(report.stressLevel))
                        .font(.subheadline)
                        .foregroundStyle(teal)
                    
                    Spacer()
                }
                
                
            }
            .padding(8)
//            .padding(.vertical,2)
            .frame(maxWidth: .infinity)
            .background(teal.opacity(0.2))
            .cornerRadius(12)
//            .padding(.horizontal,8)
            
//            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            
            
        }
        
        
        func metrichip(title: String, icon: String) -> some View{
            HStack(spacing: 6){
                Image(icon)
                    .resizable()
                    .scaledToFit()
//                    .font(.footnote)
                    .foregroundStyle(.white)
                Text(title)
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity,minHeight: 60)
            .padding(.vertical,8)
            .padding(.horizontal,10)
            .background(teal)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2),lineWidth: 1))
        }
    
    func stressLevelText(_ value: String?) -> String {
        switch Int(value ?? "") {
        case 0: return "Low"
        case 1: return "Medium"
        case 2: return "High"
        default: return "--"
        }
    }

        
}


#Preview {
    NavigationStack{
        HomeScreen(studentId: 0,sessionid: 0)
    }
}
