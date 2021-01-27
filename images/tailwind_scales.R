library(devtools)
library(tidyverse)

# Install R package from github
devtools::install_github('willcanniford/ggtailwind')

# Generate colour palette visual
tibble(fullname = names(ggtailwind::tailwind_cols_regex('.*-.*'))) %>%
  rowwise() %>%
  mutate(
    hex = ggtailwind::tailwind_cols(fullname),
    base_colour = as_factor(strsplit(fullname, '-')[[1]][1]),
    shade = as_factor(strsplit(fullname, '-')[[1]][2])
  ) %>%
  ggplot(aes(fct_reorder(shade, as.numeric(shade)), base_colour)) +
  geom_tile(aes(fill = hex)) +
  scale_fill_identity(guide = F) +
  theme_minimal() +
  coord_equal() +
  labs(x = NULL, y = NULL) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) -> scales_graphic

ggsave(scales_graphic, filename = 'tailwind_scales.jpeg')
