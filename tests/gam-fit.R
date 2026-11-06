library(simml)

set.seed(20261106)
dat <- generate.data(n = 200, p = 4, family = "gaussian")

# Without plotting, the optional plotting model must be NULL.
fit0 <- fit.simml(
  y = dat$y, A = dat$A, X = dat$X,
  plots = FALSE, trace.iter = FALSE
)

stopifnot(
  "gam.fit" %in% names(fit0),
  is.null(fit0$gam.fit),
  inherits(fit0$g.fit, "gam")
)

# With plotting, the optional model should still be created.
pdf(file = NULL)
fit1 <- fit.simml(
  y = dat$y, A = dat$A, X = dat$X,
  plots = TRUE, trace.iter = FALSE
)
dev.off()

stopifnot(
  inherits(fit1$gam.fit, "gam"),
  isTRUE(all.equal(fit0$beta.coef, fit1$beta.coef))
)