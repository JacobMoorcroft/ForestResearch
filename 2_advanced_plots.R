# While the previous basic plot was initially taken from a Data Science Project completed during my Master's studies, the following code demonstrates a more recent attempt at configuring
# and advancing upon my previous abilities with data management and visualisation.

## ADDITIONAL PACKAGES:
library(plotly)

# DATA PREPARATION & REORGANISATION

rm(list=setdiff(ls(), c("processed_extracted_data", "woodland_by_year", "BasicPlot"))) # removes unnecessary variables to clean environment

# A new data-frame!

public_trees<-data.frame(
  tree_type=c(rep("FE conifers, England",27),rep("FE broadleaves, England",27),rep("NRW conifers, Wales",27),rep("NRW broadleaves, Wales",27),
              rep("FLS conifers, Scotland",27),rep("FLS broadleaves, Scotland",27),rep("FS conifers, NI",27),rep("FS broadleaves, NI",27)),
  woodland=c(processed_extracted_data$`FE conifers (thousand ha)`,processed_extracted_data$`FE broadleaves (thousand ha)`,
             processed_extracted_data$`NRW conifers (thousand ha)`,processed_extracted_data$`NRW broadleaves (thousand ha)`,
             processed_extracted_data$`FLS conifers (thousand ha)`,processed_extracted_data$`FLS broadleaves (thousand ha)`,
             processed_extracted_data$`FS conifers (thousand ha)`,processed_extracted_data$`FS broadleaves (thousand ha)`),
  year=c(woodland_by_year$year_ending_March_31st)) # creates a dataframe amenable to the upcoming visualisation

public_trees$year<-as.numeric(public_trees$year) # ensures is numeric so it can be amenable to analysis*
public_trees$woodland<-as.numeric(public_trees$woodland) # *

mapping<-aes(x=year,y=woodland,colour=tree_type) # creates the mapping for the visualisation
fig_path<-here("figs") # creates the necessary path for saving the figure

## ADVANCED PLOT:

InteractivePlot<-public_trees %>%
  ggplot(mapping=mapping)+
  geom_point(aes(text = paste("Woodland Area:", woodland, "(K ha)",
                               "<br>Year:", year, "<br>Type & Region:", tree_type), shape=tree_type))+
  geom_smooth(aes(text=NULL),method=lm, se=NULL)+
  labs(title="Graph of Public Conifer and Broadleaf Woodland Area Within the United Kingdom",
       x="Year (commencing from March 31st)",
       y="Woodland area (in thousand hectares)",
       colour="Woodland Type and Region",
       shape=NULL)+
  scale_colour_manual(values=c(`FE conifers, England`="#FF0000",`FE broadleaves, England`="#FF0000",
                               `NRW conifers, Wales`="#00CD00",`NRW broadleaves, Wales`="#00CD00",
                               `FLS conifers, Scotland`="#0000CD",`FLS broadleaves, Scotland`="#0000CD",
                               `FS conifers, NI`="#FFA900",`FS broadleaves, NI`="#FFA900"))+
  scale_shape_manual(values=c(0,15,1,16,2,17,5,18))+
  scale_x_continuous(breaks=seq(1998,2024,4))+
  scale_y_continuous(breaks=seq(0,500,50))+
  theme(panel.border=element_rect(colour="darkgreen",fill=NA,linewidth=2),
        axis.line=element_line(linewidth=2,colour="black"),
        panel.background=element_rect(fill="white"),
        plot.title=element_text(face="bold"),
        text=element_text(family="sans"))

# NOTE - caption does not currently work, nor does the brown graph lines (border does)

InteractivePlot<-ggplotly(InteractivePlot, tooltip="text") # creates extremely basic interactive graph

InteractivePlot

# NOTE - play around with further ways to modify the interactive graph, i.e. moving up in yearly increments of 1 > decimals, therefore also jumping woodland amounts to be per year

rm(list=setdiff(ls(), c("processed_extracted_data", "woodland_by_year", "public_trees", "BasicPlot", "InteractivePlot"))) # removes unnecessary variables to clean environment
