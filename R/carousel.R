#' Make html tags for embeding Bootstrap carousel
#'
#' @param id character. html identifiler.
#' @param img characters vector. Path to imgs.
#' @param caption_title charactors vector. Titles of image caption. This should have the same length of img.
#' @param caption_text charactors vector. Texts of image caption. This should have the same length of img.
#' @param interval integer. The amount of time to delay between automatically cycleing an item. If false, carousel will not automatically cycle.
#' @param pause string. If set to "hover", pauses the cycling of the carousel on mouseenter and resumes the cycling of the carousel on mouseleave. If set to null, hovering over the carousel won't pause it.
#' @param wrap Logical. Whether the carousel should cycle continuously or have hard stops.
#' @param keyboad Logical. Whether the carousel should react to keyboard events.
#' @examples
#'
#' # set imgs
#' png("plot1.png")
#' plot(1:10)
#' dev.off()
#' png("plot2.png")
#' plot(10:1)
#' dev.off()
#'
#' # insert the function into a R chunk
#' carousel(id = "carousel_id", img = c("plot1.png", "plot2.png"))
#'
#' @import htmltools
#'
#' @export
carousel <-
  function(id,
           img,
           caption_title = NULL,
           caption_text,
           interval = "5000",
           pause = "hover",
           wrap = TRUE,
           keyboard = TRUE) {
    # args check
    if (missing(caption_title)) {
      caption_title <- character(length(img))
    }
    if (missing(caption_text)) {
      caption_text <-  character(length(img))
    }
    if (wrap) {
      wrap <- "true"
    } else{
      wrap <- "false"
    }
    if (keyboard) {
      keyboard <- "true"
    } else{
      keyboard <- "false"
    }


    # make Indicators
    li_active <-
      tags$li(
        'data-target' = paste0('#', id),
        'data-slide-to' = as.character(0),
        class = "active"
      )
    li_others <- mapply(
      tags$li,
      'data-target' = paste0('#', id),
      'data-slide-to' = as.character(1:(length(img) - 1)),
      SIMPLIFY = FALSE,
      USE.NAMES = FALSE
    )
    indi <- tags$ol(li_active, li_others, class = "carousel-indicators")

    # make carousel-inner
    item_active <- tags$div(
      class = "item active",
      tags$img(src = img[1], alt = ""),
      tags$div(class = "carousel-caption",
               tags$h3(caption_title[1]),
               tags$p(caption_text[1]))
    )
    item_img <- mapply(
      tags$img,
      src = img[2:length(img)],
      alt = "",
      SIMPLIFY = FALSE,
      USE.NAMES = FALSE
    )
    item_caption_title <- mapply(tags$h3,
                                 caption_title[2:length(caption_title)],
                                 SIMPLIFY = FALSE,
                                 USE.NAMES = FALSE)
    item_caption_text <- mapply(tags$p,
                                caption_text[2:length(caption_text)],
                                SIMPLIFY = FALSE,
                                USE.NAMES = FALSE)
    item_caption <- mapply(
      tags$div,
      class = "carousel-caption",
      item_caption_title,
      item_caption_text,
      SIMPLIFY = FALSE,
      USE.NAMES = FALSE
    )
    item_others <- mapply(
      tags$div,
      class = "item",
      item_img,
      item_caption,
      SIMPLIFY = FALSE,
      USE.NAMES = FALSE
    )
    item <-
      tags$div(item_active, item_others, class = "carousel-inner", role = "listbox")

    # make control
    left_ctrl <-
      tags$a(
        class = "left carousel-control",
        href = paste0('#', id),
        role = "button",
        'data-slide' = "prev",
        span(class = "glyphicon glyphicon-chevron-left", 'aria-hidden' =
               "true"),
        span(class = "sr-only", "Previous")
      )
    right_ctrl <-
      tags$a(
        class = "right carousel-control",
        href = paste0('#', id),
        role = "button",
        'data-slide' = "next",
        span(class = "glyphicon glyphicon-chevron-right", 'aria-hidden' =
               "true"),
        span(class = "sr-only", "Next")
      )

    # make carousel
    ca <-
      tags$div(
        indi,
        item,
        left_ctrl,
        right_ctrl,
        id = id,
        class = "carousel slide",
        'data-ride' = "carousel",
        'data-interval' = interval,
        'data-pause' = pause,
        'data-wrap' = wrap,
        'data-keyboard' = keyboard
      )
    tagList(ca)
  }
