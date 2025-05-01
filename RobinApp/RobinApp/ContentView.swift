import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.89, green: 0.96, blue: 1.0)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()
                    Image("vv")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: UIScreen.main.bounds.height * 0.5)
                        .clipped()
                        .edgesIgnoringSafeArea(.bottom)
                }

                VStack {
                    Spacer().frame(height: 60)

                    Text("Welcome to Robinhood")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Text("Join 23 million customers with access to US stocks and put your money in motion.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.top, 5)

                    Spacer()

                    HStack(spacing: 20) {
                        NavigationLink(destination: LoginView()) {
                            Text("Log in")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                        }

                        NavigationLink(destination: SignUpView()) {
                            Text("Sign up")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

struct LoginView: View {
    @AppStorage("username") private var storedUsername: String = ""
    @AppStorage("password") private var storedPassword: String = ""
    
    @State private var username = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var isLoggedIn = false

    var body: some View {
        ZStack {
            Color(red: 0.89, green: 0.96, blue: 1.0)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer().frame(height: 60)

                Text("Log In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                    .padding(.top, 20)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                    .padding(.top, 10)

                Spacer()

                Button(action: {
                    if username == storedUsername && password == storedPassword {
                        isLoggedIn = true
                    } else {
                        showAlert = true
                    }
                }) {
                    Text("Log in")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Invalid credentials"), message: Text("Please check your username and password."), dismissButton: .default(Text("OK")))
                }
                .background(
                    NavigationLink(destination: NextPageView(), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                )
            }
        }
    }
}

struct SignUpView: View {
    @AppStorage("username") private var storedUsername: String = ""
    @AppStorage("password") private var storedPassword: String = ""
    @AppStorage("email") private var storedEmail: String = ""

    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var isSignedUp = false

    var body: some View {
        ZStack {
            Color(red: 0.89, green: 0.96, blue: 1.0)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer().frame(height: 60)

                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                    .padding(.top, 20)

                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                    .padding(.top, 10)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                    .padding(.top, 10)

                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                    .padding(.top, 10)

                Spacer()

                Button(action: {
                    if username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty || password != confirmPassword {
                        showAlert = true
                    } else {
                        storedUsername = username
                        storedPassword = password
                        storedEmail = email
                        isSignedUp = true
                    }
                }) {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Invalid Input"), message: Text("Please make sure all fields are filled out correctly and passwords match."), dismissButton: .default(Text("OK")))
                }
                .background(
                    NavigationLink(destination: NextPageView(), isActive: $isSignedUp) {
                        EmptyView()
                    }
                )
            }
        }
    }
}

//

struct Stock {
    let symbol: String
    let name: String
    let change: Double
}

let mockStocks: [Stock] = [
    Stock(symbol: "BAC", name: "Bank of America", change: 0.55),
    Stock(symbol: "SYF", name: "Synchrony Financial", change: 0.63),
    Stock(symbol: "LOGC", name: "ContextLogic", change: 0.28),
    Stock(symbol: "AAPL", name: "Apple", change: 0.22),
    Stock(symbol: "META", name: "Meta Platforms", change: 0.01),
    Stock(symbol: "BEP", name: "Brookfield Renewables", change: 0.04),
    Stock(symbol: "AAL", name: "American Airlines", change: 0.00),
    Stock(symbol: "PWRD", name: "TCW Transform", change: -0.07)
]

struct NextPageView: View {
    @State private var isWaveGraphVisible = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.ignoresSafeArea()
            

            ScrollView(showsIndicators: false) {
                
                HStack {
                    HStack(spacing: 4) {
                        Text("Investing")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                        
                    }

                    Spacer()

                    Button(action: {
                        // Action for Earn $5
                    }) {
                        Text("Earn $5")
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(14)
                    }

                    Button(action: {
                        // Action for search
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                    }

                    Button(action: {
                    }) {
                        Image(systemName: "bell")
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)

                
                
                
                
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: - Top Info Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("$97.81")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Investing")
                            .foregroundColor(.gray)
                        
                        Text("▲ $215.21 All time")
                            .foregroundColor(.green)
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)
                    
                    if isWaveGraphVisible {
                        Rectangle()
                            .frame(height: 160)
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .overlay(
                                Image("xx")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width - 32, height: 160) // Set width and height
                                    .clipped()
                            )
                    } else {
                        Rectangle()
                            .fill(Color.green)
                            .frame(height: 160)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        // MARK: - Upload Document Section
                        HStack {
                            Image(systemName: "arrow.up.doc")
                                .foregroundColor(.gray)
                                .font(.title2)
                            Text("Upload Your Document")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        
                        Text("Take a photo of your bank statement now to continue using Robinhood.")
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                        Button(action: {}) {
                            Text("Take Photo Now")
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Cash")
                                .font(.title3)
                                .foregroundColor(.white)
                            
                            HStack {
                                Text("Cash balance")
                                Spacer()
                                Text("$97.81")
                            }
                            .foregroundColor(.white)
                            .font(.subheadline)
                            
                            HStack {
                                Text("Current interest rate")
                                Spacer()
                                Text("0% APY")
                            }
                            .foregroundColor(.white)
                            .font(.subheadline)
                            
                            Button(action: {}) {
                                Text("Earn 4.5% APY")
                                    .foregroundColor(.green)
                                    .font(.subheadline)
                            }
                            
                            Divider().background(Color.gray)
                        }
                        
                        // MARK: - Prediction Markets
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Prediction markets")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            VStack(spacing: 12) {
                                marketRow(icon: "cube.box", title: "Fed decision in May")
                                marketRow(icon: "cube.box.fill", title: "Inflation in April")
                            }
                        }
                        
                        // MARK: - Watchlist Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Watchlist")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            ForEach(mockStocks, id: \.symbol) { stock in
                                stockRow(stock)
                            }
                        }
                        
                        Spacer().frame(height: 120)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
            }
            // MARK: - Bottom Tab Bar
            HStack(spacing: 40) {
                Image(systemName: "chart.bar.fill")
                Image(systemName: "dollarsign.circle")
                Image(systemName: "gearshape")
                NavigationLink(destination: MenuView()) {
                    Image(systemName: "person.crop.circle.fill")
                }
//                Image(systemName: "rectangle.stack.person.crop")
            }
            
            .font(.title2)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .foregroundColor(.white)
        }
    }

    // MARK: - Helper Views

    func marketRow(icon: String, title: String) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 30)
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(10)
        .overlay(
            Image("xx1")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                .clipped()
        )
    }

    func stockRow(_ stock: Stock) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(stock.symbol)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text(stock.name)
                    .foregroundColor(.gray)
                    .font(.caption)
            }

            Spacer()

            Rectangle()
                .fill(stock.change >= 0 ? Color.green : Color.red)
                .frame(width: 60, height: 24)
                .overlay(
                    Image("xx1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 24)
                        .clipped()
                )

            Text(String(format: "%+.2f%%", stock.change))
                .font(.caption)
                .fontWeight(.bold)
                .padding(6)
                .background(stock.change >= 0 ? Color.green : Color.red)
                .cornerRadius(6)
                .foregroundColor(.black)
        }
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(10)
    }
}



struct MenuView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 20) {
                        // MARK: - Top Bar
                        HStack {
                            NavigationLink(destination: SettingsView()) {
                                   Image(systemName: "line.horizontal.3")
                                       .foregroundColor(.white)
                                       .padding()
                               }
                               Spacer()
                        }

                        // MARK: - Profile
                        VStack(spacing: 8) {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(.white)

                            Text("Vijaya venkatesh")
                                .foregroundColor(.white)
                                .font(.headline)

                            Text("$97.81")
                                .foregroundColor(.white)
                                .font(.title)

                            Text("Total in Robinhood")
                                .foregroundColor(.gray)
                                .font(.caption)

                            Button(action: {}) {
                                Text("Add account")
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                            }
                        }

                        // MARK: - APY Banner
                        HStack {
                            Image(systemName: "percent")
                                .foregroundColor(.yellow)
                            Text("Get a 4.5% APY boost on your brokerage cash! Terms apply.")
                                .foregroundColor(.white)
                                .font(.subheadline)
                                .lineLimit(2)
                            Spacer()
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)

                        // MARK: - Investment Breakdown
                        VStack(spacing: 20) {
                            HStack(spacing: 20) {
                                ForEach(["Stocks", "ETFs", "Options", "Crypto"], id: \.self) { tab in
                                    Text(tab)
                                        .foregroundColor(tab == "Stocks" ? .blue : .gray)
                                        .fontWeight(tab == "Stocks" ? .bold : .regular)
                                }
                            }

                            HStack(spacing: 20) {
                                ForEach(["Stocks", "ETFs", "Options", "Crypto"], id: \.self) { item in
                                    VStack {
                                        ZStack {
                                            Circle()
                                                .fill(item == "Stocks" ? Color.blue : Color.gray.opacity(0.4))
                                                .frame(width: 70, height: 70)
                                            Text("0%")
                                                .foregroundColor(.white)
                                                .font(.subheadline)
                                        }
                                        Text(item)
                                            .foregroundColor(.gray)
                                            .font(.caption)
                                    }
                                }
                            }

                            VStack(alignment: .leading, spacing: 5) {
                                Text("Stocks are pieces of a company that investors can own.")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                Button(action: {}) {
                                    Text("Learn More")
                                        .foregroundColor(.blue)
                                        .font(.footnote)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(["Business", "Consumer Goods", "Energy & Water", "Finance", "Tech"], id: \.self) { category in
                                        Text(category)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 8)
                                            .background(Color.gray.opacity(0.2))
                                            .foregroundColor(.white)
                                            .cornerRadius(20)
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                        .padding()

                        // MARK: - Investment Summary
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Individual investing")
                                .foregroundColor(.white)
                                .font(.headline)

                            HStack {
                                Text("Total individual value")
                                Spacer()
                                Text("$97.81")
                            }
                            HStack {
                                Text("Individual holdings")
                                Spacer()
                                Text("$0.00")
                            }
                            HStack {
                                Text("Individual cash")
                                Spacer()
                                Text("$97.81")
                            }
                            HStack {
                                Text("Crypto holdings")
                                Spacer()
                                Text("$0.00")
                            }
                        }
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding()
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(10)

                        // MARK: - Discover More Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Discover more")
                                .foregroundColor(.white)
                                .font(.title3)
                                .bold()

                            DiscoverCardView(icon: "star.circle.fill", title: "4.5% APY with Gold", description: "Boost your rate on uninvested cash", trailing: "4.5%")

                            DiscoverCardView(icon: "arrowshape.turn.up.right.fill", title: "Retirement", description: "Earn up to 2% on IRA transfers till April 30", trailingIcon: "atom")

                            DiscoverCardView(icon: "arrow.left.arrow.right.circle.fill", title: "Transfer accounts in", description: "Consolidate assets", trailingIcon: "brain.head.profile")

                            Text("""
                            All investing involves risk, including the loss of principal. Brokerage Holdings include securities and related products offered by registered broker-dealer Robinhood Financial LLC, member 
                            """)
                            .foregroundColor(.gray)
                            .font(.footnote)

                            + Text(" SIPC. ")
                                .foregroundColor(.blue)
                                .font(.footnote)
                                .bold()

                            + Text("""
                            Crypto Holdings are offered by Robinhood Crypto, LLC, are not securities, and are not covered by SIPC. Robinhood Crypto holdings are not offered by Robinhood’s broker-dealer and are therefore not subject to the same regulatory protections as those offered by Robinhood Financial...
                            """)
                            .foregroundColor(.gray)
                            .font(.footnote)

                            Button(action: {}) {
                                Text("See more")
                                    .foregroundColor(.blue)
                                    .font(.footnote)
                            }
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 100)
                }

                // MARK: - Bottom Bar
                HStack {
                    Text("2 invites")
                        .foregroundColor(.white)
                        .padding(.leading)

                    Spacer()

                    Button(action: {}) {
                        HStack {
                            Text("Earn rewards")
                            Image(systemName: "arrow.right")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                    }
                    .padding(.trailing)
                }
                .padding()
                .background(Color.black)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Discover Card Component
struct DiscoverCardView: View {
    var icon: String
    var title: String
    var description: String
    var trailing: String? = nil
    var trailingIcon: String? = nil

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .bold()
                Text(description)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            Spacer()
            if let trailing = trailing {
                Text(trailing)
                    .foregroundColor(.orange)
                    .font(.title3)
                    .bold()
            } else if let icon = trailingIcon {
                Image(systemName: icon)
                    .foregroundColor(.green)
                    .font(.title2)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}



struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let destination: AnyView
}


struct SettingsView: View {
    
    let menuItems = [
        MenuItem(title: "Investing", subtitle: "Balances, recurring investments, DRIP, Stock Lending", destination: AnyView(InvestingView())),
        MenuItem(title: "Crypto", subtitle: "Transfer limits", destination: AnyView(CryptoView())),
        MenuItem(title: "Transfers", subtitle: "Deposits, withdrawals, account transfers", destination: AnyView(TransfersView())),
        MenuItem(title: "Rewards", subtitle: "Invite friends, earn stocks, get rewards", destination: AnyView(RewardsView())),
        MenuItem(title: "History", subtitle: "Activity across all accounts", destination: AnyView(HistoryView())),
        MenuItem(title: "Reports and statements", subtitle: "Account activity reports, monthly statements", destination: AnyView(ReportsView())),
        MenuItem(title: "Tax center", subtitle: "Tax documents, FAQs", destination: AnyView(TaxCenterView()))
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Top header with title and profile icon
                HStack {
                    Text("Menu")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.yellow)
                        .padding(.trailing)
                }
                .padding()
                
                // Menu list
                List {
                    ForEach(menuItems) { item in
                        NavigationLink(destination: item.destination) {
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Text(item.subtitle)
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                            .padding(.vertical, 8)
                        }
                        .listRowBackground(Color.black)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.black)
                
                HStack {
                    Spacer()
                    Image(systemName: "chart.bar")
                    Spacer()
                    Image(systemName: "gearshape")
                    Spacer()
                    Image(systemName: "link")
                    Spacer()
                    Image(systemName: "bell")
                    Spacer()
                    Image(systemName: "person.fill")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.black)
            }
            .background(Color.black)
            .navigationBarHidden(true)
        }
    }
}


struct InvestingView: View {
    var body: some View {
        VStack {
            Text("Investing Page")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct CryptoView: View {
    var body: some View {
        VStack {
            Text("Crypto Page")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .navigationBarBackButtonHidden(true)
    }
}

struct TransfersView: View {
    var body: some View {
        VStack {
            Text("Transfers Page")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .navigationBarBackButtonHidden(true)
    }
}

struct RewardsView: View {
    var body: some View {
        VStack {
            Text("Rewards Page")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .navigationBarBackButtonHidden(true)
    }
}

struct HistoryView: View {
    var body: some View {
        VStack {
            Text("History Page")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .navigationBarBackButtonHidden(true)
    }
}

struct ReportsView: View {
    var body: some View {
        VStack {
            Text("Reports Page")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .navigationBarBackButtonHidden(true)
    }
}

struct TaxCenterView: View {
    var body: some View {
        VStack {
            Text("Tax Center Page")
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .navigationBarBackButtonHidden(true)
    }
}
