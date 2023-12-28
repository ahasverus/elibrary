make_index <- function() {
  
  data <- get_calibre_data()
  
  html <- "<!DOCTYPE html>"
  html <- c(html, "<html lang=\"fr\">")
  html <- c(html, "<head>")
  html <- c(html, "  <meta charset=\"UTF-8\">")
  html <- c(html, "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">")
  html <- c(html, "  <title>Bibliothèque</title>")
  html <- c(html, "  <link rel=\"stylesheet\" href=\"css/styles.css\">")
  html <- c(html, "  <link rel=\"preconnect\" href=\"https://fonts.googleapis.com\">")
  html <- c(html, "  <link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin>")
  html <- c(html, "  <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500&display=swap\">")
  html <- c(html, "</head>")
  html <- c(html, "")
  html <- c(html, "<body>")
  html <- c(html, "")
  html <- c(html, "  <nav>")
  html <- c(html, "    <a href=\"#\">")
  html <- c(html, "      <img src=\"images/logo-brand.png\" class=\"nav-brand-logo\" alt=\"Logo\" />")
  html <- c(html, "      <span>Bibliothèque</span>")
  html <- c(html, "    </a>")
  html <- c(html, "  </nav>")
  html <- c(html, "")
  html <- c(html, "  <main>")
  html <- c(html, "")
  
  
  for (i in 1:nrow(data)) {
    
    html <- c(html, "    <article class=\"card\">")
    
    html <- c(html, paste0("      <a href=\"https://www.google.com/search?q=", 
                           utils::URLencode(data[i, "book_title"]), "%20", 
                           utils::URLencode(data[i, "author_name"]),
                           "\" target=\"_blank\">"))
    
    html <- c(html, paste0("        <img src=\"images/", 
                           "cover-", data[i, "book_id"], ".jpg", 
                           "\" class=\"card-img\" alt=\"Couverture\" />"))
    
    html <- c(html, "      </a>")
    
    html <- c(html, paste0("      <a href=\"https://www.google.com/search?q=", 
                           utils::URLencode(data[i, "book_title"]), "%20", 
                           utils::URLencode(data[i, "author_name"]),
                           "\" target=\"_blank\">"))
    
    html <- c(html, paste0("      <h3>", 
                           data[i, "book_title"], "</h3>"))
    
    html <- c(html, "      </a>")
    
    if (!is.na(data[i, "series_name"])) {
      html <- c(html, paste0("      <h4>", 
                             "<a href=\"https://www.google.com/search?q=", 
                             utils::URLencode(data[i, "series_name"]), "%20", 
                             utils::URLencode(data[i, "author_name"]), 
                             "\" target=\"_blank\">",
                             data[i, "series_name"], 
                             "</a>",
                             " (", 
                             data[i, "series_index"], 
                             ")</h4>"))  
    }
    
    html <- c(html, paste0("      <h5>", 
                           "<a href=\"https://www.google.com/search?q=", 
                           utils::URLencode(data[i, "author_name"]), 
                           "%20auteur\" target=\"_blank\">",
                           data[i, "author_name"],
                           "</a>", 
                           " &bull; ", 
                           data[i, "year"], 
                           "</h5>"))
    
    html <- c(html, paste0("      <p>#", 
                           tolower(data[i, "tag_name"]), 
                           "</p>"))
    html <- c(html, "    </article>")
    html <- c(html, "")
    
    if (!file.exists(file.path("images", paste0("cover-", data[i, "book_id"], 
                                                ".jpg")))) {
      invisible(
        file.copy(file.path(calibre_path(), data[i, "filename"], "cover.jpg"),
                  file.path("images", paste0("cover-", data[i, "book_id"], 
                                             ".jpg"))))  
    }
  }
  
  html <- c(html, "  </main>")
  html <- c(html, "</body>")
  html <- c(html, "</html>")

  html <- paste0(html, collapse = "\n")
  
  cat(html, file = file.path("index.html"), append = FALSE)
}