get_books_tags_link <- function() {
  
  calibre_db <- connect_to_calibre_db()
  
  data <- DBI::dbGetQuery(
    conn       = calibre_db,
    statement  = "SELECT book, tag FROM books_tags_link;"
  )
  
  colnames(data) <- c("book_id", "tag_id")
  
  disconnect_from_calibre_db(calibre_db)
  
  data
}
