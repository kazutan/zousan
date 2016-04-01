#' Make new .Rmd file for Japanese.
#'
#' @param Charactor. File output R Markdown file name.
#' @param path Path to directory for output.
#' @param type Charactor or charactor vector. If `type = "html"` then `output: html_document`. If `type = "revealjs` then `output: revealjs::revealjs_presentation`.
#' @param systime Logical. If `TRUE` then set `sys.time` to `date: `.
#' @param title Charactor. If ""(default) then set file name.
#' @param subtitle Charactor. set `subtitle: `.
#' @param author Charactor. set `author: `.
#' @export

new_rmd_ja <- function(file, path = ".", type = "html", systime = TRUE,
                       title = "", subtitle = "", author = ""){
  if(missing(file)){
    stop("set 'file' to file name.")
  } else {
    if(grepl(".Rmd$", file)||grepl(".rmd$", file)){
      filename <- file.path(path, file)
    } else {
      filename <- file.path(path, paste0(file, ".Rmd"))
    }
  }

  if(file.exists(filename)){
    stop(sprintf("file %s has already exited.", filename))
  } else {
    file.create(filename)
  }

  if(systime){
    date <- paste0("date: ","\"`r format(Sys.time(),'%Y/%m/%d')`\"")
  } else {
    date <- "date: "
  }

  if(title == ""){
    title <- paste0("title: \"", file, "\"")
  } else {
    title <- paste0("title: \"", title, "\"")
  }
  author <- paste0("author: \"", author, "\"")
  subtitle <- paste0("subtitle: \"", subtitle, "\"")

  setupchunk <- paste("\n```{r setup, include=FALSE}", "knitr::opts_chunk$set(echo = TRUE)", "```", sep = "\n")

  output_list <- list()
  if(sum(type %in% "html")){
    output_list$html <- "  html_document:\n    md_extentions: -ascii_identifiers"
  }
  if(sum(type %in% "revealjs")){
    output_list$revealjs <- "  revealjs::revealjs_presentation:\n    md_extentions: -ascii_identifiers"
  }
  output <- paste0("output:\n", paste(output_list, collapse = "\n"))

  cat("---", title, subtitle, author, date, output, "---", setupchunk, file = filename, sep = "\n")

}
