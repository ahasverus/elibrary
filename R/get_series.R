get_series <- function() {
  
  calibre_db <- connect_to_calibre_db()
  
  data <- DBI::dbGetQuery(
    conn       = calibre_db,
    statement  = "SELECT id, name FROM series;"
  )
  
  colnames(data) <- c("series_id", "series_name")
  
  disconnect_from_calibre_db(calibre_db)
  
  data
}
