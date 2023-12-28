get_books_publishers_link <- function() {
  
  calibre_db <- connect_to_calibre_db()
  
  data <- DBI::dbGetQuery(
    conn       = calibre_db,
    statement  = "SELECT book, publisher FROM books_publishers_link;"
  )
  
  colnames(data) <- c("book_id", "publisher_id")
  
  disconnect_from_calibre_db(calibre_db)
  
  data
}
