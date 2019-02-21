1
STA141A
Analysis on the Spatial Characteristics of the Rental Market
Jonathan Fernandez
Statistics Department
University of California, Davis
November 2018
In this project, we'll aim to study the various spatial characteristics of the rental market — we’re going to be using spatial and demographic data provided by the US Census Bureau in 2010 and data extracted from the Craigslist website on apartments listings in 2018. The US Census Bureau data contains names that closely match to that of the Craigslist data set and will be used to merge the data set. In later analysis, both Craigslist data and the merged Craigslist-US Census Bureau data will be used for further exploration and inferences.
Overview of the Merged Dataset
Before going further, it is important to explain the changes made to the Craigslist data, because initially the data was messy. After taking the time to understand the data and look at the observations, variables, and values with respect to each variable, there were quite a few modifications that needed to be made. For instance, some prices were extremely high due to an inaccurate extraction of the text (ranges rental prices were interpreted as single prices) and had to updated to their correct values. Some prices were too low to be a sensible apartment listing, and it turned out many of them were offering of services. Furthermore, we need to remove duplicated posts, incorrect size listings, non-California listings, and house listings to name a few transformations.
Craigslist Data
Upon cleaning and transforming the data, we obtain a total number of 12664 observations of apartments listings on Craigslist from September 8, 2018 to a latest update of October 15, 2018 with 20 variables describing features of the apartments like price, size, and location.
Merged Data
After cleaning and merging the two data sets together we left with 12, 076 observations which represent an apartment listing on the Craigslist data set that has a corresponding place name on the US Census Bureau data. There are also 394 variables which are features describing each particular apartment, including location, demographic, and price data to name a few.
1 Exploring Craigslist Posts in Davis
1.1 Is there a relationship between apartments in Davis' location and price?
Although a small city, Davis can be categorized to distinct region: West, North, South, East, Central, and Campus. Finding ideal housing for students has proven to be a challenge over the last years. So we will study the relationship between location and price in order to help students make better housing decisions when the time comes.
2
From this one can see that apartments farther in East Davis and North Davis (i.e.- Farther from campus) are typically more expensive. Surprising at first, one may expect apartments closer to campus be more expensive. However, that is not the case and it seems that the apartments to campus are in the lower price ranges. Nonetheless, upon further investigation, what is not as surprising is that the apartments price above $1840 are listings with 3 bedrooms compared to the other apartments being 1 or 2 bedrooms. So when we consider this as a possible confounding variable, it would make sense why apartments farther away are actually more expensive.
Some other notes to mention are there apartments with same latitude and longitude, which is possible since apartments listings can be part of a complex or adjacent to other complexes. Also, due to the small sample size, this makes it difficult to be certain of inferences made.
2.2 Are apartments in specific areas of Davis larger in size?
In addition to the price, we can study the relationship between the location and size and see if it is what we expect.
3
As we can see, apartments in the smaller size range of 0-675 and 676-800 are in the central and southern region of Davis and closer to campus. This may not surprise many, because as you get closer to the campus, you near down-town Davis and it would seem that having smaller apartments with small space available for housing as you near campus would be more accommodate for the students. With that said, these findings suffer from the same limitations of the prior question – possible confounding variables and a lack of an adequate sample size to make clearer insights and inferences..
1.2 Are apartments in specific areas of Davis more pet friendly?
While price and size are important apartment features for some students and individuals looking for homes in Davis, some seek that the apartments are pet friendly for that special member of their family. So we will now study the pet policies across apartments in Davis.
Here we see that if apartments in Davis are dog friendly then they must be cat friendly. So if an apartment is pet friendly it is either just car friendly or both cat and dog friendly. That said, in general, it seems that the apartments closer to campus are less pet friendly as one can see the square blocks, indicating an apartment that is not allow cats or dogs, are closer to campus. This suggests that if you were to have a pet then you probably should be looking for apartments farther from campus.
Again, the following observations may not be accurate due to the limited number of observations and possible confounders not included in this data such as apartment ownership, since particular apartment managers and ownerships may be more lenient when it comes to pets.
2 Exploring Craigslist Posts in Southern San Francisco
In this section of the analysis, we will explore the same questions we looked at for the Davis apartments, but now we will take a look at posts in the southern San Francisco region of California. We will define this to be the area which consists of the counties of San Francisco, San Mateo, Santa Clara, Alameda, and Contra Costa.
4
Because the data for this portion of the analysis contains for observations, we can be more confident in our insights and inferences. The number of Davis apartments posted on Craigslist was limited, so we were hesitant regarding our confidence and accuracy of the findings we concluded. However, with the increased number of observations, comes new issues, such as over-plotting which will be dealt with.
2.1 Is there a relationship between apartments in southern San Francisco location and price?
Summary Statistics of Rental Prices
Min. 1st Qu. Median Mean 3rd Qu. Max.
200 2300 2795 3041 3495 17700
In this visualization, each plot is a representation of southern San Francisco apartments falling in one of the four price ranges that was created by finding the min, 25th quantile, median, 75th quantile, and max of the rental prices; while each county corresponds to a particular color. From this we can see many of the Contra Costa apartments are in the lower price ranges of $200 to $2300 and $2301 to $2795, because the density plot indicates a large number of apartments within this range. Furthermore, it appears that as we move from cheaper
5
price ranges to more expensive ones that the major counties get denser, indicating that most of the apartments in major counties are going to be in the higher price ranges. For example, consider San Mateo, in the $200 to $2300 range we see that there is a relatively fair number of apartments within this price range, but as we go to $2696 to $3495 or $3495 the number of apartments in that particular county increases.
2.2 Are apartments in specific areas of southern San Francisco larger in size?
Next the relationship of county and size of the apartments will be observed.
Summary Statistics of Apartment Size (square feet)
Min. 1st Qu. Median Mean 3rd Qu. Max.
99.0 680.0 823.0 875.1 1020.0 8933.0
6
From looking at the map, it appears that San Francisco and Santa Clara apartments do not appear to change much from the small apartment groups to the larger apartments groups. However, it does seem that in the counties of Alameda, San Mateo and Contra Costa the larger apartments are located in different areas of the counties compared to the smaller ones. Consider San Mateo, in the 0 to 675 square footage range a lot of the apartments are going to be found in the northern part, but as you increase the size of the apartment post, the apartments tend to be in the lower regions of that county. For Alameda too, as you move south, more apartments that are larger in size become available. Finally, for Contra Costa, as you move in the eastern and southern directions, larger apartments become available. From this patter, we can infer that as you move farther from the bay area, particularly San Francisco, the houses get larger.
3.3 Are apartments in specific areas of southern San Francisco more pet friendly?
Now we will group the apartment posts by the various pet policies, and see if certain areas are more pet friendly for families with pets looking for apartments in southern San Francisco areas.
It turns out that particular regions are not significantly more pet friendly than others. The number of apartments that allow for both cats and dogs is high for all counties. At the same time, there is a large number of apartments that do not allow pets in the apartments for all counties. With that said, someone looking for an apartment, will most likely not be have a restricted selection due to having a pet. There reason why there are so many apartments that allow pets and don’t allow pets is because there are a lot more apartment postings for the southern San Francisco area, which is good for apartment seekers with a pet as a member of their family.
7
3 Exploring Oldest Populations in the Southern Francisco Bay Area
In this final section of analysis, we will look at the oldest areas of the southern Francisco Bay area. Here, we will define old to be individuals over the age of 65. Rather than simply looking at regions that have the most old people, rather, we are interested in seeing which regions have the highest elderly proportion. Looking at the counties with the most elderly individuals would be unfair as we would be comparing regions with a varying number of individuals. However, comparing by proportions considers the fact that one county can have millions of people and other could have thousands, yet we would still be able to compare them.
3.1 Which places in the southern San Francisco Bay Area have the oldest populations?
In the following map, we will study the proportion the elderly individuals make of the counties.
Above we can see that most counties have a typical elderly proportion of 10 – 15%. What is interesting is when one looks at the areas that have a higher elderly proportion, particularly Contra Costa and small parts of Santa Clara. Thus, we can conclude that the oldest county in the San Francisco Bay Area is going to be Contra Costa.
3.2 How does this relate to the rental market, if at all?
We will next see if there is the elderly proportion relates to the rental market by looking at the price ranges across southern San Francisco Bay area and the corresponding proportion of elderly. The price ranges were determined through a summary statistics and can be seen below the graph.
8
Summary Statistics of Rental Price ($)
Min. 1st Qu. Median Mean 3rd Qu. Max.
200 2350 2800 3060 3500 17700
There certainly are elderly individuals living in the more expensive price ranges of $2796 to $3495 and $3496 to $17700, but more appear to be in the lower two price ranges. This would indicate that elderly typically live in apartments that are cheaper. This makes sense, because usually they are no longer working, and therefore, it would be sensible that they would be living in cheaper homes. The middle to high proportions of elderly, 15 to 20 percent and 20 to 25 percent respectively, do appear in the higher price ranges which is interesting. This is indicated by the green and blue dots in the southern areas.
9
Conclusion In this project, we analyzed spatial characteristics of the rental market using spatial and demographic data by studying some insightful questions regarding the apartments listings in Davis and the southern San Francisco Bay area. With the use of maps, we were able to obtain insights that may have been missed had we not used them.
10
Appendix # Assignment 4 # packages used install.packages("devtools") install.package("ggplot2") install.packages("stringr") install.packages("psych") devtools::install_github("dkahle/ggmap", ref = "tidyup") # import data census = read.csv("~/Desktop/School/sta141a/data/2010_census_data/DEC_10_SF1_SF1DP1_with_ann.csv", stringsAsFactors = FALSE) apartments = readRDS("~/Desktop/School/sta141a/data/cl_apartments.rds") # overview apartments data head(census) names(census) str(census) # overview census data head(census) names(census) str(census) head(census$GEO.display.label) census$GEO.display.label
11
# clean craiglist data # update apartment prices apartments$price[apartments$price == 34083742] = 3408 apartments$price[apartments$price == 9951095] = 995 # remove below 200 because offering of services, house cleaning, short-term, single room, unrelated postings apartments = subset(apartments, price >= 200) # this includes updated expensive price, and removed low prices # remove duplicate title apartments = apartments[!duplicated(apartments$title), ] # remove duplicate text apartments = apartments[!duplicated(apartments$text), ] # Remove low sq ft >= 80 and sqft < 199999 sort(table(apartments$sqft)) apartments = subset(apartments, sqft >= 80 & sqft < 199999) # remove non-California listings apartments = subset(apartments, state == "CA") # remove apartments with 0 bathroom apartments = subset(apartments, bathrooms > 0)
12
# remove apartments with 6 bedrooms, these are houses apartments = subset(apartments, bedrooms < 6) # ---------------------------------------------------------------------------------------------------- # QUESTION 1 -------------------------------------------- # Use this Color-blind safe palette for all colored visualization cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7") scale_colour_manual(values=cbPalette) # Check stamen map of Davis bbox_davis = c(-121.800081,38.524282,-121.693036,38.57378) m_davis = get_stamenmap(bbox_davis, zoom = 15, , maptype = "toner-lite") ggmap(m_davis) # Subset Data so that apartments are only Davis apartments davis_apartments = subset(apartments, city == "Davis") nrow(davis_apartments) # 39; some apartments have same coordinates # Part 1 - Is there a relationship between apartments in Davis' location and price? # Get summary of price to determine breaks for cut function summary(davis_apartments$price)
13
# Slice vectors using cut to get a better price range for mapping davis_apartments$pricerange = cut(davis_apartments$price, breaks = c(0,1407,1650, 1839, 2700), labels = c("0-1407", "1408-1650", "1651-1839", "1840 +")) as.factor(davis_apartments$pricerange) # Create stamen map of Davis apartments by Price ggmap(m_davis) + geom_point(aes(longitude, latitude, color = pricerange), davis_apartments, size = 7.0) + scale_fill_manual(values = cbPalette) + scale_color_discrete(name = "Price Range ($)", labels = c("0-1407", "1408-1650", "1651-1839", "1840+")) + labs(title = "Stamen Map of Davis Apartments by Price", x = "Longitude", y ="Latitude", fill = "Price Range ($)") # Part 2 - Are apartments in specific areas of Davis larger in size? # Get summary of sizes to determine breaks for cut function summary(davis_apartments$sqft) # Slice vectors using cut to get a better size range for mapping davis_apartments$sizerange = cut(davis_apartments$sqft, breaks = c(0,675,800,912,1350), labels = c("0-675", "676-800", "801-912", "912 +")) as.factor(davis_apartments$sizerange) # Create stamen map of Davis apartments by Size ggmap(m_davis) + geom_point(aes(longitude, latitude, color = sizerange), size = 7, davis_apartments) +
14
scale_fill_manual(values = cbPalette) + scale_color_discrete(name = "Size Range (sqft)", labels = c("0-675", "676-800", "801-912", "912 +")) + labs(title = "Stamen Map of Davis Apartments by Size", x = "Longitude", y ="Latitude") # Part 3 - Are apartments in specific areas of Davis more pet friendly? ggmap(m_davis) + geom_point(aes(longitude, latitude, shape = pets), size = 4, davis_apartments) + scale_fill_manual(values = cbPalette) + labs(title = "Stamen Map of Davis Apartments by Pet Policy", x = "Longitude", y ="Latitude", shape = "Pet Policy") # Check how many observations there are for each pet policy in Davis Apartments table(davis_apartments$pets) # QUESTION 2 -------------------------------------------- # Subset Data so that apartments are only Southern Half of San Francisco Bay Area s_sf_bay_apartments = subset(apartments, county == "San Francisco" | county == "San Mateo" | county == "Santa Clara" | county == "Alameda" | county == "Contra Costa") # Create stamen map for southern San Francisco bbox_sf = c(-122.7123, 37.1137, -121.5685, 38.0521) m_sf = get_stamenmap(bbox_sf, zoom = 10, , maptype = "toner-lite") ggmap(m_sf) # Part 1 - Is there a relationship between apartments in S SF location and price?
15
# Get summary of price to determine breaks for cut function summary(s_sf_bay_apartments$price) # Slice vectors using cut to get a better price range for mapping s_sf_bay_apartments$pricerange = cut(s_sf_bay_apartments$price, breaks = c(199,2300,2795, 3495, 17700), labels = c("$200-2300", "$2301-2795", "$2696-3495", "$3495 +")) as.factor(s_sf_bay_apartments$pricerange) # Create stamen map of Davis apartments by Price ggmap(m_sf) + geom_density2d(aes(longitude, latitude, color = county), alpha = 1.0 , bins = 6, s_sf_bay_apartments) + scale_fill_manual(values = cbPalette) + facet_wrap(~pricerange) + scale_color_discrete(name = "County") + labs(title = "Stamen Map of Southern SF Apartments by Price", x = "Longitude", y ="Latitude", fill = "County") # Part 2 - Are apartments in specific areas of SF larger in size? # Get summary of sizes to determine breaks for cut function summary(s_sf_bay_apartments$sqft) # Slice vectors using cut to get a better size range for mapping s_sf_bay_apartments$sizerange = cut(s_sf_bay_apartments$sqft, breaks = c(0,675,800,912,1350), labels = c("0-675 (sqft)", "676-800 (sqft)", "801-912 (sqft)", "912 + (sqft)")) as.factor(s_sf_bay_apartments$sizerange)
16
# remove na is size range s_sf_bay_apartments_no_na_size = s_sf_bay_apartments[!is.na(s_sf_bay_apartments$sizerange), ] # Create stamen map of S SF apartments by Size ggmap(m_sf) + geom_density2d(aes(longitude, latitude, color = county), bins = 5, s_sf_bay_apartments_no_na_size) + scale_fill_manual(values = cbPalette) + facet_wrap(~sizerange) + scale_color_discrete(name = "County") + labs(title = "Stamen Map Southern SF Apartments by Size", x = "Longitude", y ="Latitude") # remove na in pet policy s_sf_bay_apartments_no_na_pets = s_sf_bay_apartments[!is.na(s_sf_bay_apartments$pets), ] # Part 3 - Are apartments in specific areas of Davis more pet friendly? ggmap(m_sf) + geom_point(aes(longitude, latitude, color = county), s_sf_bay_apartments_no_na_pets) + scale_fill_manual(values = cbPalette) + facet_wrap(~pets) + labs(title = "Stamen Map of Southern SF Apartments by Pet Policy", x = "Longitude", y ="Latitude") # QUESTION 3 -------------------------------------------- # remove city, California and CDP, California
17
census$GEO.display.label = str_remove(census$GEO.display.label, " CDP, California") census$GEO.display.label = str_remove(census$GEO.display.label, " city, California") census$GEO.display.label = str_remove(census$GEO.display.label, ", California") census$GEO.display.label = str_remove(census$GEO.display.label, "CDP ") # fix names of census names(census) = lapply(census[1, ], as.character) census = census[-1, ] # Merge craigslist and census apartments_and_census = merge(apartments, census, by.x = "city", by.y = "Geography") # check the that the merge did as expected nrow(apartments_and_census) names(apartments_and_census) View(apartments_and_census) # Which places in the southern San Francisco Bay Area have the oldest populations? How does this relate to the rental market, if at all? s_sf_bay_apartments_merged = subset(apartments_and_census, county == "San Francisco" | county == "San Mateo" | county == "Santa Clara" | county == "Alameda" | county == "Contra Costa") # create elderly proportion range s_sf_bay_apartments_merged$elderly_prop_cut = cut(as.numeric(s_sf_bay_apartments_merged$`Percent; SEX AND AGE - Total population - 65 years and over`), breaks = c(5,10,15,20,25,30), labels = c("5 - 10 %", "10 - 15 %", "15 - 20 %", "20 - 25 %", "25 - 30 %")) as.factor(s_sf_bay_apartments_merged$elderly_prop_cut)
18
# Create stamen map of southern San Francisco grouped by elderly proportion ggmap(m_sf) + geom_point(aes(x = longitude, y = latitude, color = county), data = s_sf_bay_apartments_merged) + scale_fill_manual(values=cbPalette) + facet_wrap(~elderly_prop_cut) + labs(title = "Stamen Map of S. San Francisco Apartments by Elderly Proportion", x = "Longitude", y ="Latitude", color = "County") # Get summary of prices to determine breaks for cut function summary(s_sf_bay_apartments_merged$price) # Slice vectors using cut to get a better size range for mapping s_sf_bay_apartments_merged$pricerange = cut(s_sf_bay_apartments_merged$price, breaks = c(199,2308,2795,3495,17700), labels = c("$200-2308","$2309-2795","$2796-3495", "$3496-17700")) as.factor(s_sf_bay_apartments_merged$pricerange) # Create stamen map of southern San Francisco apartments: Relating Elderly Proportion to Rental Price ggmap(m_sf) + geom_point(aes(x = longitude, y = latitude, color = elderly_prop_cut), data = s_sf_bay_apartments_merged) + scale_fill_manual(values=cbPalette) + facet_wrap(~pricerange) + labs(title = "Elderly Proportion Map of SF Apartments grouped by Rental Price", x = "Longitude", y ="Latitude", color = "Proportion (%)") # References
19
# Rename legend for plots : < https://stackoverflow.com/questions/33398033/change-ggplot-legend-title > # Using Cut functon : < https://rpubs.com/pierrelafortune/cutdocumentation > # ggmap : D. Kahle and H. Wickham. ggmap: Spatial Visualization with ggplot2. The R Journal, 5(1), 144-161. URL # http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf # Use first row as column name : < https://stackoverflow.com/questions/32054368/use-first-row-data-as-column-names-in-r?fbclid=IwAR3kK-XH20rb2k-AzD1n2gMqJxDUoIwgZ0mvJvS_ZWwbjyZRNJ5frjSX-l4 > # Worked in Group with: Kelly Chan, Jiemin Huang, Fenglan Jiang, Rohan Malhotra