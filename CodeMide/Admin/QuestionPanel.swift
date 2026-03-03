import SwiftUI

struct QuestionPanel: View {
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    
    @StateObject private var viewModel = QuestionViewModel()
    @State private var editquestion = false
    @State private var addquestion = false
    @State var questionid = ""
    @State var questionst = ""
    @State var questionduration = ""
    @State var queslevel = ""
    @State private var selectedQuestion : Question?
    @State var deletealert = false
    var body: some View {
        ScrollView{
            VStack(spacing: 12){
                ForEach(viewModel.questions){ question in
                    HStack{
                        VStack(alignment: .leading){
                            Text("Q\(String(question.id)):")
                                .bold()
                                .foregroundStyle(Color.white)
                                
                            Text(question.description)
                                .font(.caption)
                                .foregroundStyle(Color.white)
                            HStack {
                                Text("Duration: \(question.duration) |")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.white)
                                Text("Count: \(question.count)")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.white)
                            }
                            Text("Question Level: \(question.questionlevel ?? "")")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.white)
                            
                            HStack{
                                Spacer()
                                NavigationLink{
                                    AdminReport()
                                }label: {
                                    Image(systemName: "doc.on.clipboard.fill")
                                    Text("Report")
                                        .font(.subheadline)
                                }
                                .padding(.horizontal,12)
                                .padding(.vertical,6)
                                //                    .frame(maxWidth: .infinity)
                                .foregroundStyle(teal)
                                .background(Color.white)
                                .clipShape(Capsule())
                                
                                
                                Button{
                                    viewModel.selectedQuestion = question
                                    editquestion = true

                                }label: {
                                    Image(systemName: "pencil")
                                    Text("Edit")
                                        .font(.subheadline)
                                }
                                .padding(.horizontal,12)
                                .padding(.vertical,6)
                                .foregroundStyle(teal)
                                .background(Color.white)
                                .clipShape(Capsule())
                                
                                Button{
                                    deletealert = true
                                    viewModel.deletequestion(id: question.qid)
                                }label: {
                                    Image(systemName: "trash")
                                    Text("Delete")
                                        .font(.subheadline)

                                }
                                .padding(.horizontal,12)
                                .padding(.vertical,8)
                                .foregroundStyle(.red)
                                .background(Color.white)
                                .clipShape(Capsule())
                                
                                Spacer()
                                
                            }
                            
                            
                            
                        }
                    }
                    .padding(10)
                    .background(.teal.opacity(0.9))
                    .cornerRadius(16)
                    
                    .alert("Delete!",isPresented: $deletealert){
                        Button("OK",role:.cancel){
                        
                        }
                    }message:{
                        Text("Question Deleted Successfully.")
                    }
                }
            }
            .onAppear{
                viewModel.fetchQuestion()
            }
            .onChange(of: viewModel.selectedQuestion) { question in
                if let q = question {
               questionid = "\(q.id)"
               questionst = q.description
               questionduration = "\(q.duration)"
               queslevel = q.questionlevel ?? ""

                    
                        }
                    }
        }
        
        
        Button{
            questionid = ""
            questionst = ""
            questionduration = ""
            queslevel = ""
            addquestion = true
        }label:{
            Image(systemName: "plus")
            Text("Add Question")
        }
        .foregroundStyle(.teal)
        .frame(maxWidth: 130)
        .padding()
        .background(teal.opacity(0.3))
        .cornerRadius(12)
        
        
        
        .sheet(isPresented: $editquestion){
            if viewModel.selectedQuestion != nil{
                VStack(alignment: .leading){
                    
                    HStack{
                        
                        Text("Edit Question")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(teal)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.white)
                }
                        
                        VStack(alignment:.leading){
                            Text("Question ID:")
                                .foregroundStyle(.white)
                            TextField("",text: $questionid)
                                .frame(maxWidth: 300)
                                .padding(12)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            
                            Text("Question Text:")
                                .foregroundStyle(.white)
                            TextField("",text: $questionst)
                                .frame(maxWidth: 300)
                                .padding(12)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            
                            Text("Duration:")
                                .foregroundStyle(.white)
                            TextField("",text: $questionduration)
                                .frame(maxWidth: 300)
                                .padding(12)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            
                            Text("Question Level:")
                                .foregroundStyle(.white)
                            TextField("",text: $queslevel)
                                .frame(maxWidth: 300)
                                .padding(12)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                
                            
                            HStack{
                             
                                Button{
                                    if let selected = viewModel.selectedQuestion{
                                        viewModel.updateQuestion(
                                            id : selected.qid,
                                            description : questionst,
                                            duration : Int(questionduration) ?? 0,
                                            questionlevel : queslevel
                                            
                                        ){
                                            editquestion = false
                                        }
                                    }
                                    
                                }label:{
                                    Text("Save")
                                        .foregroundStyle(teal)
                                }
                                .frame(maxWidth: 130)
                                .padding()
                                .background(.white)
                                .cornerRadius(12)
                                
    //                            Spacer()
                                
                                Button{
                                    editquestion = false
                                }label:{
                                    Text("Delete")
                                        .foregroundStyle(teal)
                                }
                                .frame(maxWidth: 130)
                                .padding()
                                .background(.white)
                                .cornerRadius(12)
                            }
                            
//                            .presentationDetents([.medium])
                            .presentationDetents([.fraction(0.7)])
                                
                        }
                        .padding(.horizontal,36)
                        .padding(.vertical,12)
                        .background(teal)
                        .cornerRadius(8)
    //                    .padding()
                
            }
            
                
        }
        
        
        
        
        .sheet(isPresented: $addquestion){
            VStack(alignment: .leading){
                
                HStack{
                    
                    Text("ADD Question")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(teal)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color.white)
            }
                    
                    VStack(alignment:.leading){
                        Text("Question ID:")
                            .foregroundStyle(.white)
                        TextField("",text: $questionid)
                            .frame(maxWidth: 300)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                        Text("Question Text:")
                            .foregroundStyle(.white)
                        TextField("",text: $questionst)
                            .frame(maxWidth: 300)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                        Text("Duration:")
                            .foregroundStyle(.white)
                        TextField("",text: $questionduration)
                            .frame(maxWidth: 300)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                        Text("Question Level:")
                            .foregroundStyle(.white)
                        TextField("",text: $queslevel)
                            .frame(maxWidth: 300)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            
                        
                        HStack{
                         
                            Button {
                                viewModel.addquestion(
                                    description: questionst,
                                    duration: Int(questionduration) ?? 0,
                                    questionlevel : queslevel
                                ) {
                                    addquestion = false
                                    questionid = ""
                                    questionst = ""
                                    questionduration = ""
                                    queslevel = ""
                                }
                            } label: {
                                Text("Save")
                                    .foregroundStyle(teal)
                            }
                            .frame(maxWidth: 130)
                            .padding()
                            .background(.white)
                            .cornerRadius(12)

//                            Spacer()
                            
                            Button{
                                addquestion = false
                            }label:{
                                Text("Back")
                                    .foregroundStyle(.teal)
                            }
                            .frame(maxWidth: 130)
                            .padding()
                            .background(.white)
                            .cornerRadius(12)
                        }
                            
                    }
                    .padding(.horizontal,36)
                    .padding(.vertical,12)
                    .background(teal)
                    .cornerRadius(8)
//                    .padding()
                    
//                .presentationDetents([.medium])
                  .presentationDetents([.fraction(0.7)])
        }
    }
}

#Preview {
    NavigationStack{
        QuestionPanel()
    }
}
