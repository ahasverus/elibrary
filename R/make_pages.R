make_pages <- function(n = 20) {
  
  data <- get_calibre_data()
  n_pages <- ceiling(nrow(data) / n)
  
  list_of_data <- list()
  
  for (i in 1:(n_pages - 1)) {
    list_of_data[[i]] <- data[1:n, ]
    data <- data[-c(1:n), ]
  }
  
  list_of_data[[n_pages]] <- data
  
  for (j in 1:n_pages) {
    
    html <- "<!DOCTYPE html>"
    html <- c(html, "<html lang=\"fr\">")
    html <- c(html, "<head>")
    html <- c(html, "  <meta charset=\"UTF-8\">")
    html <- c(html, "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">")
    html <- c(html, paste0("  <title>Bibliothèque - Page ", j, "</title>"))
    html <- c(html, "  <link rel=\"stylesheet\" href=\"../css/styles.css\">")
    html <- c(html, "  <link rel=\"preconnect\" href=\"https://fonts.googleapis.com\">")
    html <- c(html, "  <link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin>")
    html <- c(html, "  <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500&display=swap\">")
    html <- c(html, "</head>")
    html <- c(html, "")
    html <- c(html, "<body>")
    html <- c(html, "")
    html <- c(html, "  <nav class=\"navbar\">")
    html <- c(html, "    <a href=\"../index.html\">")
    html <- c(html, "      <img src=\"../images/logo-brand.png\" class=\"nav-brand-logo\" alt=\"Logo\" />")
    html <- c(html, "      <span>Bibliothèque</span>")
    html <- c(html, "    </a>")
    html <- c(html, "  </nav>")
    html <- c(html, "")
    html <- c(html, "  <main>")
    html <- c(html, "")
    
    
    for (i in 1:nrow(list_of_data[[j]])) {
      
      html <- c(html, "    <article class=\"card\">")
      
      html <- c(html, paste0("      <a href=\"https://www.google.com/search?q=", 
                             utils::URLencode(list_of_data[[j]][i, "book_title"]), "%20", 
                             utils::URLencode(list_of_data[[j]][i, "author_name"]),
                             "\" target=\"_blank\">"))
      
      html <- c(html, paste0("        <img src=\"../images/", 
                             "cover-", list_of_data[[j]][i, "book_id"], ".jpg", 
                             "\" class=\"card-img\" alt=\"Couverture\" />"))
      
      html <- c(html, "      </a>")
      
      html <- c(html, paste0("      <a href=\"https://www.google.com/search?q=", 
                             utils::URLencode(list_of_data[[j]][i, "book_title"]), "%20", 
                             utils::URLencode(list_of_data[[j]][i, "author_name"]),
                             "\" target=\"_blank\">"))
      
      html <- c(html, paste0("      <h3>", 
                             list_of_data[[j]][i, "book_title"], "</h3>"))
      
      html <- c(html, "      </a>")
      
      if (!is.na(list_of_data[[j]][i, "series_name"])) {
        html <- c(html, paste0("      <h4>", 
                               "<a href=\"https://www.google.com/search?q=", 
                               utils::URLencode(list_of_data[[j]][i, "series_name"]), "%20", 
                               utils::URLencode(list_of_data[[j]][i, "author_name"]), 
                               "\" target=\"_blank\">",
                               list_of_data[[j]][i, "series_name"], 
                               "</a>",
                               " (", 
                               list_of_data[[j]][i, "series_index"], 
                               ")</h4>"))  
      }
      
      html <- c(html, paste0("      <h5>", 
                             "<a href=\"https://www.google.com/search?q=", 
                             utils::URLencode(list_of_data[[j]][i, "author_name"]), 
                             "%20auteur\" target=\"_blank\">",
                             list_of_data[[j]][i, "author_name"],
                             "</a>", 
                             " &bull; ", 
                             list_of_data[[j]][i, "year"], 
                             "</h5>"))
      
      html <- c(html, paste0("      <p>#", 
                             tolower(list_of_data[[j]][i, "tag_name"]), 
                             "</p>"))
      html <- c(html, "    </article>")
      html <- c(html, "")
      
      if (!file.exists(file.path("images", 
                                 paste0("cover-", list_of_data[[j]][i, "book_id"], 
                                        ".jpg")))) {
        invisible(
          file.copy(file.path(calibre_path(), list_of_data[[j]][i, "filename"], 
                              "cover.jpg"),
                    file.path("images", 
                              paste0("cover-", list_of_data[[j]][i, "book_id"], 
                                     ".jpg"))))  
      }
    }
    
    html <- c(html, "  </main>")
    
    html <- c(html, "")
    
    html <- c(html, "  <nav class=\"navpage\">")
    html <- c(html, "    <ul class=\"pagination\">")
    
    if (j == 1) {
      
      html <- c(html, "      <li><span class=\"not-allowed\">&laquo;</span></li>")
      html <- c(html, "      <li><span class=\"not-allowed\">&#8249;</span></li>")
      html <- c(html, "      <li><span class=\"current-page\">1</span></li>")
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j + 1, 
                             ".html\" class=\"page\">", 
                             j + 1, 
                             "</a></li>"))
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j + 2, 
                             ".html\" class=\"page\">", 
                             j + 2, 
                             "</a></li>"))
      html <- c(html, "      <li><span class=\"not-allowed\">...</span></li>")
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j + 1, 
                             ".html\" class=\"page\">&#8250;</a></li>"))
      html <- c(html, paste0("      <li><a href=\"page-", 
                             n_pages, 
                             ".html\" class=\"page\">&raquo;</a></li>"))
      
    }
    
    if (j == 2) {
      
      html <- c(html, "      <li><a href=\"page-1.html\">&laquo;</a></li>")
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j - 1, 
                             ".html\">&#8249;</a></li>"))
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j - 1, 
                             ".html\" class=\"page\">", 
                             j - 1, 
                             "</a></li>"))
      html <- c(html, "      <li><span class=\"current-page\">2</span></li>")
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j + 1, 
                             ".html\" class=\"page\">", 
                             j + 1, 
                             "</a></li>"))
      html <- c(html, "      <li><span class=\"not-allowed\">...</span></li>")
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j + 1, 
                             ".html\" class=\"page\">&#8250;</a></li>"))
      html <- c(html, paste0("      <li><a href=\"page-", 
                             n_pages, 
                             ".html\" class=\"page\">&raquo;</a></li>"))
    }
    
    
    if (j > 2 && j < (n_pages - 1)) {
      
      html <- c(html, "      <li><a href=\"page-1.html\">&laquo;</a></li>")
      html <- c(html, paste0("      <li><a href=\"pages/page-", 
                             j - 1, 
                             ".html\">&#8249;</a></li>"))
      html <- c(html, "      <li><span class=\"not-allowed\">...</span></li>")
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j - 1, 
                             ".html\" class=\"page\">", 
                             j - 1, 
                             "</a></li>"))
      html <- c(html, paste0("      <li><span class=\"current-page\">", 
                             j, 
                             "</span></li>"))
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j + 1, 
                             ".html\" class=\"page\">", 
                             j + 1, 
                             "</a></li>"))
      html <- c(html, "      <li><span class=\"not-allowed\">...</span></li>")
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j + 1, 
                             ".html\" class=\"page\">&#8250;</a></li>"))
      html <- c(html, paste0("      <li><a href=\"page-", 
                             n_pages, 
                             ".html\" class=\"page\">&raquo;</a></li>"))
      
    }
    
    if (j == (n_pages - 1)) {
      
      html <- c(html, "      <li><a href=\"page-1.html\">&laquo;</a></li>")
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j - 1, 
                             ".html\">&#8249;</a></li>"))
      html <- c(html, "      <li><span class=\"not-allowed\">...</span></li>")
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j - 1, 
                             ".html\" class=\"page\">", 
                             j - 1, 
                             "</a></li>"))
      html <- c(html, paste0("      <li><span class=\"current-page\">", 
                             j,
                             "</span></li>"))
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j + 1, 
                             ".html\" class=\"page\">", 
                             j + 1, 
                             "</a></li>"))
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j + 1, 
                             ".html\" class=\"page\">&#8250;</a></li>"))
      html <- c(html, paste0("      <li><a href=\"page-", 
                             n_pages, 
                             ".html\" class=\"page\">&raquo;</a></li>"))
    }
    
    if (j == (n_pages)) {
      
      html <- c(html, "      <li><a href=\"page-1.html\">&laquo;</a></li>")
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j - 1, 
                             ".html\">&#8249;</a></li>"))
      html <- c(html, "      <li><span class=\"not-allowed\">...</span></li>")
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j - 2, 
                             ".html\" class=\"page\">", 
                             j - 2, 
                             "</a></li>"))
      html <- c(html, paste0("      <li><a href=\"page-", 
                             j - 1, 
                             ".html\" class=\"page\">", 
                             j - 1, 
                             "</a></li>"))
      html <- c(html, paste0("      <li><span class=\"current-page\">", 
                             j,
                             "</span></li>"))
      html <- c(html, "      <li><span class=\"not-allowed\">&#8250;</span></li>")
      html <- c(html, "      <li><span class=\"not-allowed\">&raquo;</span></li>")
    }
    
    
    html <- c(html, "    </ul>")
    html <- c(html, "  </nav>")
    
    html <- c(html, "")
    
    html <- c(html, "</body>")
    html <- c(html, "</html>")
    
    html <- paste0(html, collapse = "\n")
    
    cat(html, file = file.path("pages", paste0("page-", j, ".html")), append = FALSE)
  }
}
