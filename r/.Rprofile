# set width
options("width" = 160)
# set tab width
options("tab width" = 2)
# show sub-second time stamps
options("digits.secs" = 3)
# set repo
r <- getOption("repos")
r["CRAN"] <- "http://cran-mirror.cs.uu.nl/"
options(repos = r)
# set prompt
options(prompt = "> ", digits = 4, show.signif.stars = FALSE)

# load useful packages in the beginning
.First <- function() {
#    message("Pre-loaded package(s):")
#    message("  - R.utils\n")
    suppressWarnings(suppressMessages(require(R.utils, quietly = TRUE)))
}

# define handy functions
peek <- function(obj) {
    # Shows useful quick information about an object
    #
    # Args:
    #   obj: R object to investigate

    message("class : ", class(obj))
    message("typeof: ", typeof(obj))
    message("length: ", length(obj))
    message("rows  : ", nrow(obj))
    message("cols  : ", ncol(obj))

#    if (!is.null(names(obj))) {
#        message("names:\n")
#        head(names(obj), n = 10)
#    }
#    if (!is.null(colnames(obj))) {
#        message("colnames:\n")
#        head(colnames(obj), n = 10)
#    }
#    if (!is.null(rownames(obj))) {
#        message("rownames:\n")
#        head(rownames(obj), n = 10)
#    }
}

bioc <- function() {
    source("http://bioconductor.org/biocLite.R")
}

message(R.version.string)
