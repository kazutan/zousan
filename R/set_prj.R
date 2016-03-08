#' Set my R-Project.
#'
#' @param path Path to Project.
#' @return Make "R", "docs", "data" directories in this Project directory.
#' @examples
#' set_prj()
#' @export

set_prj <- function (path = ".")
{
  dir.create(file.path(path, "R"), showWarnings = FALSE)
  dir.create(file.path(path, "docs"), showWarnings = FALSE)
  dir.create(file.path(path, "data"), showWarnings = FALSE)
  invisible(TRUE)
}
