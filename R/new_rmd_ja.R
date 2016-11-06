#' Make new .Rmd file for Japanese.
#'
#' @param file Charactor. File output R Markdown file name.
#' @param path Path to directory for output.
#' @param type Charactor or charactor vector. Now you can use "html", "pdf", "word", "odt", md", "ioslides", "slidy", "revealjs", "dashboard", "notebook", and "beamer".
#' @param systime Logical. If TRUE then set `sys.time` to `date: `.
#' @param title Charactor. If ""(default) then set file name.
#' @param subtitle Charactor. Set `subtitle: `.
#' @param author Charactor. Set `author: `.
#' @param toc Logical. If TRUE then set `toc = true`.
#' @param self_contained Logical. If FALSE, then set "self_contained: false".
#' @param css Charactor. Set `css: `.
#' @param load_p Charactor vector. Set package names if you want to load.
#' @export

new_rmd_ja <- function(file, path = ".", type = "html", systime = TRUE,
                       title = "", subtitle = "", author = "", toc = FALSE, self_contained = TRUE, css = NULL,
                       load_p = NULL){
  if(missing(file)){
    stop("set 'file' to file name.")
  } else {
    if(grepl(".Rmd$", file)||grepl(".rmd$", file)){
      filename <- file.path(path, file)
    } else {
      filename <- file.path(path, paste0(file, ".Rmd"))
    }
  }

  if(!dir.exists(path)){
    dir.create(path)
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
  if(!self_contained){
    self_c <- "\n    self_contained: false"
  } else {
    self_c <- NULL
  }
  if(toc){
    toc_c <- "\n    toc: true"
  } else {
    toc_c <- NULL
  }
  if(!missing(css)){
    css_c <- paste0("\n    css: ", css)
  } else {
    css_c <- NULL
  }


  output_list <- list()
  if(sum(type %in% "html")){
    output_list$html <- paste0("  html_document:\n    md_extensions: -ascii_identifiers", self_c, toc_c, css_c)
  }
  if(sum(type %in% "revealjs")){
    output_list$revealjs <- paste0("  revealjs::revealjs_presentation:\n    pandoc_args: [\n      '--from', 'markdown+autolink_bare_uris+tex_math_single_backslash-implicit_figures'\n    ]", self_c, toc_c, css_c)
  }
  if(sum(type %in% "ioslide")){
    output_list$ioslide <- paste0("  ioslides_presentation:\n    md_extensions: -ascii_identifiers", self_c, toc_c, css_c)
  }
  if(sum(type %in% "slidy")){
    output_list$slidy <- paste0("  slidy_presentation:\n    md_extensions: -ascii_identifiers", self_c, toc_c, css_c)
  }
  if(sum(type %in% "beamer")){
    output_list$beamer <- paste0("  beamer_presentation:\n    md_extensions: -ascii_identifiers\n    latex_engine: lualatex", toc_c, "\nmainfont: IPAMincho")
  }
  if(sum(type %in% "pdf")){
    output_list$pdf <- paste0("  pdf_document:\n    latex_engine: lualatex", self_c, toc_c, "\nmainfont: IPAMincho")
  }
  if(sum(type %in% "word")){
    output_list$word <- paste0("  word_document:\n    md_extensions: -ascii_identifiers", self_c, toc_c)
  }
  if(sum(type %in% "md")){
    output_list$md <- paste0("  md_document:\n    md_extensions: -ascii_identifiers", self_c, toc_c)
  }
  if(sum(type %in% "odt")){
    output_list$odt <- paste0("  odt_document:\n    md_extensions: -ascii_identifiers", self_c, toc_c)
  }
  if(sum(type %in% "notebook")){
    output_list$notebook <- paste0("  html_notebook:\n    md_extentions: -ascii_identifiers", toc_c, css_c)
  }
  if(sum(type %in% "dashboard")){
    output_list$dashboard <- paste0("  flexdashboard::flex_dashboard:\n    md_extentions: -ascii_identifiers", self_c, css_c)
  }
  output <- paste0("output:\n", paste(output_list, collapse = "\n"))

  l_p <- NULL
  if(!missing(load_p)){
    l_p <- paste0("library(", load_p, ")")
    l_p <- paste(l_p, collapse = "\n")
  }
  if(sum(type %in% "dashboard")){
    setupchunk <- paste("\n```{r setup, include=FALSE}", l_p, "```", sep = "\n")
  } else {
    setupchunk <- paste("\n```{r setup, include=FALSE}", "knitr::opts_chunk$set(echo = TRUE)", l_p, "```", sep = "\n")
  }

  cat("---", title, subtitle, author, date, output, "---", setupchunk, file = filename, sep = "\n")

}
