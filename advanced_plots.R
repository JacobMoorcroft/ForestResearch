## INTERACTIVE PLOT:

# blurb about private vs public forest visualisation

rm(list=setdiff(ls(), c("processed_extracted_data", "woodland_by_year"))) # removes unnecessary variables to clean environment

private_vs_public_trees<-data.frame(
  country=c(rep("England",108)),
  tree_type=c(rep("FE conifers",27),rep("Private conifers",27),rep("FE broadleaves",27),rep("Private broadleaves",27)),
  woodland=c(processed_extracted_data$`FE conifers (thousand ha)`,processed_extracted_data$`Private sector conifers (thousand ha)`,
             processed_extracted_data$`FE broadleaves (thousand ha)`,processed_extracted_data$`Private sector broadleaves (thousand ha)`),
  year=c(woodland_by_year$year_ending_March_31st)) # creates a dataframe amenable to the upcoming visualisation