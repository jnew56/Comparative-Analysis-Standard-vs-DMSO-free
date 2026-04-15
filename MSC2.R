# 1. Load the required libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# 2. Build the Comparative Dataset (based on your Masterfile findings)
compare_data <- data.frame(
  Protocol = c("Fresh (Baseline)", "10% DMSO (Standard)", "Trehalose (DMSO-Free)"),
  Viability = c(98, 88, 89),               # Overall viability % post-thaw
  Apoptosis = c(2, 15, 3),                 # Immediate apoptosis %
  T_Cell_Suppression = c(100, 55, 95)      # Relative immunomodulatory potency %
)

# 3. Reshape the data for a Grouped Bar Chart
compare_long <- pivot_longer(
  compare_data, 
  cols = c("Viability", "Apoptosis", "T_Cell_Suppression"), 
  names_to = "Metric", 
  values_to = "Percentage"
)

# Clean up the metric names for the graph's X-axis
compare_long$Metric <- factor(compare_long$Metric, 
                              levels = c("Viability", "Apoptosis", "T_Cell_Suppression"),
                              labels = c("Overall Viability (%)", "Apoptosis Rate (%)", "T-Cell Suppression (%)"))

# Ensure the protocols display in the correct logical order in the legend
compare_long$Protocol <- factor(compare_long$Protocol, 
                                levels = c("Fresh (Baseline)", "10% DMSO (Standard)", "Trehalose (DMSO-Free)"))

# 4. Build the Comparative Plot
ggplot(compare_long, aes(x = Metric, y = Percentage, fill = Protocol)) +
  
  # The Geometry: position_dodge puts the bars side-by-side
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), width = 0.7, color = "black") +
  
  # Add the exact percentages on top of each bar
  geom_text(aes(label = paste0(Percentage, "%")), 
            position = position_dodge(width = 0.8), 
            vjust = -0.5, size = 4.5, fontface = "bold") +
  
  # Custom, professional color palette
  scale_fill_manual(values = c("Fresh (Baseline)" = "#BBDEFB", 
                               "10% DMSO (Standard)" = "#EF9A9A", 
                               "Trehalose (DMSO-Free)" = "#A5D6A7")) +
  
  # The Labels and Titles
  labs(
    title = "Comparative Analysis: Standard vs. DMSO-Free Cryopreservation",
    subtitle = "Evaluating downstream functional viability and immunopotency",
    x = "Functional Assay Metric",
    y = "Percentage (%)"
  ) +
  
  # Clean, clinical theme formatting
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 15),
    plot.subtitle = element_text(size = 12, color = "gray30"),
    axis.title = element_text(face = "bold", size = 12),
    axis.text.x = element_text(size = 11, face = "bold"),
    legend.title = element_blank(), # Hides the redundant word 'Protocol' above the legend
    legend.position = "top",        # Moves legend to the top for a cleaner look
    legend.text = element_text(size = 11)
  )