#' Convert to a html document for zousan.
#'
#' html document including some tools.
#' @import rmarkdown
#' @inheritParams rmarkdown::html_document
#' @param katex Logical. If TRUE, then use katex instead of mathjax.
#' @param lightbox Logical. If TRUE, then set lightbox automatically.
#' @param showhide Logical. If TRUE, you could set show/hide button.
#' @export
zousan_document <- function(fig_width = 7,
                            fig_height = 5,
                            fig_retina = 2,
                            fig_caption = TRUE,
                            self_contained = FALSE,
                            dev = 'png',
                            keep_md = FALSE,
                            mathjax = "default",
                            md_extensions = "-ascii_identifiers",
                            template = "default",
                            katex = FALSE,
                            lightbox = TRUE,
                            showhide = TRUE,
                            ...) {
  # base pandoc options for all output
  args <- c()

  # template path and assets
  if(identical(template, "default")) {
    default_template <- system.file(
      "rmarkdown/templates/zousan_document/resources/default.html",
      package = "zousan"
    )
    args <- c(args, "--template", pandoc_path_arg(default_template))
  } else if(!is.null(template)) {
    args <- c(args, "--template", pandoc_path_arg(template))
  }

  # katex ready
  if(katex) {
    args <- c(args, pandoc_variable_arg("katex", "1"))
    mathjax <- NULL
  } else if(katex & !is.null(mathjax)) {
    message("katex and mathjax are not compatible.")
  }

  # lightbox ready
  if(lightbox) {
    args <- c(args, pandoc_variable_arg("lightbox", "1"))
  }

  # showhide ready
  if(showhide) {
    args <- c(args, pandoc_variable_arg("showhide", "1"))
  }

  # return format
  output_format(
    knitr = knitr_options_html(fig_width, fig_height, fig_retina, keep_md, dev),
    pandoc = pandoc_options(to = "html",
                            from = from_rmarkdown(fig_caption, md_extensions),
                            args = args),
    keep_md = keep_md,
    clean_supporting = self_contained,
    base_format = html_document(mathjax = mathjax,
                                md_extensions = md_extensions,
                                self_contained = self_contained,
                                ...)
  )
}
