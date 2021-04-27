##' Download the example data set from hhwagner1/LandGenCourseData
##'  (\url{https://github.com/hhwagner1/LandGenCourseData/})
##' @title Stickleback data
##'
##' @param version Version number.  The default will load the most
##'   recent version on your computer or the most recent version known
##'   to the package if you have never downloaded the data before.
##'   With \code{stickleback_data_del}, specifying \code{version = NULL} will
##'   delete \emph{all} data sets.
##'
##' @param path Path to store the data at.  If not given,
##'   \code{datastorr} will use \code{rappdirs} to find the best place
##'   to put persistent application data on your system.  You can
##'   delete the persistent data at any time by running
##'   \code{stickleback_data_del(NULL)} (or \code{stickleback_data_del(NULL, path)} if you
##'   use a different path).
##'
##' @export
stickleback_data <- function(version = NULL, path = NULL) {
  datastorr::github_release_get(stickleback_data_info(path), version)
}

##' @export
##' @rdname stickleback_data
##'
##' @param local Logical indicating if local or github versions should
##'   be polled.  With any luck, \code{local = FALSE} is a superset of
##'   \code{local = TRUE}.  For \code{stickleback_data_version_current}, if
##'   \code{TRUE}, but there are no local versions, then we do check
##'   for the most recent github version.
##'
stickleback_data_versions <- function(local = TRUE, path = NULL) {
  datastorr::github_release_versions(stickleback_data_info(path), local)
}

##' @export
##' @rdname stickleback_data
stickleback_data_version_current <- function(local = TRUE, path = NULL) {
  datastorr::github_release_version_current(stickleback_data_info(path), local)
}

##' @export
##' @rdname stickleback_data
stickleback_data_del <- function(version, path = NULL) {
  datastorr::github_release_del(stickleback_data_info(path), version)
}

## Core data:
stickleback_data_info <- function(path) {
  datastorr::github_release_info("hhwagner1/LandGenCourseData",
                                 filename = "stickleback_data.R",
                                 read = read.table,
                                 path = path)
}

##' Maintainer-only function for releasing data.  This will look at
##' the version in the DESCRIPTION file and make a data release if the
##' GitHub repository contains the same version as we have locally.
##' Requires the \code{GITHUB_TOKEN} environment variable to be set.
##'
##' @title Make a data release.
##' @param ... Parameters passed through to \code{\link{github_release_create}}
##' @param path Path to the data (see \code{\link{stickleback_data}}).
##' @export
stickleback_data_release <- function(..., path = NULL) {
  datastorr::github_release_create(stickleback_data_info(path), ...)
}
