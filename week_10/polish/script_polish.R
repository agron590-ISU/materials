
## ---- echo=FALSE---------------------------------------------------------
ggplot(both, aes(x=year, y=acres, group=crop, color=crop))+
  geom_point()+
  geom_smooth()

## ------------------------------------------------------------------------
ggplot(both, aes(x=year, y=acres, group=crop, color=crop, shape=crop))+
  geom_point(size=3)+
  geom_smooth()

## ------------------------------------------------------------------------
ggplot(both, aes(x=year, y=acres, group=crop, color=crop, shape=crop))+
  geom_point(size=3, alpha = .6)+
  geom_smooth()+
  ggtitle("Acres of small grains and soybeans in Iowa")

## ------------------------------------------------------------------------
theme_set(theme_bw())
ggplot(both, aes(x=year, y=acres, group=crop, color=crop, shape=crop))+
  geom_point(size=3, alpha = .6)+
  geom_smooth()+
  ggtitle("Acres of small grains and soybeans in Iowa")

## ------------------------------------------------------------------------
library(scales)
theme_set(theme_bw())
ggplot(both, aes(x=year, y=acres, group=crop, color=crop, shape=crop))+
  geom_point(size=3, alpha = .6)+
  geom_smooth()+
  ggtitle("Acres of small grains and soybeans in Iowa")+
  scale_y_continuous(labels = comma)

## ---- eval=FALSE---------------------------------------------------------
## theme_set(theme_bw())
## ggplot(both, aes(x=year, y=acres, group=crop, color=crop, shape=crop))+
##   geom_point(size=3, alpha = .6)+
##   geom_smooth()+
##   ggtitle("Acres of small grains and soybeans in Iowa")+
##   scale_y_continuous(labels = comma)+
## labs(x = "Year",y = "Acres Planted") +
##     theme(#panel.grid.major = element_blank(),
##           panel.grid.minor = element_blank(),
##           #panel.background = element_blank(),
##           axis.line = element_line(),
##           legend.position=c(.27,.84), legend.title=element_blank(),
## 		      legend.text = element_text(size=20),
## 		      legend.key.size=unit(1, "cm"),
## 		      axis.title.x = element_text(size=22,vjust=-0.5),
##           axis.title.y = element_text(size=22,angle=90),
##           axis.text.x = element_text(colour="black", size=20),
##           axis.text.y = element_text(colour="black", size=20))

## ---- echo=FALSE---------------------------------------------------------
theme_set(theme_bw())
ggplot(both, aes(x=year, y=acres, group=crop, color=crop, shape=crop))+
  geom_point(size=3, alpha = .6)+
  geom_smooth()+
  ggtitle("Acres of small grains and soybeans in Iowa")+
  scale_y_continuous(labels = comma)+
labs(x = "Year",y = "Acres Planted") + 
    theme(#panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          #panel.background = element_blank(),
          axis.line = element_line(),
          legend.position=c(.27,.84), legend.title=element_blank(),
		      legend.text = element_text(size=20),legend.key.size=unit(1, "cm"),
		      axis.title.x = element_text(size=22,vjust=-0.5),
          axis.title.y = element_text(size=22,angle=90),
          axis.text.x = element_text(colour="black", size=20),
          axis.text.y = element_text(colour="black", size=20)) 

## ------------------------------------------------------------------------
my_theme<-theme_bw()+
  theme(#panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          #panel.background = element_blank(),
          axis.line = element_line(),
          legend.position=c(.27,.84), legend.title=element_blank(),
		      legend.text = element_text(size=20),legend.key.size=unit(1, "cm"),
		      plot.title = element_text(size = 22, face = "bold"),
		      axis.title.x = element_text(size=22,vjust=-0.5),
          axis.title.y = element_text(size=22,angle=90),
          axis.text.x = element_text(colour="black", size=20),
          axis.text.y = element_text(colour="black", size=20)) 

## ------------------------------------------------------------------------
theme_set(my_theme)
ggplot(both, aes(x=year, y=acres, group=crop, color=crop, shape=crop))+
  geom_point(size=3, alpha = .6)+
  geom_smooth()+
  ggtitle("Acres of small grains and soybeans in Iowa")+
  scale_y_continuous(labels = comma)+
labs(x = "Year",y = "Acres Planted")

## ------------------------------------------------------------------------
theme_set(my_theme)
ggplot(both, aes(x=year, y=acres, group=crop, color=crop, shape=crop))+
  geom_point(size=3, alpha = .6)+
  geom_smooth()+
  ggtitle("Acres of small grains and soybeans in Iowa")+
  scale_y_continuous(labels = comma)+
labs(x = "Year",y = "Acres Planted")+
  scale_color_discrete(name="Crop",
                         breaks=c("smlgrains", "soybeans"),
                         labels=c("Small Grains", "Soybeans"))+
  scale_shape_discrete(name="Crop",
                         breaks=c("smlgrains", "soybeans"),
                         labels=c("Small Grains", "Soybeans"))

## ---- eval=FALSE---------------------------------------------------------
## theme_set(my_theme)
## ggplot(both, aes(x=year, y=acres, group=crop, color=crop, shape=crop))+
##   geom_point(size=3, alpha = .6)+
##   geom_smooth()+
##   ggtitle("Acres of small grains and soybeans in Iowa")+
##   scale_y_continuous(labels = comma)+
## labs(x = "Year",y = "Acres Planted")+
##   scale_color_discrete(name="Crop",
##                          breaks=c("smlgrains", "soybeans"),
##                          labels=c("Small Grains", "Soybeans"))+
##   scale_shape_discrete(name="Crop",
##                          breaks=c("smlgrains", "soybeans"),
##                          labels=c("Small Grains", "Soybeans"))

## ---- echo=FALSE---------------------------------------------------------
theme_set(my_theme)
ggplot(both, aes(x=year, y=acres, group=crop, color=crop, shape=crop))+
  geom_point(size=3, alpha = .6)+
  geom_smooth()+
  ggtitle("Acres of small grains and soybeans in Iowa")+
  scale_y_continuous(labels = comma)+
labs(x = "Year",y = "Acres Planted")+
  scale_color_discrete(name="Crop",
                         breaks=c("smlgrains", "soybeans"),
                         labels=c("Small Grains", "Soybeans"))+
  scale_shape_discrete(name="Crop",
                         breaks=c("smlgrains", "soybeans"),
                         labels=c("Small Grains", "Soybeans"))

## ---- echo=FALSE---------------------------------------------------------
theme_set(my_theme)
ggplot(both, aes(x=year, y=acres, group=crop, color=crop, shape=crop))+
  geom_point(size=3, alpha = .6)+
  geom_smooth()+
  ggtitle("Acres of small grains and soybeans in Iowa")+
  scale_y_continuous(labels = comma)+
labs(x = "Year",y = "Acres Planted")+
  scale_color_discrete(name="Crop",
                         breaks=c("smlgrains", "soybeans"),
                         labels=c("Small Grains", "Soybeans"))+
  scale_shape_discrete(name="Crop",
                         breaks=c("smlgrains", "soybeans"),
                         labels=c("Small Grains", "Soybeans"))

## ---- eval=FALSE---------------------------------------------------------
## ggsave("changes.pdf", plot=cropfig)

## ---- eval=FALSE---------------------------------------------------------
## pdf(file="changes.pdf", height=600, width=600)
## cropfig
## dev.off()

## ---- echo=FALSE, message=FALSE, warning=FALSE, fig.width=7, fig.height=1.5----
library(RColorBrewer)
library(gridExtra)
new_theme_empty <- theme_bw()
new_theme_empty$line <- element_blank()
new_theme_empty$rect <- element_blank()
new_theme_empty$strip.text <- element_blank()
new_theme_empty$axis.text <- element_blank()
new_theme_empty$plot.title <- element_blank()
new_theme_empty$axis.title <- element_blank()
new_theme_empty$plot.margin <- structure(c(0, 0, -1, -1), unit = "lines", valid.unit = 3L, class = "unit")
data <- data.frame(x = 1:7, 
                   blues = brewer.pal(7, "Blues"), 
                   set1 = brewer.pal(7, "Set1"), 
                   diverge = brewer.pal(7,"RdBu"))

qplot(xmin = x-.5, xmax = x+.5, ymin = 0, ymax = 1, data = data, geom = "rect", color = I("black"), fill = set1) + 
    scale_fill_identity() + 
    ylab("") + 
    xlab("") + 
    theme(axis.text = element_blank(), 
          axis.ticks = element_blank(), 
          rect = element_blank()) + 
    coord_fixed(ratio = 1) + 
    new_theme_empty

## ---- echo=FALSE, message=FALSE, warning=FALSE, fig.width=7, fig.height=1.5----
qplot(xmin = x-.5, xmax = x+.5, ymin = 0, ymax = 1, data = data, geom = "rect", color = I("black"), fill = blues) + 
    scale_fill_identity() + 
    ylab("") + 
    xlab("") + 
    theme(axis.text = element_blank(), 
          axis.ticks = element_blank(), 
          rect = element_blank()) + 
    coord_fixed(ratio = 1) + 
    new_theme_empty

## ---- echo=FALSE, message=FALSE, warning=FALSE, fig.width=7, fig.height=1.5----
qplot(xmin = x-.5, xmax = x+.5, ymin = 0, ymax = 1, data = data, geom = "rect", color = I("black"), fill = diverge) + 
    scale_fill_identity() + 
    ylab("") + 
    xlab("") + 
    theme(axis.text = element_blank(), 
          axis.ticks = element_blank(), 
          rect = element_blank()) + 
    coord_fixed(ratio = 1) + 
    new_theme_empty

## ---- echo=FALSE, fig.width=7, fig.height=6------------------------------
display.brewer.all()

## ---- eval=FALSE---------------------------------------------------------
## ggplot(both, aes(x=year, y=acres, group=crop, color=crop, shape=crop))+
##   geom_point(size=3, alpha = .6)+
##   geom_smooth()+
##   ggtitle("Acres of small grains and soybeans in Iowa")+
##   scale_y_continuous(labels = comma)+
## labs(x = "Year",y = "Acres Planted")+
##   scale_color_brewer(name="Crop",
##                          breaks=c("smlgrains", "soybeans"),
##                          labels=c("Small Grains", "Soybeans"), palette="Set1")+
##   scale_shape_discrete(name="Crop",
##                          breaks=c("smlgrains", "soybeans"),
##                          labels=c("Small Grains", "Soybeans"))

## ---- echo=FALSE---------------------------------------------------------
ggplot(both, aes(x=year, y=acres, group=crop, color=crop, shape=crop))+
  geom_point(size=3, alpha = .6)+
  geom_smooth()+
  ggtitle("Acres of small grains and soybeans in Iowa")+
  scale_y_continuous(labels = comma)+
labs(x = "Year",y = "Acres Planted")+
  scale_color_brewer(name="Crop",
                         breaks=c("smlgrains", "soybeans"),
                         labels=c("Small Grains", "Soybeans"), palette="Set1")+
  scale_shape_discrete(name="Crop",
                         breaks=c("smlgrains", "soybeans"),
                         labels=c("Small Grains", "Soybeans"))

