# While the previous basic plot was initially taken from a Data Science Project completed during my Master's studies, the following code demonstrates a more recent attempt at configuring
# and advancing upon my previous abilities with data management and visualisation.

## NECESSARY PACKAGES:

library(here)
library(tidyverse)
library(cowplot)
library(magick)
library(plotly)
library(htmlwidgets)

# DATA PREPARATION & REORGANISATION

rm(list=setdiff(ls(), c("processed_extracted_data", "woodland_by_year", "BasicPlot"))) # removes unnecessary variables to clean environment

# mutual code

mapping<-aes(x=year,y=woodland,colour=tree_type) # creates the mapping for the visualisation
fig_path<-here("figs") # creates the necessary path for saving the figure






# PUBLIC DATA 

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
public_trees$tree_type<-factor(public_trees$tree_type, levels=c("FE conifers, England", "FE broadleaves, England", 
                                                                  "NRW conifers, Wales", "NRW broadleaves, Wales",
                                                                  "FLS conifers, Scotland", "FLS broadleaves, Scotland",
                                                                  "FS conifers, NI", "FS broadleaves, NI"))
## BASIC INTERACTIVE PLOT:

InteractivePlot_public<-public_trees %>%
  ggplot(mapping=mapping)+
  geom_point(aes(text = paste("Woodland Area:", woodland, "(K ha)",
                               "<br>Year:", year, "<br>Type & Region:", tree_type), shape=tree_type))+
  labs(title="The Growth of Coniferous and Deciduous (Broadleaf) Public Woodland Area in the United Kingdom",
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
  scale_y_continuous(breaks=seq(0,1000,50))+
  theme(panel.border=element_rect(colour="darkgreen",fill=NA,linewidth=2),
        panel.grid.major=element_line(colour="lightgreen",linewidth=0.7),
        axis.line=element_line(linewidth=2,colour="darkgreen"),
        panel.background=element_rect(fill="white"),
        plot.title=element_text(face="bold"),
        text=element_text(family="sans"))

# Unfortunately, the logo cannot be added to an interactive plot as this feature has not yet been implemented into plotly

# makes interactive

InteractivePlot_public<-ggplotly(InteractivePlot_public, tooltip="text",width=900,height=600) %>%
  layout(
    margin = list(t = 50, r = 50, b = 50, l = 50)
    )

InteractivePlot_public

# saves

filename<-paste("The Growth of Coniferous & Deciduous (Broadleaf) Public Woodland Area in the UK from 1998 to 2024.html",sep="")
full_file_path<-file.path(fig_path,filename)
saveWidget(InteractivePlot_public, file=full_file_path)








# PRIVATE DATA

private_trees<-data.frame(
  tree_type=c(rep("Private sector conifers, England",27),rep("Private sector broadleaves, England",27),rep("Private sector conifers, Wales",27),rep("Private sector broadleaves, Wales",27),
              rep("Private sector conifers, Scotland",27),rep("Private sector broadleaves, Scotland",27),rep("Private sector conifers, NI",27),rep("Private sector broadleaves, NI",27)),
  woodland=c(processed_extracted_data$`Private sector conifers (thousand ha)`,processed_extracted_data$`Private sector broadleaves (thousand ha)`,
             processed_extracted_data$`Private sector conifers (thousand ha).1`,processed_extracted_data$`Private sector broadleaves (thousand ha).1`,
             processed_extracted_data$`Private sector conifers (thousand ha).2`,processed_extracted_data$`Private sector broadleaves (thousand ha).2`,
             processed_extracted_data$`Private sector conifers (thousand ha).3`,processed_extracted_data$`Private sector broadleaves (thousand ha).3`),
  year=c(woodland_by_year$year_ending_March_31st)) # creates a dataframe amenable to the upcoming visualisation

private_trees$year<-as.numeric(private_trees$year) # ensures is numeric so it can be amenable to analysis*
private_trees$woodland<-as.numeric(private_trees$woodland) # *
private_trees$tree_type<-factor(private_trees$tree_type, levels=c("Private sector conifers, England", "Private sector broadleaves, England", 
                                                                  "Private sector conifers, Wales", "Private sector broadleaves, Wales",
                                                                  "Private sector conifers, Scotland", "Private sector broadleaves, Scotland",
                                                                  "Private sector conifers, NI", "Private sector broadleaves, NI"))

## BASIC INTERACTIVE PLOT:

InteractivePlot_private<-private_trees %>%
  ggplot(mapping=mapping)+
  geom_point(aes(text = paste("Woodland Area:", woodland, "(K ha)",
                              "<br>Year:", year, "<br>Type & Region:", tree_type), shape=tree_type))+
  labs(title="The Growth of Coniferous and Deciduous (Broadleaf) Private Woodland Area in the United Kingdom",
       x="Year (commencing from March 31st)",
       y="Woodland area (in thousand hectares)",
       colour="Woodland Type and Region",
       shape=NULL)+
  scale_colour_manual(values=c(`Private sector conifers, England`="#FF0000",`Private sector broadleaves, England`="#FF0000",
                               `Private sector conifers, Wales`="#00CD00",`Private sector broadleaves, Wales`="#00CD00",
                               `Private sector conifers, Scotland`="#0000CD",`Private sector broadleaves, Scotland`="#0000CD",
                               `Private sector conifers, NI`="#FFA900",`Private sector broadleaves, NI`="#FFA900"))+
  scale_shape_manual(values=c(0,15,1,16,2,17,5,18))+
  scale_x_continuous(breaks=seq(1998,2024,4))+
  scale_y_continuous(breaks=seq(0,1000,100))+
  theme(panel.border=element_rect(colour="darkgreen",fill=NA,linewidth=2),
        panel.grid.major=element_line(colour="lightgreen",linewidth=0.7),
        axis.line=element_line(linewidth=2,colour="darkgreen"),
        panel.background=element_rect(fill="white"),
        plot.title=element_text(face="bold"),
        text=element_text(family="sans"))

# makes interactive

InteractivePlot_private<-ggplotly(InteractivePlot_private, tooltip="text",width=900,height=600) %>%
  layout(
    margin = list(t = 50, r = 50, b = 50, l = 50)
  )

InteractivePlot_private

# saves

fig_path<-here("figs") # creates the necessary path for saving the figure
filename<-paste("The Growth of Coniferous & Deciduous (Broadleaf) Private Woodland Area in the UK from 1998 to 2024.html",sep="")
full_file_path<-file.path(fig_path,filename)
saveWidget(InteractivePlot_private, file=full_file_path)




# you need to make both graph plots on the same html scale so that they can be portrayed side by side and not be misleading :)