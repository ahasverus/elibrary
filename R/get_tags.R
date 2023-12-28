get_tags <- function() {
  
  calibre_db <- connect_to_calibre_db()
  
  data <- DBI::dbGetQuery(
    conn       = calibre_db,
    statement  = "SELECT id, name FROM tags;"
  )
  
  colnames(data) <- c("tag_id", "tag_name")
  
  disconnect_from_calibre_db(calibre_db)
  
  data
}
