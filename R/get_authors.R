get_authors <- function() {
  
  calibre_db <- connect_to_calibre_db()
  
  data <- DBI::dbGetQuery(
    conn       = calibre_db,
    statement  = "SELECT id, name, sort FROM authors;"
  )
  
  colnames(data) <- c("author_id", "author_name", "author_sort")
  
  disconnect_from_calibre_db(calibre_db)
  
  data
}
