library(ggplot2)
library(fishualize)
library(readr)
library(forcats)
library(dplyr)

data <- read_csv("data/data_proportions.csv") %>%
  mutate(name = fct_relevel(name, c("fi_high", "both_high", "cl_high")))

plot <- 
  ggplot(data) + 
  geom_hline(yintercept = 0.5, color = "lightgrey", size = 0.4) +
  geom_hline(yintercept = 0.75, color = "lightgrey", size = 0.4) +
  geom_hline(yintercept = 0.25, color = "lightgrey", size = 0.4) +
  annotate("text", x = -Inf, y = c(0.3, 0.55, 0.8), 
           label = c("0.25", "0.50", "0.75") , 
           color = "grey", size = 3 , angle = 0, fontface = "bold", hjust = 1) +
  geom_bar(aes(name, value, fill = fun), stat = "identity",
           position = position_dodge(), alpha = 0.9, width = 0.7) +
  labs(y = "Proportion communities with increased vulnerability", x = "") +
  annotate("text", x = c("fi_high", "both_high", "cl_high"), y = c(0.9, 0.9, 0.9), 
           label = c("Fishing", "Both", "Climate change"), angle = c(-60, 0, 60), size = 5) +
  scale_fill_fish_d(option = "Callanthias_australis",
                    labels = c("N excretion", 
                               "P excretion", 
                               "Production",
                               "Herbivory",
                               "Piscivory"),
                    name = "Proportion communities with increased functional vulnerability") +
  theme_void() +
  theme(legend.position = c(0.5, 0.95), 
        text = element_text(size = 12),
        legend.margin = margin(0,0,0,0), panel.spacing = unit(c(0,0,0,0), units = "cm"), 
        legend.direction = "horizontal"
  )  +
  scale_y_continuous(limits = c(-0.3, 0.95), breaks = c(0, 0.5, 1)) +
  guides(fill = guide_legend(title.position="top", legend.title.align = 0.5, title.vjust = 1)) +
  coord_polar()
plot
