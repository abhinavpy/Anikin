import SwiftUI

struct IdentitySelectionView: View {
    @State private var searchText = ""
    @State private var selectedSpecies: Theriotype?
    @State private var navigateToAccountCreation = false
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var filteredSpecies: [Theriotype] {
        if searchText.isEmpty {
            return TheriotypeData.species
        } else {
            return TheriotypeData.species.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            Color.anikinBase.ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Identify Your Kin")
                        .font(.system(size: 32, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                    
                    Text("Select your primary theriotype to begin your journey.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 20)

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.anikinAccent)
                    TextField("Search species...", text: $searchText)
                        .foregroundColor(.white)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .padding(.horizontal)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredSpecies, id: \.self) { species in
                            SpeciesCard(
                                species: species,
                                isSelected: selectedSpecies == species
                            )
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedSpecies = species
                                }
                            }
                        }
                    }
                    .padding()
                }

                Button(action: {
                    if selectedSpecies != nil {
                        navigateToAccountCreation = true
                    }
                }) {
                    Text("Confirm Identity")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(
                            Capsule()
                                .fill(selectedSpecies != nil ? Color.anikinAccent : Color.gray)
                        )
                        .padding(.horizontal, 40)
                        .padding(.bottom, 20)
                }
                .disabled(selectedSpecies == nil)
            }
        }
        .navigationDestination(isPresented: $navigateToAccountCreation) {
            if let species = selectedSpecies {
                AccountCreatingView(selectedSpecies: species)
            }
        }
    }
}

struct SpeciesCard: View {
    let species: Theriotype
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            Group {
                if let _ = UIImage(named: species.icon) {
                    Image(species.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                } else {
                    Image(systemName: species.icon)
                        .font(.system(size: 30))
                }
            }
            .foregroundStyle(isSelected ? Color.anikinBase : Color.anikinAccent)
            
            Text(species.name)
                .font(.headline)
                .foregroundStyle(isSelected ? Color.anikinBase : .white)
            
            Text(species.category)
                .font(.caption)
                .foregroundStyle(isSelected ? Color.anikinBase.opacity(0.7) : .white.opacity(0.5))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(isSelected ? AnyShapeStyle(Color.anikinAccent) : AnyShapeStyle(.ultraThinMaterial))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(isSelected ? Color.anikinAccent : .white.opacity(0.15), lineWidth: 1.5)
        )
        .shadow(color: .black.opacity(isSelected ? 0.2 : 0.1), radius: 10, y: 5)
        .scaleEffect(isSelected ? 1.04 : 1.0)
    }
}

#Preview {
    NavigationStack {
        IdentitySelectionView()
    }
}
