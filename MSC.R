
# 1. Load the required libraries
library(ggplot2)
library(dplyr)

# 2. Read your actual Masterfile data 
# (Updated to match your exact new file name)
msc_data <- read.csv("MSC_Masterfile_v3 - Copy.csv", stringsAsFactors = FALSE)

# 3. Clean and summarise the data
tissue_counts <- msc_data %>%
  filter(!is.na(`Tissue.Category`) & `Tissue.Category` != "") %>%
  group_by(`Tissue.Category`) %>%
  summarise(Study_Count = n()) %>%
  arrange(desc(Study_Count))

# Ensure the categories stay in order from highest to lowest on the graph
tissue_counts$`Tissue.Category` <- factor(tissue_counts$`Tissue.Category`, levels = tissue_counts$`Tissue.Category`)

# 4. Build the ggplot (Layer by Layer)
ggplot(data = tissue_counts, aes(x = `Tissue.Category`, y = Study_Count, fill = `Tissue.Category`)) +
  
  # Layer 1: The Geometry (Bar chart)
  geom_bar(stat = "identity", color = "black", alpha = 0.8) +
  
  # Layer 2: Add the specific numbers on top of each bar
  geom_text(aes(label = Study_Count), vjust = -0.5, size = 5, fontface = "bold") +
  
  # Layer 3: The Labels and Titles
  labs(
    title = "Systematic Review: MSC Tissue Source Distribution",
    subtitle = "Analysis of primary studies included in the Masterfile",
    x = "Tissue Source Category",
    y = "Number of Included Studies"
  ) +
  
  # Layer 4: The Theme (Clean, professional formatting)
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    axis.title = element_text(face = "bold", size = 12),
    axis.text.x = element_text(angle = 45, hjust = 1, size = 11), 
    legend.position = "none" 
  )