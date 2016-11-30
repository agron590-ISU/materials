## ----setup, message = FALSE, echo=FALSE----------------------------------
library(tidyverse)
library(nycflights13)
library(lubridate)

library(modelr)
options(na.action = na.warn)

## ---- fig.width=6, fig.height=4------------------------------------------
ggplot(sim3, aes(x1, y)) + 
  geom_point(aes(colour = x2))

## ------------------------------------------------------------------------
mod1 <- lm(y ~ x1 + x2, data = sim3)
mod2 <- lm(y ~ x1 * x2, data = sim3)

## ------------------------------------------------------------------------
grid <- sim3 %>% 
  data_grid(x1, x2) %>% 
  gather_predictions(mod1, mod2)
grid

## ---- fig.width=6, fig.height=4------------------------------------------
ggplot(sim3, aes(x1, y, colour = x2)) + 
  geom_point() + 
  geom_line(data = grid, aes(y = pred)) + 
  facet_wrap(~ model)

## ---- fig.width=6, fig.height=4------------------------------------------
sim3 <- sim3 %>% 
  gather_residuals(mod1, mod2)

ggplot(sim3, aes(x1, resid, colour = x2)) + 
  geom_point() + 
  facet_grid(model ~ x2)

## ------------------------------------------------------------------------
ggplot(diamonds, aes(cut, price)) + geom_boxplot()

## ------------------------------------------------------------------------
ggplot(diamonds, aes(color, price)) + geom_boxplot()

## ------------------------------------------------------------------------
ggplot(diamonds, aes(clarity, price)) + geom_boxplot()

## ------------------------------------------------------------------------
ggplot(diamonds, aes(carat, price)) + 
  geom_point()

## ------------------------------------------------------------------------
diamonds2 <- diamonds %>% 
  filter(carat <= 2.5) %>% 
  mutate(lprice = log2(price), lcarat = log2(carat))

## ---- echo=FALSE, width=6, height=4--------------------------------------
ggplot(diamonds2, aes(lcarat, lprice)) + 
  geom_point()

## ------------------------------------------------------------------------
mod_diamond <- lm(lprice ~ lcarat, data = diamonds2)

## ------------------------------------------------------------------------
grid <- diamonds2 %>% 
  data_grid(carat = seq_range(carat, 20)) %>% 
  mutate(lcarat = log2(carat)) %>% 
  add_predictions(mod_diamond, "lprice") %>% 
  mutate(price = 2 ^ lprice)  

## ---- echo=FALSE---------------------------------------------------------
grid  

## ---- fig.width=6, fig.height=4------------------------------------------
ggplot(diamonds2, aes(carat, price)) + 
  geom_point() + 
  geom_line(data = grid, colour = "red", size = 1)

## ------------------------------------------------------------------------
diamonds2 <- diamonds2 %>% 
  add_residuals(mod_diamond, "lresid")

ggplot(diamonds2, aes(lcarat, lresid)) + 
  geom_point()

## ------------------------------------------------------------------------
ggplot(diamonds2, aes(cut, lresid)) + geom_boxplot()

## ------------------------------------------------------------------------
ggplot(diamonds2, aes(color, lresid)) + geom_boxplot()  

## ------------------------------------------------------------------------
ggplot(diamonds2, aes(clarity, lresid)) + geom_boxplot()

## ------------------------------------------------------------------------
mod_diamond2 <- lm(lprice ~ lcarat + color + cut + clarity, data = diamonds2)

## ------------------------------------------------------------------------
grid <- diamonds2 %>% 
  data_grid(cut, .model = mod_diamond2) %>% 
  add_predictions(mod_diamond2)
grid

## ------------------------------------------------------------------------
ggplot(grid, aes(cut, pred)) + 
  geom_point()

## ------------------------------------------------------------------------
daily <- flights %>% 
  mutate(date = make_date(year, month, day)) %>% 
  group_by(date) %>% 
  summarise(n = n())
daily  

## ------------------------------------------------------------------------
ggplot(daily, aes(date, n)) + 
  geom_line()

## ---- echo=FALSE, fig.width=6, fig.height=4------------------------------
daily <- daily %>% 
  mutate(wday = wday(date, label = TRUE))
ggplot(daily, aes(wday, n)) + 
  geom_boxplot()

## ---- fig.width=4, fig.height=2------------------------------------------
mod <- lm(n ~ wday, data = daily)

grid <- daily %>% 
  data_grid(wday) %>% 
  add_predictions(mod, "n")

ggplot(daily, aes(wday, n)) + 
  geom_boxplot() +
  geom_point(data = grid, colour = "red", size = 4)

## ---- fig.height=4, fig.width=6------------------------------------------
daily <- daily %>% 
  add_residuals(mod)
daily %>% 
  ggplot(aes(date, resid)) + 
  geom_ref_line(h = 0) + 
  geom_line()

## ------------------------------------------------------------------------
ggplot(daily, aes(date, resid, colour = wday)) + 
  geom_ref_line(h = 0) + 
  geom_line()

## ------------------------------------------------------------------------
daily %>% 
  filter(resid < -100)

## ------------------------------------------------------------------------
    daily %>% 
      ggplot(aes(date, resid)) + 
      geom_ref_line(h = 0) + 
      geom_line(colour = "grey50") + 
      geom_smooth(se = FALSE, span = 0.20)

## ---- echo=FALSE, fig.width=6, fig.height=4------------------------------
daily %>% 
  filter(wday == "Sat") %>% 
  ggplot(aes(date, n)) + 
    geom_point() + 
    geom_line() +
    scale_x_date(NULL, date_breaks = "1 month", date_labels = "%b")

## ------------------------------------------------------------------------
term <- function(date) {
  cut(date, 
    breaks = ymd(20130101, 20130605, 20130825, 20140101),
    labels = c("spring", "summer", "fall") 
  )
}

daily <- daily %>% 
  mutate(term = term(date)) 

## ---- fig.height=4, fig.width=6------------------------------------------
daily %>% 
  filter(wday == "Sat") %>% 
  ggplot(aes(date, n, colour = term)) +
  geom_point(alpha = 1/3) + 
  geom_line() +
  scale_x_date(NULL, date_breaks = "1 month", date_labels = "%b")

## ---- fig.height=4, fig.width=6------------------------------------------
daily %>% 
  ggplot(aes(wday, n, colour = term)) +
    geom_boxplot()

## ------------------------------------------------------------------------
mod1 <- lm(n ~ wday, data = daily)
mod2 <- lm(n ~ wday * term, data = daily)

## ------------------------------------------------------------------------
daily %>% 
  gather_residuals(without_term = mod1, with_term = mod2) %>% 
  ggplot(aes(date, resid, colour = model)) +
    geom_line(alpha = 0.75)

## ---- echo=FALSE---------------------------------------------------------
grid <- daily %>% 
  data_grid(wday, term) %>% 
  add_predictions(mod2, "n")

ggplot(daily, aes(wday, n)) +
  geom_boxplot() + 
  geom_point(data = grid, colour = "red") + 
  facet_wrap(~ term)

## ---- warn = FALSE-------------------------------------------------------
mod3 <- MASS::rlm(n ~ wday * term, data = daily)

## ------------------------------------------------------------------------
daily %>% 
  add_residuals(mod3, "resid") %>% 
  ggplot(aes(date, resid)) + 
  geom_hline(yintercept = 0, size = 2, colour = "white") + 
  geom_line()

