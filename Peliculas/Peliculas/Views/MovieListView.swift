import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieViewModel() // Crea una instancia del ViewModel como un @StateObject para que la vista se actualice cuando cambien los datos.

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ] //Define un diseño de cuadrícula con 2 columnas flexibles y un espacio de 16 entre ellas.

    var body: some View {
        NavigationView { //Contenedor principal que habilita la navegación entre pantallas.
            VStack { //  Organiza los elementos verticalmente.
                
                // Barra de Búsqueda (Search Bar)
                TextField(" Buscar película...", text: $viewModel.searchText)
                    .padding(12) // Añade espacio interno alrededor del campo de texto.
                    .background(Color(.systemGray6)) //  Fondo gris claro.
                    .cornerRadius(12) //  Bordes redondeados.
                    .padding(.horizontal) //  Espaciado horizontal.
                    .shadow(radius: 2) //  Agrega una ligera sombra.

                // Grid de Películas
                ScrollView { //  Permite desplazarse verticalmente.
                    LazyVGrid(columns: columns, spacing: 16) { //  Crea una cuadrícula perezosa (LazyVGrid) con las columnas definidas.
                        ForEach(viewModel.movies) { movie in //  Itera sobre la lista de películas en el ViewModel.
                            NavigationLink(destination: MovieDetailView(movie: movie)) { // Permite navegar a los detalles de la película seleccionada.
                                MovieCardView(movie: movie) // Muestra una tarjeta con la información de la película.
                            }
                            .buttonStyle(PlainButtonStyle()) // Evita el resaltado predeterminado al hacer clic.
                        }
                    }
                    .padding() //  Agrega espacio alrededor de la cuadrícula.
                }
            }
            .navigationTitle("🎬 Movies 🎬") //  Establece el título de la pantalla con emojis.
        }
    }
}
struct MovieCardView: View {
    let movie: Movie //  Recibe una instancia de `Movie` como parámetro.

    var body: some View {
        ZStack(alignment: .topTrailing) { //  Contenedor que superpone elementos y los alinea en la esquina superior derecha.

            VStack { //  Organiza la imagen y los textos en vertical.
                
                // ✅ Imagen de la Película (Usando carga asincrónica)
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill) //  Ajusta la imagen para que llene el espacio disponible sin deformarse.
                } placeholder: {
                    ProgressView() //  Muestra un indicador de carga mientras se descarga la imagen.
                }
                .frame(height: 200) //  Establece una altura fija para la imagen.
                .cornerRadius(12) // Bordes redondeados.
                .shadow(radius: 5) //  Agrega una sombra.

                // Título de la Película
                Text(movie.title)
                    .font(.headline) //  Fuente en negrita.
                    .foregroundColor(.primary) //  Usa el color predeterminado del sistema (se adapta a modo claro/oscuro).
                    .multilineTextAlignment(.center) //  Centra el texto.
                    .padding(.horizontal, 4) //  Espaciado horizontal.
                    .lineLimit(2) //  Limita el texto a dos líneas.

                //  Géneros de la Película (Usando función `getGenres`)
                Text(getGenres(for: movie.genreIds))
                    .font(.caption) //  Fuente pequeña.
                    .foregroundColor(.gray) //  Color gris.
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(.systemGray5)) //  Fondo gris claro.
                    .cornerRadius(10) // Bordes redondeados.
                    .padding(.bottom, 8) //  Espaciado inferior.

            }
            .background(Color(.systemBackground)) //  Fondo que se adapta a modo claro/oscuro.
            .cornerRadius(12) // Bordes redondeados.
            .shadow(radius: 3) //  Sombra ligera.

            // ✅ Calificación en un círculo rojo en la esquina superior derecha
            if movie.voteAverage > 0 { // Solo muestra la calificación si es mayor que 0.
                Text(String(format: "%.1f", movie.voteAverage)) //  Formatea la calificación a un decimal.
                    .font(.caption) //  Fuente pequeña y en negrita.
                    .bold()
                    .foregroundColor(.white) // Texto blanco para contraste.
                    .padding(6) // Espaciado dentro del círculo.
                    .background(Color.red) //  Fondo rojo para destacar.
                    .clipShape(Circle()) //  Da forma de círculo.
                    .offset(x: -8, y: 8) // 🔵 Posiciona en la esquina superior derecha.
            }
        }
    }

    // ✅ Función para Obtener los Géneros a partir de sus IDs
    func getGenres(for genreIds: [Int]) -> String {
        let genres: [Int: String] = [ // 🔵 Diccionario con los IDs y nombres de géneros.
            28: "Acción", 12: "Aventura", 16: "Animación", 35: "Comedia",
            80: "Crimen", 99: "Documental", 18: "Drama", 10751: "Familiar",
            14: "Fantasía", 36: "Historia", 27: "Terror", 10402: "Música",
            9648: "Misterio", 10749: "Romance", 878: "Ciencia Ficción",
            10770: "TV Movie", 53: "Suspenso", 10752: "Bélica", 37: "Western"
        ]

        let genreNames = genreIds.compactMap { genres[$0] } // 🟢 Convierte los IDs en nombres de género.
        return genreNames.joined(separator: " • ") // 🔵 Une los nombres con un separador tipo "Drama • Suspenso".
    }
}
