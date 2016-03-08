#' Set my R-Project.
#'
#' @param path Path to Project.
#' @return Make "R", "docs", "data" directories in this Project directory.
#' @examples
#' set_prj()
#' @export

set_prj <- function (path = ".", index = FALSE)
{
  dir.create(file.path(path, "R"), showWarnings = FALSE)
  dir.create(file.path(path, "docs"), showWarnings = FALSE)
  dir.create(file.path(path, "datas"), showWarnings = FALSE)
  if(index) {
    if(file.exists(file.path(path, "docs", "index.Rmd"))) {
      message("file 'index.Rmd' already exits.")
    } else {
      file.create(file.path(path, "docs", "index.Rmd"))
      cat("---", "title: ", "output: ", "---", sep = "/n", file = file.path(path, "docs","index.Rmd"))
    }
  }
  invisible(TRUE)
}
