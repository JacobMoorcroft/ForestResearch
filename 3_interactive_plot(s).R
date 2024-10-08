# While the previous basic plot was initially taken from a Data Science Project completed during my Master's studies, the following code demonstrates a more recent attempt at configuring
# and advancing upon my previous abilities with data management and visualisation. Also, now that we've already gone through the process of showing a more
# general composition of woodland development from 1998-2024, it could be curious to investigate how this could differ based on the type of woodland, i.e.
# whether the change in coniferous or deciduous trees have been different!!

# DATA EXTRACTION: Woodland Tree Types on PUBLIC land ...

public_trees<-data.frame(
  tree_type=c(rep("FE conifers, England",27),rep("FE broadleaves, England",27),rep("NRW conifers, Wales",27),rep("NRW broadleaves, Wales",27),
              rep("FLS conifers, Scotland",27),rep("FLS broadleaves, Scotland",27),rep("FS conifers, NI",27),rep("FS broadleaves, NI",27)),
  woodland=c(processed_extracted_data$`FE conifers (thousand ha)`,processed_extracted_data$`FE broadleaves (thousand ha)`,
             processed_extracted_data$`NRW conifers (thousand ha)`,processed_extracted_data$`NRW broadleaves (thousand ha)`,
             processed_extracted_data$`FLS conifers (thousand ha)`,processed_extracted_data$`FLS broadleaves (thousand ha)`,
             processed_extracted_data$`FS conifers (thousand ha)`,processed_extracted_data$`FS broadleaves (thousand ha)`),
  year=c(`year_ending_March_31st`)) # creates a dataframe amenable to the upcoming visualisation

str(public_trees) # all variables are the correct type, however ...
public_trees$tree_type<-factor(public_trees$tree_type, levels=c("FE conifers, England", "FE broadleaves, England", 
                                                                  "NRW conifers, Wales", "NRW broadleaves, Wales",
                                                                  "FLS conifers, Scotland", "FLS broadleaves, Scotland",
                                                                  "FS conifers, NI", "FS broadleaves, NI")) # this code facilitates consistent ordering of variables in visualisation legends

mapping<-aes(x=year,y=woodland,colour=tree_type) # creates the mapping for the visualisations

## BASIC INTERACTIVE PLOT 1:

# Creates a plot mapping the amount of public woodland area development from 1998-2024, as divisable by country and classification of tree-type

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

# As proper preparations and modifications have already been made, the plot can now instantly be made interactive

InteractivePlot_public<-ggplotly(InteractivePlot_public, tooltip="text",width=900,height=600) %>%
  layout(margin = list(t = 50, r = 50, b = 50, l = 50))

## Visualisation of the Growth of Coniferous and Deciduous Public Woodland Area within the United Kingdom, from 1998 to 2024

InteractivePlot_public

# Saves visualisation as an interactive HTML

filename<-paste("The Growth of Coniferous & Deciduous (Broadleaf) Public Woodland Area in the UK from 1998 to 2024.html",sep="")
full_file_path<-file.path(fig_path,filename)
saveWidget(InteractivePlot_public, file=full_file_path)

# DATA EXTRACTION: Woodland Tree Types on PRIVATE land ...

private_trees<-data.frame(
  tree_type=c(rep("Private sector conifers, England",27),rep("Private sector broadleaves, England",27),rep("Private sector conifers, Wales",27),rep("Private sector broadleaves, Wales",27),
              rep("Private sector conifers, Scotland",27),rep("Private sector broadleaves, Scotland",27),rep("Private sector conifers, NI",27),rep("Private sector broadleaves, NI",27)),
  woodland=c(processed_extracted_data$`Private sector conifers (thousand ha)`,processed_extracted_data$`Private sector broadleaves (thousand ha)`,
             processed_extracted_data$`Private sector conifers (thousand ha).1`,processed_extracted_data$`Private sector broadleaves (thousand ha).1`,
             processed_extracted_data$`Private sector conifers (thousand ha).2`,processed_extracted_data$`Private sector broadleaves (thousand ha).2`,
             processed_extracted_data$`Private sector conifers (thousand ha).3`,processed_extracted_data$`Private sector broadleaves (thousand ha).3`),
  year=c(`year_ending_March_31st`)) # creates a dataframe amenable to the upcoming visualisation

str(private_trees) # all variables are the correct type, however ...
private_trees$tree_type<-factor(private_trees$tree_type, levels=c("Private sector conifers, England", "Private sector broadleaves, England", 
                                                                  "Private sector conifers, Wales", "Private sector broadleaves, Wales",
                                                                  "Private sector conifers, Scotland", "Private sector broadleaves, Scotland",
                                                                  "Private sector conifers, NI", "Private sector broadleaves, NI")) # facilitates consistent legend order

## BASIC INTERACTIVE PLOT 2:

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

# As proper preparations and modifications have already been made, the plot can now instantly be made interactive

InteractivePlot_private<-ggplotly(InteractivePlot_private, tooltip="text",width=900,height=600) %>%
  layout(margin = list(t = 50, r = 50, b = 50, l = 50))

## Visualisation of the Growth of Coniferous and Deciduous Private Woodland Area within the United Kingdom, from 1998 to 2024

InteractivePlot_private

# Saves visualisation as an interactive HTML

filename<-paste("The Growth of Coniferous & Deciduous (Broadleaf) Private Woodland Area in the UK from 1998 to 2024.html",sep="")
full_file_path<-file.path(fig_path,filename)
saveWidget(InteractivePlot_private, file=full_file_path)


# Generally, these visualisations tend to indicate that private woodland area has grown at a much more visually noticeable rate than public woodland, even
# after accounting for the differences in initial proportions by creating graphs with relative scales. This could be curious for motivating investigations
# into WHY this is happening (i.e. privatisation of forested areas for production purposes, higher funding for development, etc.) or even whether this 
# difference is statistically significantly different in the first place. Regardless, it was entertaining to play around with the data to show this.

# And just as a final tidbit, there is a simple barplot below which shows all of the data which combines the private and public woodland statistics to show
# a more general trend on the total amount of woodland area as denoted by whether it was coniferous or deciduous, per country, per year from 1998-2024.


# DATA MANIPULATION: Woodland Tree Types on both PUBLIC and PRIVATE land ...

total_trees<-cbind(public_trees,private_trees) # combines all data into one dataframe
names(total_trees)<-make.names(names(total_trees), unique=TRUE) # renders names unique to allow renaming
total_trees<-total_trees%>% 
  rename(private_woodland=`woodland.1`,public_woodland=woodland)%>% # renames variables to facilitate interaction
  mutate(sources=paste(tree_type,`tree_type.1`, sep=" + "))%>% # creates variable to record source of woodland area
  select(-c(1,4,6))%>% # removes now unneccessary variables from the dataframe
  select(c("sources", "year", "public_woodland", "private_woodland")) # reorders dataframe to improve readability
total_trees$total_woodland<-rowSums(total_trees[, c("public_woodland","private_woodland")], na.rm=TRUE) # calculates total woodland areas

head(total_trees) # have a look! :)

# Trend in RECORDED woodland area (i.e. as 1998-2004 NI woodland area was not documented) in the United Kingdom from 1998-2024.

amalgamated_visualisation<-total_trees %>%
  hchart('column', hcaes(x=year,y=total_woodland,group=sources),stacking="normal")%>%
  hc_title(text="Recorded Total Woodland Area of the United Kingdom from 1998-2024")%>%
  hc_subtitle(text="Segmented by tree type (coniferous or deciduous) and country")%>%
  hc_xAxis(title=list(text="Year (commencing from March 31st)"))%>%
  hc_yAxis(title=list(text="Woodland area (in thousand hectares)"))%>%
  hc_caption(text="Northern Ireland only began documenting woodland area as of 2005: see abline")%>%
  hc_annotations(list(shapes=list(list(type = 'path',points = list(list(xAxis = 0, yAxis = 0, x = 2004.5, y = 0),
                                                                   list(xAxis = 0, yAxis = 0, x = 2004.5, y = 3500)),
                                       stroke="black",strokeWidth=1)),draggable=""))

amalgamated_visualisation

filename<-paste("Recorded Total Woodland Area of the United Kingdom from 1998-2024.html",sep="")
full_file_path<-file.path(fig_path,filename)
saveWidget(amalgamated_visualisation, file=full_file_path)