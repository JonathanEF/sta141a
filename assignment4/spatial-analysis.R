# Assignment 4

# packages used
install.packages("devtools")
install.package("ggplot2")
install.packages("stringr")
install.packages("psych")
devtools::install_github("dkahle/ggmap", ref = "tidyup")

# import data
census = read.csv("~/Desktop/School/sta141a/data/2010_census_data/DEC_10_SF1_SF1DP1_with_ann.csv", stringsAsFactors = FALSE)
apartments = readRDS("~/Desktop/School/sta141a/data/cl_apartments.rds")

# overview apartments data
head(census)
names(census)
str(census)

# overview census data
head(census)
names(census)
str(census)
head(census$GEO.display.label)
census$GEO.display.label

# clean craiglist data

# update apartment prices
apartments$price[apartments$price == 34083742] = 3408
apartments$price[apartments$price == 9951095] = 995

# remove below 200 because offering of services, house cleaning, short-term, single room, unrelated postings
apartments = subset(apartments, price >= 200) # this includes updated expensive price, and removed low prices

# remove duplicate title
apartments = apartments[!duplicated(apartments$title), ]
# remove duplicate text
apartments = apartments[!duplicated(apartments$text), ]

# Remove low sq ft >= 80 and sqft < 199999
sort(table(apartments$sqft))
apartments = subset(apartments, sqft >= 80 & sqft < 199999)

# remove non-California listings
apartments = subset(apartments, state == "CA")

# remove apartments with 0 bathroom
apartments = subset(apartments, bathrooms > 0)

# remove apartments with 6 bedrooms, these are houses
apartments = subset(apartments, bedrooms < 6) 

# QUESTION 1

# Use this Color-blind safe palette for all colored visualization
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
scale_colour_manual(values=cbPalette)

# Check stamen map of Davis
bbox_davis = c(-121.800081,38.524282,-121.693036,38.57378)
m_davis = get_stamenmap(bbox_davis, zoom = 15, , maptype = "toner-lite")
ggmap(m_davis)

# Subset Data so that apartments are only Davis apartments
davis_apartments = subset(apartments, city == "Davis")
nrow(davis_apartments) # 39; some apartments have same coordinates

# Part 1 - Is there a relationship between apartments in Davis' location and price?

# Get summary of price to determine breaks for cut function
summary(davis_apartments$price)

# Slice vectors using cut to get a better price range for mapping
davis_apartments$pricerange = cut(davis_apartments$price, breaks = c(0,1407,1650, 1839, 2700), labels = c("0-1407", "1408-1650", "1651-1839", "1840 +"))
as.factor(davis_apartments$pricerange)

# Create stamen map of Davis apartments by Price
ggmap(m_davis) + 
  geom_point(aes(longitude, latitude, color = pricerange), davis_apartments, size = 7.0) + 
  scale_fill_manual(values = cbPalette) +
  scale_color_discrete(name = "Price Range ($)", labels = c("0-1407", "1408-1650", "1651-1839", "1840+")) +
  labs(title = "Stamen Map of Davis Apartments by Price", x = "Longitude", y ="Latitude", fill = "Price Range ($)")

# Part 2 - Are apartments in specific areas of Davis larger in size?

# Get summary of sizes to determine breaks for cut function
summary(davis_apartments$sqft)

# Slice vectors using cut to get a better size range for mapping
davis_apartments$sizerange = cut(davis_apartments$sqft, breaks = c(0,675,800,912,1350), labels = c("0-675", "676-800", "801-912", "912 +"))
as.factor(davis_apartments$sizerange)

# Create stamen map of Davis apartments by Size
ggmap(m_davis) + 
  geom_point(aes(longitude, latitude, color = sizerange), size = 7, davis_apartments) + 
  scale_fill_manual(values = cbPalette) +
  scale_color_discrete(name = "Size Range (sqft)", labels = c("0-675", "676-800", "801-912", "912 +")) +
  labs(title = "Stamen Map of Davis Apartments by Size", x = "Longitude", y ="Latitude")

# Part 3 - Are apartments in specific areas of Davis more pet friendly?
ggmap(m_davis) + 
  geom_point(aes(longitude, latitude, shape = pets), size = 4, davis_apartments) + 
  scale_fill_manual(values = cbPalette) +
  labs(title = "Stamen Map of Davis Apartments by Pet Policy", x = "Longitude", y ="Latitude", shape = "Pet Policy")

# Check how many observations there are for each pet policy in Davis Apartments
table(davis_apartments$pets)

# QUESTION 2

# Subset Data so that apartments are only Southern Half of San Francisco Bay Area
s_sf_bay_apartments = subset(apartments, county == "San Francisco" | county == "San Mateo" | county == "Santa Clara" | county == "Alameda" | county == "Contra Costa")

# Create stamen map for southern San Francisco
bbox_sf = c(-122.7123, 37.1137, -121.5685, 38.0521)
m_sf = get_stamenmap(bbox_sf, zoom = 10, , maptype = "toner-lite")
ggmap(m_sf)

# Part 1 - Is there a relationship between apartments in S SF location and price?

# Get summary of price to determine breaks for cut function
summary(s_sf_bay_apartments$price) 

# Slice vectors using cut to get a better price range for mapping
s_sf_bay_apartments$pricerange = cut(s_sf_bay_apartments$price, breaks = c(199,2300,2795, 3495, 17700), labels = c("$200-2300", "$2301-2795", "$2696-3495", "$3495 +"))
as.factor(s_sf_bay_apartments$pricerange)

# Create stamen map of Davis apartments by Price
ggmap(m_sf) + 
  geom_density2d(aes(longitude, latitude, color = county), alpha = 1.0 , bins = 6, s_sf_bay_apartments) + 
  scale_fill_manual(values = cbPalette) +
  facet_wrap(~pricerange) +
  scale_color_discrete(name = "County") +
  labs(title = "Stamen Map of Southern SF Apartments by Price", x = "Longitude", y ="Latitude", fill = "County")

# Part 2 - Are apartments in specific areas of SF larger in size?

# Get summary of sizes to determine breaks for cut function
summary(s_sf_bay_apartments$sqft)

# Slice vectors using cut to get a better size range for mapping
s_sf_bay_apartments$sizerange = cut(s_sf_bay_apartments$sqft, breaks = c(0,675,800,912,1350), labels = c("0-675 (sqft)", "676-800 (sqft)", "801-912 (sqft)", "912 + (sqft)"))
as.factor(s_sf_bay_apartments$sizerange)

# remove na is size range
s_sf_bay_apartments_no_na_size = s_sf_bay_apartments[!is.na(s_sf_bay_apartments$sizerange), ]

# Create stamen map of S SF apartments by Size
ggmap(m_sf) + 
  geom_density2d(aes(longitude, latitude, color = county), bins = 5, s_sf_bay_apartments_no_na_size) + 
  scale_fill_manual(values = cbPalette) +
  facet_wrap(~sizerange) +
  scale_color_discrete(name = "County") +
  labs(title = "Stamen Map Southern SF Apartments by Size", x = "Longitude", y ="Latitude")

# remove na in pet policy
s_sf_bay_apartments_no_na_pets = s_sf_bay_apartments[!is.na(s_sf_bay_apartments$pets), ]

# Part 3 - Are apartments in specific areas of Davis more pet friendly?

ggmap(m_sf) + 
  geom_point(aes(longitude, latitude, color = county), s_sf_bay_apartments_no_na_pets) + 
  scale_fill_manual(values = cbPalette) +
  facet_wrap(~pets) +
  labs(title = "Stamen Map of Southern SF Apartments by Pet Policy", x = "Longitude", y ="Latitude")

# QUESTION 3

# remove city, California and CDP, California
census$GEO.display.label = str_remove(census$GEO.display.label, " CDP, California")
census$GEO.display.label = str_remove(census$GEO.display.label, " city, California")
census$GEO.display.label = str_remove(census$GEO.display.label, ", California")
census$GEO.display.label = str_remove(census$GEO.display.label, "CDP ")

# fix names of census
names(census) = lapply(census[1, ], as.character)
census = census[-1, ]

# Merge craigslist and census
apartments_and_census = merge(apartments, census, by.x = "city", by.y = "Geography")

# check the that the merge did as expected
nrow(apartments_and_census) 
names(apartments_and_census)
View(apartments_and_census)

# Which places in the southern San Francisco Bay Area have the oldest populations? How does this relate to the rental market, if at all?
s_sf_bay_apartments_merged = subset(apartments_and_census, county == "San Francisco" | county == "San Mateo" | county == "Santa Clara" | county == "Alameda" | county == "Contra Costa")

# create elderly proportion range
s_sf_bay_apartments_merged$elderly_prop_cut = cut(as.numeric(s_sf_bay_apartments_merged$`Percent; SEX AND AGE - Total population - 65 years and over`), breaks = c(5,10,15,20,25,30), labels = c("5 - 10 %", "10 - 15 %", "15 - 20 %", "20 - 25 %", "25 - 30 %"))
as.factor(s_sf_bay_apartments_merged$elderly_prop_cut)

# Create stamen map of southern San Francisco grouped by elderly proportion
ggmap(m_sf) + 
  geom_point(aes(x = longitude, y = latitude, color = county), data = s_sf_bay_apartments_merged) + 
  scale_fill_manual(values=cbPalette) +
  facet_wrap(~elderly_prop_cut) +
  labs(title = "Stamen Map of S. San Francisco Apartments by Elderly Proportion", x = "Longitude", y ="Latitude", color = "County")

# Get summary of prices to determine breaks for cut function
summary(s_sf_bay_apartments_merged$price)

# Slice vectors using cut to get a better size range for mapping
s_sf_bay_apartments_merged$pricerange = cut(s_sf_bay_apartments_merged$price, breaks = c(199,2308,2795,3495,17700), labels = c("$200-2308","$2309-2795","$2796-3495", "$3496-17700"))
as.factor(s_sf_bay_apartments_merged$pricerange)

# Create stamen map of southern San Francisco apartments: Relating Elderly Proportion to Rental Price
ggmap(m_sf) + 
  geom_point(aes(x = longitude, y = latitude, color = elderly_prop_cut), data = s_sf_bay_apartments_merged) + 
  scale_fill_manual(values=cbPalette) +
  facet_wrap(~pricerange) +
  labs(title = "Elderly Proportion Map of SF Apartments grouped by Rental Price", x = "Longitude", y ="Latitude", color = "Proportion (%)")

# References
# Rename legend for plots : < https://stackoverflow.com/questions/33398033/change-ggplot-legend-title >
# Using Cut functon : < https://rpubs.com/pierrelafortune/cutdocumentation >
# ggmap :  D. Kahle and H. Wickham. ggmap: Spatial Visualization with ggplot2. The R Journal, 5(1), 144-161. URL
# http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf
# Use first row as column name : <  https://stackoverflow.com/questions/32054368/use-first-row-data-as-column-names-in-r?fbclid=IwAR3kK-XH20rb2k-AzD1n2gMqJxDUoIwgZ0mvJvS_ZWwbjyZRNJ5frjSX-l4 >
# Worked in Group with: Kelly Chan, Jiemin Huang, Fenglan Jiang, Rohan Malhotra
