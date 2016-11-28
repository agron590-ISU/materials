## ----setup, message = FALSE----------------------------------------------
library(tidyverse)

library(modelr)
options(na.action = na.warn)

## ---- fig.height=4, fig.width=4------------------------------------------
ggplot(sim1, aes(x, y)) + 
  geom_point()

## ---- echo = FALSE, fig.height=4, fig.width=4----------------------------
models <- tibble(
  a1 = runif(250, -20, 40),
  a2 = runif(250, -5, 5)
)

ggplot(sim1, aes(x, y)) + 
  geom_abline(aes(intercept = a1, slope = a2), data = models, alpha = 1/4) +
  geom_point() 

## ---- echo = FALSE, fig.height=4, fig.width=4----------------------------
models <- tibble(
  a1 = runif(250, -20, 40),
  a2 = runif(250, -5, 5)
)

ggplot(sim1, aes(x, y)) + 
  geom_abline(aes(intercept = a1, slope = a2), data = models, alpha = 1/4) +
  geom_point() 

## ---- echo = FALSE, fig.height=4, fig.width=4----------------------------
dist1 <- sim1 %>% 
  mutate(
    dodge = rep(c(-1, 0, 1) / 20, 10),
    x1 = x + dodge,
    pred = 7 + x1 * 1.5
  )

ggplot(dist1, aes(x1, y)) + 
  geom_abline(intercept = 7, slope = 1.5, colour = "grey40") +
  geom_point(colour = "grey40") +
  geom_linerange(aes(ymin = y, ymax = pred), colour = "#3366FF") 

## ------------------------------------------------------------------------
model1 <- function(a, data) {
  a[1] + data$x * a[2]
}
model1(c(7, 1.5), sim1)

## ------------------------------------------------------------------------
measure_distance <- function(mod, data) {
  diff <- data$y - model1(mod, data)
  sqrt(mean(diff ^ 2))
}
measure_distance(c(7, 1.5), sim1)

## ------------------------------------------------------------------------
sim1_dist <- function(a1, a2) {
  measure_distance(c(a1, a2), sim1)
}

models <- models %>% 
  mutate(dist = purrr::map2_dbl(a1, a2, sim1_dist))
models

## ---- echo=FALSE, fig.height=4, fig.width=4------------------------------
ggplot(sim1, aes(x, y)) + 
  geom_point(size = 2, colour = "grey30") + 
  geom_abline(
    aes(intercept = a1, slope = a2, colour = -dist), 
    data = filter(models, rank(dist) <= 10)
  )

## ---- echo=FALSE---------------------------------------------------------
ggplot(models, aes(a1, a2)) +
  geom_point(data = filter(models, rank(dist) <= 10), size = 4, colour = "red") +
  geom_point(aes(colour = -dist))

## ---- fig.height=4, fig.width=4------------------------------------------
grid <- expand.grid(
  a1 = seq(-5, 20, length = 25),
  a2 = seq(1, 3, length = 25)
  ) %>% 
  mutate(dist = purrr::map2_dbl(a1, a2, sim1_dist))

## ---- echo=FALSE, fig.height=4, fig.width=6------------------------------
grid %>% 
  ggplot(aes(a1, a2)) +
  geom_point(data = filter(grid, rank(dist) <= 10), size = 4, colour = "red") +
  geom_point(aes(colour = -dist)) 

## ---- echo=FALSE---------------------------------------------------------
ggplot(sim1, aes(x, y)) + 
  geom_point(size = 2, colour = "grey30") + 
  geom_abline(
    aes(intercept = a1, slope = a2, colour = -dist), 
    data = filter(grid, rank(dist) <= 10)
  )

## ------------------------------------------------------------------------
best <- optim(c(0, 0), measure_distance, data = sim1)
best$par

## ---- echo=FALSE, fig.width=6, fig.height=4------------------------------
ggplot(sim1, aes(x, y)) + 
  geom_point(size = 2, colour = "grey30") + 
  geom_abline(intercept = best$par[1], slope = best$par[2])

## ------------------------------------------------------------------------
grid <- sim1 %>% 
  data_grid(x) 
grid

## ---- echo=FALSE---------------------------------------------------------
sim1_mod <- lm(y ~ x, data = sim1)
coef(sim1_mod)

## ------------------------------------------------------------------------
grid <- grid %>% 
  add_predictions(sim1_mod) 
grid

## ------------------------------------------------------------------------
ggplot(sim1, aes(x)) +
  geom_point(aes(y = y)) +
  geom_line(aes(y = pred), data = grid, colour = "red", size = 1)

## ------------------------------------------------------------------------
sim1 <- sim1 %>% 
  add_residuals(sim1_mod)
sim1

## ---- fig.height = 4, fig.width = 6--------------------------------------
ggplot(sim1, aes(resid)) + 
  geom_freqpoly(binwidth = 0.5)

## ---- fig.height = 4, fig.width = 6--------------------------------------
ggplot(sim1, aes(x, resid)) + 
  geom_ref_line(h = 0) +
  geom_point() 

## ------------------------------------------------------------------------
df <- tribble(
  ~y, ~x1, ~x2,
  4, 2, 5,
  5, 1, 6
)
model_matrix(df, y ~ x1)

## ------------------------------------------------------------------------
model_matrix(df, y ~ x1 + x2)

## ---- fig.width = 6, fig.height=4----------------------------------------
ggplot(sim2) + 
  geom_point(aes(x, y))

## ------------------------------------------------------------------------
mod2 <- lm(y ~ x, data = sim2)

grid <- sim2 %>% 
  data_grid(x) %>% 
  add_predictions(mod2)
grid

## ---- fig.width = 6, fig.height=4----------------------------------------
ggplot(sim2, aes(x)) + 
  geom_point(aes(y = y)) +
  geom_point(data = grid, aes(y = pred), colour = "red", size = 4)

