#' embed slide by iframe
#'
#' @param url web-slide url. Slideshare, SpeakerDeck, and html slides are now available.
#' @param width ignored.
#' @param height ignored.
#' @examples
#' # SlideShare url
#' embed_slide("http://www.slideshare.net/makotohirakawa3/osakastan2-chap51")
#' # SpeakerDeck url
#' embed_slide("https://speakerdeck.com/yamano357/tokyor49-stringr-stringi")
#' # other html-slide url
#' embed_slide("http://kz-md.net/stat/tmp_box/intro_tubeplayR.html#/")
#'
#' @import magrittr
#' @import RCurl
#' @importFrom stringr str_detect
#' @importFrom stringr str_replace_all
#' @importFrom jsonlite fromJSON
#' @importFrom htmltools knit_print.html
#' @importFrom knitr include_url
#' @importFrom stringr str_replace
#'
#' @export
embed_slide <- function(url, width = "100%", height){
  if(str_detect(url, "slideshare.net")) {
    # for slideshare
    iframe_tag <- url %>%
      paste("http://www.slideshare.net/api/oembed/2?url=", ., "&format-json", sep = "") %>%
      getURI(.opts = curlOptions(followlocation=TRUE)) %>%
      str_replace_all("\n", "") %>%
      fromJSON() %>%
      .$html %>%
      knit_print.html()
  } else if(str_detect(url, "speakerdeck.com")) {
    # for speakerdeck
    iframe_tag <- url %>%
      paste("https://speakerdeck.com/oembed.json?url=", ., sep = "") %>%
      getURI(.opts = curlOptions(followlocation=TRUE)) %>%
      str_replace_all("\n", "") %>%
      fromJSON() %>%
      .$html %>%
      str_replace("//speakerdeck.com/player/", "https://speakerdeck.com/player/") %>%
      knit_print.html()
  } else {
    # other html-slide
    iframe_tag <- include_url(url = url)
  }
  return(iframe_tag)
}
