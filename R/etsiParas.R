#' @export
#' @title Etsi Paras
#' @description Search for the best?
#' @param osuus Percentages?
#' @param omaFreqs own Freqs?
#' @param osuusTaulu Percentage table?
#' @param logml log maximum likelihood
etsiParas <- function (osuus, osuusTaulu, omaFreqs, logml) {
    ready <- 0
    while (ready != 1) {
        muutokset <- laskeMuutokset4(osuus, osuusTaulu, omaFreqs, logml)

        # Work around R's max() limitation on complex numbers
        if (any(sapply(muutokset, class) == "complex")) {
            maxRe <- max(Re(as.vector(muutokset)))
            maxIm <- max(Im(as.vector(muutokset)))
            maxMuutos <- complex(real = maxRe, imaginary = maxIm)
        } else {
            maxMuutos <- max(as.vector(muutokset))
        }
        indeksi <- which(muutokset == maxMuutos)
        if (Re(maxMuutos) > 0) {
            osuusTaulu <- suoritaMuutos(osuusTaulu, osuus, indeksi)
            logml <- logml + maxMuutos
        } else {
            ready <- 1
        }
    }
    return (c(osuusTaulu, logml))
}