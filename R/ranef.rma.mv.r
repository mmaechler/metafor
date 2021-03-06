ranef.rma.mv <- function(object, level, digits, transf, targs, verbose=FALSE, ...) {

   x <- object

   if (!inherits(x, "rma.mv"))
      stop("Argument 'x' must be an object of class \"rma.mv\".")

   na.act <- getOption("na.action")

   if (!is.element(na.act, c("na.omit", "na.exclude", "na.fail", "na.pass")))
      stop("Unknown 'na.action' specified under options().")

   if (missing(level))
      level <- x$level

   if (missing(digits))
      digits <- x$digits

   if (missing(transf))
      transf <- FALSE

   if (missing(targs))
      targs <- NULL

   if (missing(verbose))
      verbose <- FALSE

   expand <- FALSE

   level <- ifelse(level > 1, (100-level)/100, ifelse(level > .5, 1-level, level))

   if (is.element(x$test, c("knha","adhoc","t"))) {
      crit <- qt(level/2, df=x$dfs, lower.tail=FALSE)
   } else {
      crit <- qnorm(level/2, lower.tail=FALSE)
   }

   ### TODO: check computations for user-defined weights

   if (!is.null(x$W))
      stop("Extraction of random effects for models with non-standard weights not currently implemented.")

   #########################################################################

   out <- NULL

   if (verbose)
      message("\nComputing inverse marginal var-cov and hat matrix ... ", appendLF = FALSE)

   ### compute inverse marginal var-cov and hat matrix

   W     <- chol2inv(chol(x$M))
   stXWX <- chol2inv(chol(as.matrix(t(x$X) %*% W %*% x$X)))
   H     <- x$X %*% stXWX %*% crossprod(x$X,W)

   if (verbose)
      message("Done.")

   ### compute residuals

   ei <- c(x$yi - x$X %*% x$beta) ### use this instead of resid(), since this guarantees that the length is correct
   ei[abs(ei) < 100 * .Machine$double.eps] <- 0

   ### create identity matrix

   if (x$sparse) {
      I <- Diagonal(x$k)
   } else {
      I <- diag(x$k)
   }

   if (x$withS) {

      # u = DZ'W(y - Xb) = DZ'We, where W = M^-1

      out <- vector(mode="list", length=x$sigma2s)
      names(out) <- x$s.names

      for (j in seq_len(x$sigma2s)) {

         if (verbose)
            message(paste0("Computing BLUPs for '", paste0("~ 1 | ", x$s.names[j]), "' term ... "), appendLF = FALSE)

         if (x$Rfix[j]) {
            if (x$sparse) {
               D <- x$sigma2[j] * Matrix(x$R[[j]], sparse=TRUE)
            } else {
               D <- x$sigma2[j] * x$R[[j]]
            }
         } else {
            if (x$sparse) {
               D <- x$sigma2[j] * Diagonal(x$s.nlevels[j])
            } else {
               D <- x$sigma2[j] * diag(x$s.nlevels[j])
            }
         }

         DZtW  <- D %*% t(x$Z.S[[j]]) %*% W
         pred  <- as.vector(DZtW %*% cbind(ei))
         #vpred <- D - (D %*% t(x$Z.S[[j]]) %*% W %*% x$Z.S[[j]] %*% D - D %*% t(x$Z.S[[j]]) %*% W %*% x$X %*% stXWX %*% t(x$X) %*% W %*% x$Z.S[[j]] %*% D)
         vpred <- D - (DZtW %*% (I - H) %*% x$Z.S[[j]] %*% D)

         se <- sqrt(diag(vpred))
         pi.lb <- c(pred - crit * se)
         pi.ub <- c(pred + crit * se)

         pred <- data.frame(intrcpt=pred, se=se, pi.lb=pi.lb, pi.ub=pi.ub)

         if (na.act == "na.omit") {

            rownames(pred) <- x$s.levels[[j]]
            out[[j]] <- pred

         }

         if (na.act == "na.exclude" || na.act == "na.pass") {

            ### determine which levels were removed

            s.levels.r <- !is.element(x$s.levels.f[[j]], x$s.levels[[j]])

            NAs <- rep(NA, x$s.nlevels.f[j])
            tmp <- data.frame(intrcpt=NAs, se=NAs, pi.lb=NAs, pi.ub=NAs)
            tmp[!s.levels.r,] <- pred
            pred <- tmp

            rownames(pred) <- x$s.levels.f[[j]]

            out[[j]] <- pred

         }

         if (expand) {

            rows <- c(x$Z.S[[j]] %*% seq_along(x$s.levels[[j]]))
            pred <- pred[rows,]
            rnames <- x$s.levels[[j]][rows]

            rownames(pred) <- .make.unique(x$s.levels[[j]][rows])

         }

         if (verbose)
            message("Done.")

      }

   }

   if (x$withG) {

      if (verbose)
         message(paste0("Computing BLUPs for '", paste(x$g.names, collapse=" | "), "' term ... "), appendLF = FALSE)

      G  <- ((x$Z.G1 %*% x$G %*% t(x$Z.G1)) * tcrossprod(x$Z.G2))
      GW <- G %*% W
      pred  <- as.vector(GW %*% cbind(ei))
      #vpred <- G - (G %*% W %*% G - G %*% W %*% x$X %*% stXWX %*% t(x$X) %*% W %*% G)
      vpred <- G - (GW %*% (I - H) %*% G)

      se <- sqrt(diag(vpred))
      pi.lb <- c(pred - crit * se)
      pi.ub <- c(pred + crit * se)

      pred <- data.frame(intrcpt=pred, se=se, pi.lb=pi.lb, pi.ub=pi.ub)

      r.names <- paste(x$mf.g[[1]], x$mf.g[[2]], sep=" | ")
      is.dup  <- duplicated(r.names)

      pred <- pred[!is.dup,]

      rownames(pred) <- r.names[!is.dup]

      r.order <- order(x$mf.g[[2]][!is.dup], x$mf.g[[1]][!is.dup])

      pred <- pred[r.order,]

      out <- c(out, list(pred))
      names(out)[length(out)] <- paste(x$g.names, collapse=" | ")

      if (verbose)
         message("Done.\n")

   }

   #if (x$withG || x$withH)
   #   warning("Extraction of random effects for models with '~ inner | outer' structures not currently implemented.")

   #########################################################################

   ### if requested, apply transformation function

   if (is.function(transf)) {
      if (is.null(targs)) {
         out <- lapply(out, transf)
      } else {
         out <- lapply(out, transf, targs)
      }
      out <- lapply(out, function(x) x[,-2,drop=FALSE])
      transf <- TRUE
   }

   ### make sure order of intervals is always increasing

   #tmp <- .psort(pi.lb, pi.ub)
   #pi.lb <- tmp[,1]
   #pi.ub <- tmp[,2]

   #########################################################################

   if (is.null(out)) {
      return()
   } else {
      return(out)
   }

}
