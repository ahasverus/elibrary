get_publishers <- function() {
  
  calibre_db <- connect_to_calibre_db()
  
  data <- DBI::dbGetQuery(
    conn       = calibre_db,
    statement  = "SELECT id, name FROM publishers;"
  )
  
  colnames(data) <- c("publisher_id", "publisher_name")
  
  disconnect_from_calibre_db(calibre_db)
  
  data
}
