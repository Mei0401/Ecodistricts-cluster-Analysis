library(tidyverse)
library(rgdal)
# src: http://www.gastonsanchez.com/visually-enforced/how-to/2012/06/17/PCA-in-R/

#disable scientific notation
options(scipen=999)

# importing data 
data <- readOGR("C:\\Users\\Mei\\OneDrive - University of Toronto\\ggr376\\a3\\ecodistricts.geojson")
raw_data <- as.data.frame(data)


# PCA with function prcomp
pca1 = prcomp(raw_data, scale. = TRUE)

# eigenvalues
pca1$sdev^2

# a table of loadings (or correlations between variables and PCs)
pca1$rotation

# a table with the scores or Principal Components (PCs)
pca1$x

summary(pca1)

cor_mat <- cor(raw_data )
corrplot::corrplot(cor_mat, cl.pos = "b", tl.pos = "d")

