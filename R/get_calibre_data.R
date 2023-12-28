get_calibre_data <- function() {
  
  authors    <- get_authors()
  books      <- get_books()
  series     <- get_series()
  tags       <- get_tags()
  publishers <- get_publishers()
  
  books_series_link     <- get_books_series_link()
  books_tags_link       <- get_books_tags_link()
  books_publishers_link <- get_books_publishers_link()
  
  series     <- merge(series, books_series_link, 
                      by = "series_id", all = TRUE)
  tags       <- merge(tags, books_tags_link, 
                      by = "tag_id", all = TRUE)
  publishers <- merge(publishers, books_publishers_link, 
                      by = "publisher_id", all = TRUE)
  
  data <- merge(books, series, by = "book_id", all = TRUE)
  data <- merge(data, tags, by = "book_id", all = TRUE)
  data <- merge(data, publishers, by = "book_id", all = TRUE)
  
  data <- merge(data, authors, by = "author_sort", all = FALSE)
  
  data$"year" <- substr(data$"date", 1, 4)
  
  
  data[ , "series_index"] <- as.numeric(as.character(data[ , "series_index"]))
  
  data <- data[order(data[ , "author_sort"], 
                     data[ , "series_name"], 
                     data[ , "series_index"],
                     data[ , "year"]), ]
  
  
  data[ , "series_name"] <- gsub("\\[", "(", data[ , "series_name"])
  data[ , "series_name"] <- gsub("\\]", ")", data[ , "series_name"])
  
  data[ , "tag_name"] <- ifelse(data[ , "tag_name"] == "Nouvelle", 
                                "Nouvelles", 
                                data[ , "tag_name"])
  
  data[ , "tag_name"] <- ifelse(data[ , "tag_name"] == "Science fiction", 
                                "Science-fiction", 
                                data[ , "tag_name"])
  
  data[ , "tag_name"] <- gsub(" ", "-", data[ , "tag_name"])
  
  data
}