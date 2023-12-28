get_books_series_link <- function() {
  
  calibre_db <- connect_to_calibre_db()
  
  data <- DBI::dbGetQuery(
    conn       = calibre_db,
    statement  = "SELECT book, series FROM books_series_link;"
  )
  
  colnames(data) <- c("book_id", "series_id")
  
  disconnect_from_calibre_db(calibre_db)
  
  data
}
