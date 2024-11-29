devtools::install_github("rmcelreath/rethinking")
library(tidyverse)
library(rethinking)

data(Howell1)

n_points = 100

d = tibble(
  p_grid = seq(from=0, to=1, length.out = n_points),
  w = 6,
  n = 9
) %>% 
  mutate(
    prior = dunif(p_grid, min = 0, max = 1), 
    likelihood = dbinom(w, size = n, prob = p_grid),
    posterior = likelihood * prior / sum(likelihood * prior)
  ) %>% 
  View()

Howell1 %>% 
  filter(age > 18) %>% 
  ggplot() +
    geom_point(mapping = aes(x = height, y = weight))
