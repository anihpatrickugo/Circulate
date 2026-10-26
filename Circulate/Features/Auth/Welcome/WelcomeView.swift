//
//  WelcomeView.swift
//  Circulate
//
//  Created by Anihpatrickugo on 20/10/2026.
//

import SwiftUI

// 1. Data model for carousel items
struct CarouselItem: Identifiable {
    let id = UUID()
    let imageURL: String
    let badgeText: String
    let price: String
    let title: String
    let subtitle: String
}

struct WelcomeView: View {
    @Environment(Router.self) private var router

    private let brandBlue = Color(hex: "#1B28D9")
    private let mutedGray = Color(hex: "#8A8A8A")
    
    // Sample items for the carousel
    private let items: [CarouselItem] = [
        CarouselItem(
            imageURL: "https://thereelshot.com/wp-content/uploads/2026/09/top_remote_cameras_2027_51cmc.jpg",
            badgeText: "Verified Owner",
            price: "$45/day",
            title: "Sony Alpha A7 IV kit",
            subtitle: "24-70mm f/2.8 GM Lens Included"
        ),
        CarouselItem(
            imageURL: "https://images.unsplash.com/photo-1502920917128-1aa500764cbd",
            badgeText: "Pro Lender",
            price: "$30/day",
            title: "DJI Mavic 3 Pro",
            subtitle: "Fly More Combo with 3 Batteries"
        ),
        CarouselItem(
            imageURL: "https://images.unsplash.com/photo-1516035069371-29a1b244cc32",
            badgeText: "Super Owner",
            price: "$25/day",
            title: "Canon EOS R6 Mark II",
            subtitle: "4K Video Body Only"
        )
    ]
    
    @State private var currentIndex = 0

    var body: some View {
        ZStack {
            LinearGradient(
                stops: [
                    .init(color: Color(hex: "#059669"), location: 0.0),
                    .init(color: .white, location: 0.20),
                    .init(color: Color(hex: "#e4e2f6"), location: 0.40)
                ],
                startPoint: .topLeading,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 12) {
                
                // Top Header
                HStack {
                    HStack {
                        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.circle")
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(Color(hex: "#059669"), in: RoundedRectangle(cornerRadius: 12))
                        
                        Text("Circulate")
                            .font(.system(size: 22, weight: .bold))
                    }
                    Spacer()
                    Button {
                        router.push(.signup)
                    } label: { Text("Skip").foregroundStyle(.gray) }
                }
                .padding(.horizontal, 24)
                
                // Card Carousel (Default dots hidden)
                TabView(selection: $currentIndex) {
                    ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                        ItemCard(item: item)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 290)
                
                // Availability Badge & Custom Carousel Dots
               
                    HStack(spacing: 4) {
                        Circle()
                            .fill(Color(hex: "#059669"))
                            .frame(width: 10, height: 10)
                        
                        Text("Available Today")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 4)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity, maxHeight: 78, alignment: .trailing)
                 
                
                
                // Custom Page Indicator Dots
                HStack(spacing: 6) {
                    ForEach(0..<items.count, id: \.self) { index in
                        Capsule()
                            .fill(currentIndex == index ? Color(hex: "#059669") : Color.gray.opacity(0.3))
                            .frame(width: currentIndex == index ? 28 : 8, height: 8)
                            .animation(.easeInOut, value: currentIndex)
                    }
                }
                

                // Bottom Content & Actions
                VStack(spacing: 12) {
                    Text("Borrow what you need. Lend what you don't.")
                        .font(.title)
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text("Access high-end cameras, outdoor gear, tools, and electronics right in your neighborhood with comprehensive insurance protection.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 320)
                    
                    HStack {
                        HStack {
                            Image(systemName: "shield").foregroundStyle(Color(hex: "#059669"))
                            Text("$5M+ Insured").font(.caption)
                        }
                        
                        Circle().frame(width: 8, height: 8).foregroundColor(.gray)
                        
                        HStack {
                            Image(systemName: "star.fill").foregroundStyle(.brown)
                            Text("4.9★ Trust").font(.caption)
                        }
                        
                        Circle().frame(width: 8, height: 8).foregroundColor(.gray)
                        
                        HStack {
                            Image(systemName: "person.text.rectangle").foregroundStyle(.indigo)
                            Text("ID Verified").font(.caption)
                        }
                    }
                    .frame(height: 26)
                    .padding(.horizontal, 8)
                    .background(
                        Color(hex: "#d8e1f4"),
                        in: RoundedRectangle(cornerRadius: 10)
                    )
                    
                    Button(action: {
                        router.push(.signup)
                    }) {
                        HStack {
                            Text("Continue")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(.white)
                            
                            Image(systemName: "arrow.right").foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            Color(hex: "#059669"),
                            in: RoundedRectangle(cornerRadius: 40)
                        )
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: {
                        router.push(.login)
                    }) {
                        Text("I already have an account")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .frame(height: 44)
                }
                .padding(.horizontal, 24)
                
                Spacer()
            }
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

// Subview for individual cards inside carousel
struct ItemCard: View {
    let item: CarouselItem

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Remote Image Stack
            ZStack {
                AsyncImage(url: URL(string: item.imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 180)
                            .frame(maxWidth: .infinity)
                            .background(Color(.secondarySystemBackground))
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 180)
                            .clipped()
                    case .failure(_):
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)
                            .frame(height: 180)
                            .frame(maxWidth: .infinity)
                            .background(Color(.secondarySystemBackground))
                    @unknown default:
                        EmptyView()
                    }
                }
                .cornerRadius(12)
                
                // Top-Left Badge
                HStack(spacing: 6) {
                    Image(systemName: "checkmark.shield.fill")
                        .foregroundColor(.indigo)
                    Text(item.badgeText)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.indigo)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .padding(12)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

                // Bottom-Right Badge
                HStack(spacing: 4) {
                    Text(item.price)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .padding(12)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
            
            Text(item.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(item.subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal, 24)
    }
}

#Preview {
    NavigationStack {
        WelcomeView()
    }
    .environment(Router())
}
#Preview("Full auth flow") {
    AuthFlow()
        .environment(SessionStore())
}
