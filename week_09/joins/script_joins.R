## ---- message=FALSE------------------------------------------------------
library(dplyr)
load("data/star_wars.RData")

## ------------------------------------------------------------------------
planet %>%
  mutate(max_pop = max(population, na.rm = TRUE)) %>%
  filter(population == max_pop) %>%
  select(name)

## ------------------------------------------------------------------------
person %>%
  group_by(homeworld_id) %>%
  summarise(count = n()) %>%
  inner_join(planet, by = c("homeworld_id" = "planet_id")) %>%
  inner_join(species, by = c("homeworld_id")) %>%
  select(name.x, count, name.y) %>%
  arrange(desc(count)) %>%
  head(1)

## ------------------------------------------------------------------------
pilot %>%
  group_by(pilot_id) %>%
  summarise(count = n()) %>%
  inner_join(person, by=c("pilot_id" = "person_id")) %>%
  arrange(desc(count)) %>%
  select(name, count) %>%
  head(1)

## ------------------------------------------------------------------------
pilot %>%
  filter(craft_type == "vehicle") %>%
  group_by(pilot_id) %>%
  summarise(count = n()) %>%
  inner_join(person, by=c("pilot_id" = "person_id")) %>%
  arrange(desc(count)) %>%
  select(name, count) %>%
  head(2)

