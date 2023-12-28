#' **Path to Calibre SQLite database**
#' 
#' @noRd

calibre_path <- function() "C:/Users/Nicolas/Nextcloud/Calibre"



#' **Connection to Calibre SQLite database**
#' 
#' @noRd

connect_to_calibre_db <- function() {
  
  invisible(
    DBI::dbConnect(drv    = RSQLite::SQLite(), 
                   dbname = file.path(calibre_path(), "metadata.db")))
}



#' **Disconnection from Calibre SQLite database**
#' 
#' @noRd

disconnect_from_calibre_db <- function(conn) {
  
  invisible(DBI::dbDisconnect(conn))
}
