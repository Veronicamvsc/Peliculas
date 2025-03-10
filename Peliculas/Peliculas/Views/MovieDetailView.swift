import SwiftUI

struct MovieDetailView: View {
    let movie: Movie // 🟢 Recibe una película como parámetro para mostrar sus detalles.

    var body: some View {
        ScrollView { // 🔵 Permite desplazarse si el contenido es extenso.
            VStack(alignment: .leading, spacing: 16) { // 🟢 Organiza los elementos en una columna alineada a la izquierda con espaciado.

                // ✅ Imagen de la Película (Carga asincrónica)
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill) // 🔵 Ajusta la imagen manteniendo su relación de aspecto.
                } placeholder: {
                    ProgressView() // 🟢 Muestra un indicador de carga mientras se descarga la imagen.
                }
                .frame(height: 300) // 🔵 Define una altura fija.
                .clipped() // 🟢 Recorta la imagen si es necesario para ajustarse al frame.

                // ✅ Información de la Película
                VStack(alignment: .leading, spacing: 8) { // 🔵 Contenedor con información textual.
                    HStack { // 🟢 Organiza el título y la estrella en una misma fila.
                        Text(movie.title)
                            .font(.title) // 🔵 Establece un tamaño de fuente grande.
                            .bold() // 🟢 Texto en negrita.

                        Image(systemName: "star.fill") // 🔵 Ícono de estrella (⭐).
                            .foregroundColor(.yellow) // 🟢 Color amarillo para la estrella.
                    }

                    Text(movie.releaseDate) // 🔵 Muestra la fecha de lanzamiento.
                        .font(.subheadline) // 🟢 Fuente más pequeña.
                        .foregroundColor(.red) // 🔵 Color rojo para resaltar.

                    // ✅ Sección de Sinopsis
                    Text("Sinopsis")
                        .font(.headline) // 🔵 Fuente destacada.
                        .foregroundColor(.gray) // 🟢 Color gris.

                    Text(movie.overview) // 🔵 Muestra la sinopsis de la película.
                        .font(.body) // 🟢 Fuente estándar.
                        .foregroundColor(.primary) // 🔵 Se adapta al tema oscuro/claro.
                }
                .padding(.horizontal) // 🟢 Espaciado lateral para mejor presentación.

                // ✅ Sección de Géneros (si existen)
                if !movie.genreIds.isEmpty { // 🔵 Verifica que la película tenga géneros asignados.
                    Text("Categorías")
                        .font(.headline) // 🟢 Fuente destacada.
                        .foregroundColor(.gray) // 🔵 Color gris.
                        .padding(.horizontal) // 🟢 Espaciado lateral.

                    // ✅ Scroll Horizontal para mostrar los géneros
                    ScrollView(.horizontal, showsIndicators: false) { // 🔵 Deslizable de izquierda a derecha sin barra de desplazamiento.
                        HStack { // 🟢 Organiza los géneros en una fila.
                            ForEach(movie.genreIds, id: \.self) { genreId in // 🔵 Itera sobre los IDs de los géneros.
                                Text(getGenreName(for: genreId)) // 🟢 Obtiene el nombre del género.
                                    .font(.caption) // 🔵 Fuente pequeña.
                                    .padding(8) // 🟢 Espaciado interno.
                                    .background(Color(.systemGray6)) // 🔵 Fondo gris claro.
                                    .cornerRadius(10) // 🟢 Bordes redondeados.
                            }
                        }
                        .padding(.horizontal) // 🔵 Espaciado lateral dentro del scroll.
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline) // 🟢 Hace que el título de la barra de navegación sea pequeño.
    }

    // ✅ Función para obtener el nombre del género a partir de su ID
    func getGenreName(for id: Int) -> String {
        let genres: [Int: String] = [ // 🔵 Diccionario que asocia IDs con nombres de género.
            28: "Acción", 12: "Aventura", 16: "Animación", 35: "Comedia",
            80: "Crimen", 99: "Documental", 18: "Drama", 10751: "Familiar",
            14: "Fantasía", 36: "Historia", 27: "Terror", 10402: "Música",
            9648: "Misterio", 10749: "Romance", 878: "Ciencia Ficción",
            10770: "TV Movie", 53: "Suspenso", 10752: "Bélica", 37: "Western"
        ]
        return genres[id] ?? "Desconocido" // 🟢 Devuelve el nombre del género o "Desconocido" si el ID no está en la lista.
    }
}
