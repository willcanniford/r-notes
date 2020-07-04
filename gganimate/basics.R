library(tidyverse)
library(gganimate)


p <- ggplot(iris, aes(x = Petal.Width, y = Petal.Length)) + geom_point()

# Transition states breaks the data into subsets based on a variable: 'Species' 
anim <- p +
  transition_states(Species,
                    transition_length = 2,
                    state_length = 1)

anim

# Save the animation as a gif
anim_save('iris_basic.gif')
