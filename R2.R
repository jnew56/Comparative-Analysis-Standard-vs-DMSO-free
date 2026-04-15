# Updated R code for clean, parallel pathways
library(DiagrammeR)

grViz("
digraph msc_pipeline {

  # Set layout from Left to Right and increase spacing
  graph [layout = dot, rankdir = LR, nodesep = 0.6, ranksep = 0.8]

  # Default visual style for all nodes
  node [shape = rectangle, style = filled, fontname = Helvetica, fontsize = 12, penwidth = 2]

  # 1. Sourcing
  Source [label = 'Tissue Source', fillcolor = '#E1F5FE', color = '#0277BD']
  BM [label = 'Bone Marrow', fillcolor = '#E1F5FE', color = '#0277BD']
  Adipose [label = 'Adipose Tissue', fillcolor = '#E1F5FE', color = '#0277BD']
  
  # 2. Expansion
  Expansion [label = 'In Vitro Expansion\\n(Passage 3-5)', fillcolor = '#FFF9C4', color = '#FBC02D']
  
  # 3. Cryopreservation Arms
  DMSO [label = 'Cryopreservation\\n10% DMSO', fillcolor = '#FFCDD2', color = '#C62828']
  Trehalose [label = 'Cryopreservation\\nTrehalose (DMSO-Free)', fillcolor = '#C8E6C9', color = '#2E7D32']
  
  # 4. Thawing Arms (Separated to prevent crossed lines)
  DMSO_ImmThaw [label = 'Immediate Thaw\\n(37°C)', fillcolor = '#FFCDD2', color = '#C62828']
  DMSO_Acclimate [label = '24-Hour Acclimation\\n(Rescue Protocol)', fillcolor = '#FFCDD2', color = '#C62828']
  
  Treh_ImmThaw [label = 'Immediate Thaw\\n(37°C)', fillcolor = '#C8E6C9', color = '#2E7D32']
  
  # 5. Functional Assays
  Assays [label = 'Functional Assays', fillcolor = '#E1BEE7', color = '#6A1B9A']
  Viability [label = 'Viability\\n(Trypan/7-AAD)', fillcolor = '#E1BEE7', color = '#6A1B9A']
  Apoptosis [label = 'Apoptosis\\n(Annexin V)', fillcolor = '#E1BEE7', color = '#6A1B9A']
  Immuno [label = 'Immunomodulation\\n(T-cell Suppression)', fillcolor = '#E1BEE7', color = '#6A1B9A']

  # --- Draw the Connections ---
  Source -> {BM Adipose}
  {BM Adipose} -> Expansion
  
  Expansion -> DMSO
  Expansion -> Trehalose
  
  # DMSO pathway branches
  DMSO -> DMSO_ImmThaw
  DMSO -> DMSO_Acclimate
  
  # Trehalose pathway
  Trehalose -> Treh_ImmThaw
  
  # All pathways funnel into final testing
  {DMSO_ImmThaw DMSO_Ac