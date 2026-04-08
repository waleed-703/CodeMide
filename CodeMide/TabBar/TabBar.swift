
import SwiftUI
enum Tabs :Int {
    case Home = 0
    case Quiz = 1
    case Report = 2
    case Profile = 3
}
struct TabBar:View {
    @Binding var selectedTab : Tabs
    var body: some View {
        
        HStack(alignment: .center){
            
            Spacer()
            
            Button{
                selectedTab = .Home
            }label: {
                ZStack{
                    if selectedTab == .Home {
                        Circle()
                            .fill(Color.teal.opacity(0.2))
                            .frame(width: 50, height: 50)
                    }
                    VStack(alignment:.center, spacing: 4){
                        Image(systemName: "house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    
                }
            }
            
            Spacer()
            
            Button{
                selectedTab = .Quiz
            }label: {
                ZStack{
                    if selectedTab == .Quiz {
                        Circle()
                            .fill(Color.teal.opacity(0.2))
                            .frame(width: 50, height: 50)
                    }
                        VStack(alignment:.center, spacing: 4){
                            Image(systemName: "list.clipboard")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                    }
            }
            
            Spacer()
            
            Button{
                selectedTab = .Report
            }label: {
                ZStack{
                    if selectedTab == .Report {
                        Circle()
                            .fill(Color.teal.opacity(0.2))
                            .frame(width: 50, height: 50)
                    }
                    VStack(alignment:.center, spacing: 4){
                        Image(systemName: "doc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                }
            }
            
            Spacer()
            
            Button{
                selectedTab = .Profile
            }label: {
                ZStack {
                    if selectedTab == .Profile {
                        Circle()
                            .fill(Color.teal.opacity(0.2))
                            .frame(width: 50, height: 50)
                    }
                
                VStack(alignment:.center, spacing: 4){
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
            }
            }
            Spacer()
                .navigationBarBackButtonHidden(true)
        }
        .foregroundStyle(.teal)
        .padding(.vertical, 12)
//        .padding(.horizontal, 20)
        .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
                )
//        .background(.teal)
        .padding(.horizontal, 12)
        .padding(.bottom, 20)
//
    
    }
}
#Preview {
    TabBar(selectedTab: .constant(.Home))
}
