# Introduction
In this project, we'll aim to study the various spatial characteristics of the rental market — we’re going to be using spatial and demographic data provided by the US Census Bureau in 2010 and data extracted from the Craigslist website on apartments listings in 2018. The US Census Bureau data contains names that closely match to that of the Craigslist data set and will be used to merge the data set. In later analysis, both Craigslist data and the merged Craigslist-US Census Bureau data will be used for further exploration and inferences.

## Overview of the Merged Dataset
Before going further, it is important to explain the changes made to the Craigslist data, because initially the data was messy. After taking the time to understand the data and look at the observations, variables, and values with respect to each variable, there were quite a few modifications that needed to be made. For instance, some prices were extremely high due to an inaccurate extraction of the text (ranges rental prices were interpreted as single prices) and had to updated to their correct values. Some prices were too low to be a sensible apartment listing, and it turned out many of them were offering of services. Furthermore, we need to remove duplicated posts, incorrect size listings, non-California listings, and house listings to name a few transformations.

## Craigslist Data
Upon cleaning and transforming the data, we obtain a total number of 12664 observations of apartments listings on Craigslist from September 8, 2018 to a latest update of October 15, 2018 with 20 variables describing features of the apartments like price, size, and location.

## Merged Data
After cleaning and merging the two data sets together we left with 12, 076 observations which represent an apartment listing on the Craigslist data set that has a corresponding place name on the US Census Bureau data. There are also 394 variables which are features describing each particular apartment, including location, demographic, and price data to name a few.

## 1 Exploring Craigslist Posts in Davis
### 1.1 Is there a relationship between apartments in Davis' location and price?
Although a small city, Davis can be categorized to distinct region: West, North, South, East, Central, and Campus. Finding ideal housing for students has proven to be a challenge over the last years. So we will study the relationship between location and price in order to help students make better housing decisions when the time comes.

![image](https://user-images.githubusercontent.com/32987017/53151003-e23b8a80-3566-11e9-964e-cfc464771f83.png)

From this one can see that apartments farther in East Davis and North Davis (i.e.- Farther from campus) are typically more expensive. Surprising at first, one may expect apartments closer to campus be more expensive. However, that is not the case and it seems that the apartments to campus are in the lower price ranges. Nonetheless, upon further investigation, what is not as surprising is that the apartments price above $1840 are listings with 3 bedrooms compared to the other apartments being 1 or 2 bedrooms. So when we consider this as a possible confounding variable, it would make sense why apartments farther away are actually more expensive.

Some other notes to mention are there apartments with same latitude and longitude, which is possible since apartments listings can be part of a complex or adjacent to other complexes. Also, due to the small sample size, this makes it difficult to be certain of inferences made.

### 1.2 Are apartments in specific areas of Davis larger in size?
In addition to the price, we can study the relationship between the location and size and see if it is what we expect.

![image](https://user-images.githubusercontent.com/32987017/53151499-414dcf00-3568-11e9-94d9-1891ee0ed3e4.png)

As we can see, apartments in the smaller size range of 0-675 and 676-800 are in the central and southern region of Davis and closer to campus. This may not surprise many, because as you get closer to the campus, you near down-town Davis and it would seem that having smaller apartments with small space available for housing as you near campus would be more accommodate for the students. With that said, these findings suffer from the same limitations of the prior question – possible confounding variables and a lack of an adequate sample size to make clearer insights and inferences..

### 1.3 Are apartments in specific areas of Davis more pet friendly?
While price and size are important apartment features for some students and individuals looking for homes in Davis, some seek that the apartments are pet friendly for that special member of their family. So we will now study the pet policies across apartments in Davis.

![image](https://user-images.githubusercontent.com/32987017/53151525-5165ae80-3568-11e9-9a6b-0a41fb7912cb.png)

Here we see that if apartments in Davis are dog friendly then they must be cat friendly. So if an apartment is pet friendly it is either just car friendly or both cat and dog friendly. That said, in general, it seems that the apartments closer to campus are less pet friendly as one can see the square blocks, indicating an apartment that is not allow cats or dogs, are closer to campus. This suggests that if you were to have a pet then you probably should be looking for apartments farther from campus.
Again, the following observations may not be accurate due to the limited number of observations and possible confounders not included in this data such as apartment ownership, since particular apartment managers and ownerships may be more lenient when it comes to pets.

## 2 Exploring Craigslist Posts in Southern San Francisco
In this section of the analysis, we will explore the same questions we looked at for the Davis apartments, but now we will take a look at posts in the southern San Francisco region of California. We will define this to be the area which consists of the counties of San Francisco, San Mateo, Santa Clara, Alameda, and Contra Costa.

Because the data for this portion of the analysis contains for observations, we can be more confident in our insights and inferences. The number of Davis apartments posted on Craigslist was limited, so we were hesitant regarding our confidence and accuracy of the findings we concluded. However, with the increased number of observations, comes new issues, such as over-plotting which will be dealt with.

### 2.1 Is there a relationship between apartments in southern San Francisco location and price?

![image](https://user-images.githubusercontent.com/32987017/53151564-62162480-3568-11e9-8b62-cd8e360b4405.png)

In this visualization, each plot is a representation of southern San Francisco apartments falling in one of the four price ranges that was created by finding the min, 25th quantile, median, 75th quantile, and max of the rental prices; while each county corresponds to a particular color. From this we can see many of the Contra Costa apartments are in the lower price ranges of $200 to $2300 and $2301 to $2795, because the density plot indicates a large number of apartments within this range. Furthermore, it appears that as we move from cheaper

price ranges to more expensive ones that the major counties get denser, indicating that most of the apartments in major counties are going to be in the higher price ranges. For example, consider San Mateo, in the $200 to $2300 range we see that there is a relatively fair number of apartments within this price range, but as we go to $2696 to $3495 or $3495 the number of apartments in that particular county increases.

### 2.2 Are apartments in specific areas of southern San Francisco larger in size?
Next the relationship of county and size of the apartments will be observed.

![image](https://user-images.githubusercontent.com/32987017/53151594-7528f480-3568-11e9-86f7-360b2081478d.png)

From looking at the map, it appears that San Francisco and Santa Clara apartments do not appear to change much from the small apartment groups to the larger apartments groups. However, it does seem that in the counties of Alameda, San Mateo and Contra Costa the larger apartments are located in different areas of the counties compared to the smaller ones. Consider San Mateo, in the 0 to 675 square footage range a lot of the apartments are going to be found in the northern part, but as you increase the size of the apartment post, the apartments tend to be in the lower regions of that county. For Alameda too, as you move south, more apartments that are larger in size become available. Finally, for Contra Costa, as you move in the eastern and southern directions, larger apartments become available. From this patter, we can infer that as you move farther from the bay area, particularly San Francisco, the houses get larger.

### 2.3 Are apartments in specific areas of southern San Francisco more pet friendly?
Now we will group the apartment posts by the various pet policies, and see if certain areas are more pet friendly for families with pets looking for apartments in southern San Francisco areas.

![image](https://user-images.githubusercontent.com/32987017/53151636-8f62d280-3568-11e9-97d1-d6dfae92a77a.png)

It turns out that particular regions are not significantly more pet friendly than others. The number of apartments that allow for both cats and dogs is high for all counties. At the same time, there is a large number of apartments that do not allow pets in the apartments for all counties. With that said, someone looking for an apartment, will most likely not be have a restricted selection due to having a pet. There reason why there are so many apartments that allow pets and don’t allow pets is because there are a lot more apartment postings for the southern San Francisco area, which is good for apartment seekers with a pet as a member of their family.

## 3 Exploring Oldest Populations in the Southern Francisco Bay Area
In this final section of analysis, we will look at the oldest areas of the southern Francisco Bay area. Here, we will define old to be individuals over the age of 65. Rather than simply looking at regions that have the most old people, rather, we are interested in seeing which regions have the highest elderly proportion. Looking at the counties with the most elderly individuals would be unfair as we would be comparing regions with a varying number of individuals. However, comparing by proportions considers the fact that one county can have millions of people and other could have thousands, yet we would still be able to compare them.

### 3.1 Which places in the southern San Francisco Bay Area have the oldest populations?

![image](https://user-images.githubusercontent.com/32987017/53151676-a9041a00-3568-11e9-8fc2-c280d1bfa702.png)

Above we can see that most counties have a typical elderly proportion of 10 – 15%. What is interesting is when one looks at the areas that have a higher elderly proportion, particularly Contra Costa and small parts of Santa Clara. Thus, we can conclude that the oldest county in the San Francisco Bay Area is going to be Contra Costa.

### 3.2 How does this relate to the rental market, if at all?
We will next see if there is the elderly proportion relates to the rental market by looking at the price ranges across southern San Francisco Bay area and the corresponding proportion of elderly. The price ranges were determined through a summary statistics and can be seen below the graph.

![image](https://user-images.githubusercontent.com/32987017/53151715-ba4d2680-3568-11e9-84e7-aa4df03cc044.png)

There certainly are elderly individuals living in the more expensive price ranges of $2796 to $3495 and $3496 to $17700, but more appear to be in the lower two price ranges. This would indicate that elderly typically live in apartments that are cheaper. This makes sense, because usually they are no longer working, and therefore, it would be sensible that they would be living in cheaper homes. The middle to high proportions of elderly, 15 to 20 percent and 20 to 25 percent respectively, do appear in the higher price ranges which is interesting. This is indicated by the green and blue dots in the southern areas.

## Conclusion 
In this project, we analyzed spatial characteristics of the rental market using spatial and demographic data by studying some insightful questions regarding the apartments listings in Davis and the southern San Francisco Bay area. With the use of maps, we were able to obtain insights that may have been missed had we not used them.

