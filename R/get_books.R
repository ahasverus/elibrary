get_books <- function() {
  
  calibre_db <- connect_to_calibre_db()
  
  data <- DBI::dbGetQuery(
    conn       = calibre_db,
    statement  = paste0("SELECT id, title, sort, pubdate, series_index, ", 
                        "author_sort, path FROM books;")
  )
  
  colnames(data) <- c("book_id", "book_title", "book_sort", "date", 
                      "series_index", "author_sort", "filename")
  
  disconnect_from_calibre_db(calibre_db)
  
  data
}
