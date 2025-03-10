import Foundation // 📌 Importamos Foundation para manejar JSON y URLs.

struct MovieResponse: Codable { // 📌 Modelo que representa la respuesta de la API.
    let results: [Movie] // ✅ Contiene una lista de películas obtenidas de la API.
}

struct Movie: Codable, Identifiable { // 📌 Modelo de una película individual, conforme a `Codable` para decodificación JSON y `Identifiable` para listas en SwiftUI.
    let id: Int // ✅ Identificador único de la película.
    let title: String // ✅ Título de la película.
    let overview: String // ✅ Sinopsis de la película.
    let posterPath: String? // ✅ Ruta de la imagen del póster (puede ser `nil` si no hay imagen).
    let releaseDate: String // ✅ Fecha de estreno de la película en formato `YYYY-MM-DD`.
    let voteAverage: Double // ✅ Puntuación promedio de la película.
    let genreIds: [Int] // ✅ Lista de identificadores de géneros asociados a la película.

    enum CodingKeys: String, CodingKey { // 📌 Mapea los nombres de los atributos JSON con los nombres de Swift.
        case id, title, overview // ✅ Los nombres coinciden directamente con la API.
        case posterPath = "poster_path" // ✅ Renombramos `poster_path` (API) a `posterPath` (Swift).
        case releaseDate = "release_date" // ✅ Renombramos `release_date` (API) a `releaseDate` (Swift).
        case voteAverage = "vote_average" // ✅ Renombramos `vote_average` (API) a `voteAverage` (Swift).
        case genreIds = "genre_ids" // ✅ Renombramos `genre_ids` (API) a `genreIds` (Swift).
    }
    
    var posterURL: URL? { // 📌 Propiedad calculada para generar la URL completa del póster.
        if let posterPath = posterPath { // ✅ Verifica si `posterPath` tiene un valor.
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") // ✅ Construye la URL del póster con el tamaño `w500`.
        }
        return nil // ✅ Retorna `nil` si no hay `posterPath` disponible.
    }
}
