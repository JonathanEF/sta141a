
# Analysis on Apartment Listings Scarped from Craigslist

In this project, we'll aim to study the various characteristics of apartment listings that people post online —
we’re going to be using data scraped directly from the Craigslist website for this analysis. It will be explained
later as to how we created functions to extract various features from the data and put it into a data frame.

## Overview of the Data
Before the function is explained, it is important to understand the data the function uses. Here we will explain
the structure of the scraped web data. The given data was in the form of a zip-file containing a messy folder
with sub-folders of the various areas the apartment listings where posted in, labeled: sfbay_sfc, sfbay_sby,
sfbay_pen, sfbay_eby, sf_bay, sandiego, sacramento, losangeles. In each of these folders are a list of all of
the individual apartment listings for that area in the form of a text file. From these text files there is much
information that one can extract from it, however, in this report the following characteristics from the
apartments are taken: latitude, longitude, number of bedrooms, number of bathrooms, size (sqft), price (title and
user inputted), date posted, deposit price, pet policy, heating features, air conditioning features, and contact
information. Overall, there are a total of 45845 total apartment listings that were scraped from Craigslist.

## 3 Functions to Read Data
### 3.1 read_post
The read_post function reads a single Craigslist post from a text file. As explained in the overview of the data,
there are text files in the sub-folders of the regions. This function takes one of those text files as input and reads
it so that we can perform some string processing. The flow of the function is as follows: the function takes a text
file, denoted in the function as file. Then it uses the function readLines on that text file to read all of the text
lines in the respective text file, this result is stored in post. Finally, we use str_c on the vector, post, so that we
can just have a single string to make it easier to extract patterns for that post.

### 3.2 read_all_posts
The read_all_posts function reads all the text files in a sub folder and uses the read_post function to read
through all of the text files for that folder and constructs a data frame with the processed text and additional
apartment characteristics. Rather than taking a text file, we input a directory, then list.files is used to list all of
the text files in the directory. Next, sapply allows us to create a vector of all the strings created by the read_post
function. Then, we can split the text, to separate the title price from the user price. Finally, we use the text read
from the text file to extract various characteristic: latitude, longitude, bedrooms, bathrooms, sqft, price, and
date. And a data frame of all those features are then returned.

## 4 Rental Price
### 4.1 Extracting Title Price and User-specified Price
In the apartment posts, there may be two rental prices given: one in the title and one the user-specified later in
the body of the text. From the title text we can extract the title price. We already split the title text from the 
body text, so we can simply extract the title price from that. Likewise, we can extract the user-specified price
form the body text. However, the user-specified price can be a bit tricky because there are other prices such
various types of deposits. So we make sure to make use of keywords such as per month and price. We observe
that only 176 title prices are missing and 190 user-specified prices are missing.

### 4.2 Skepticism of Extracting Price
When splitting the data into the title text and the body text, it is assumed the title price will be proceeded by a
line break. However, it may be possible the title price occurs in a format not addressed. Meaning the number of
title price obtained is less than it should be. Furthermore, although from reading the text we see that per month
is usually an indicator of the rental price, it is plausible that this could refer to the price of a characteristic that is
not the user-specified price.

### 4.3 Comparison of the Two Rental Prices
As mentioned earlier there are a total of 45845 apartment postings on the website. Of these, 44706 posts had
both a title rental price and user-specified rental price where the values are exactly the same. Whereas, 1139
apartments either had two rental prices that were not equal or had a missing value for title price or userspecified price.

## 5 Deposit
### 5.1 Extracting the Deposit
Although we are currently interested in the security deposit of the apartment listings, there are other deposits
such as a pet deposit or moving deposit. In order to extract the deposit, we first extract all pattern from the text
that mention deposit, this pattern will include patterns like “pet deposit,”, “additional deposit”, “deposit”,
“security deposit”. Ultimately, we are interested in the security deposit, so the last pattern is expected. Also,
sometimes people list the security deposit on the apartment listings with just the word “deposit”, so we want to
extract those instances. What we do is extract all patterns that match to deposit plus the word before it. If it is
just deposit, we can expect it to be the security deposit. However, if it matches to a pattern such as “pet deposit”
or “additional deposit”, we do not want those so we replace them with empty strings. Upon extracting the
deposit, we obtain 37354 deposit prices.

### 5.2 Skepticism of Extracting Deposits
For this section of analysis, we looked through much of the text to observe common patterns as to how we
obtained the security deposit pattern. However, this was obtained under an assumption that the word before
“deposit” would indicate whether it is a security deposit or not. An issue that may arise due to this is: the words
before deposit that was put for my pattern is not an exhaustive list, resulting in an over-estimation of the
security deposit since patterns that match “deposit” are defined to be security deposits, but there may be a word
before “deposit” not in my pattern that tells us that it is not a security deposit.

### 5.3 Relationship of Rental Price and Deposit Amount
Before illustrating the relationship of the rental price and deposit amount, some filtering was done to address
some unexpected rental prices. As stated earlier, we mentioned possible faults in the pattern created. Upon
further observation, we see the user price is below 200, this may be due to the extraction (a mistake on our part)
or due to an incorrect value inputted on the apartment listing (a mistake on the person who made the post). To
address this issue, we take observation where the user-specified price I greater than 200, and likewise apply the
same logic to the deposits. Furthermore, we choose to use the user-specified price rather than the title price. One 
can expect that the user-specified price is more accurate than the title price. Title prices may not be accurate,
and may just be used to get someone to click on their post. This could be a possible explanation for posts where
the title price differs from the user-price. However, these values do not differ often, so plotting the title price
would be adequate as well.

![screen shot 2019-02-20 at 11 58 51 pm](https://user-images.githubusercontent.com/32987017/53152844-83c4db00-356b-11e9-97fa-0e1d28c61261.png)

The correlation for this relationship is 0.411. This would indicate that the relationship between rental price and
deposit price is a somewhat weak, positive, linear relationship. In general, as the apartment price increases the
deposit price increases, but does not appear to have a strong direct linear relationship. It does make sense that
deposit prices are somewhat close to the apartment monthly rental price. Also, it is possible to have a deposit
price greater than the apartment price, however, it would be concerning to find the deposit price to be
significantly greater.


## 6 Pet Policy
### 6.1 Extracting Pet Policy
In this section of the analysis, we are interested in extracting the pet policies of the apartment listings, to see if
apartments allow cats, dogs, both, or none. It is usually apparent if an apartment listing allows no pets or both
cats and dogs. These types of listings typically mention in their posts patterns such as “no pets” or “pets not
allowed” and listings that are pet friendly will typically say “pet friendly”, “pet welcome” and “pet allowed”.
For cats only and dogs only the type of pet will usually be followed by keywords such as “only”, “allowed”, or
“ok”. Overall, we get that 10140 apartments allow both pets, 1853 allow cats only, 763 allow dogs only, and
58842 have no mention of this definition of pet policy.

### 6.2 Skepticism of Extracting Pet Policy
These patterns created to determine whether the apartment listing allows cats, dogs, both, or none follows the
assumption what is meant by certain patterns. For example, if a listing said “pet friendly”, perhaps they place
certain restrictions on dogs. Also, a trade-off was made in the pattern: sometimes posts just mention that “cats
allowed” and do not mention dogs at all, it is reasonable to assume that a listing that matched this pattern
follows a cat only policy; which our pattern follows. However, it does happen on occasion that the listing will
say something like “dogs and cats allowed”; which would be should be both, but our pattern would deem it to
be cats, Still, from the number of listings read over this is not a common occurrence.

### 6.3 Additional Pets
When mentioning pets, most of the posts are referring to dogs and cats, because these are usually the most
common house pet a family may have. However, some posts mention their policies on other pets. Looking
through the text of the posts, a pattern that illustrates the mentioning of additional pets is small caged animals.
Posts that follow this pattern mention other animals such as birds, hamsters, gerbils, rabbits, guinea pigs,
chinchillas, and aquarium/ terrarium animals (fish, hermit crabs, turtles, frogs, small lizards). While mentioning
that exotic and dangerous animals are not allowed.

### 6.4 Extracting Pet Deposit
Extracting the pet deposit is quite simpler than extracting security deposit, because pet deposits explicitly
mention that it is a pet deposit, by words before or after deposit. For example, some patterns include: “pet
deposit”, “pet deposit of”, or “per pet”. After extracting the pet deposit, we get 1786 pet deposits.

### 6.5 Distribution of Pet Deposits

![screen shot 2019-02-20 at 11 59 25 pm](https://user-images.githubusercontent.com/32987017/53152894-a22ad680-356b-11e9-9b89-3c66137a20df.png)

The distribution of the pet deposits is skewed left, with a majority of the pet deposits being 500 dollars evident
by the bar where price is 500. This seems to be expected as we would not expect the pet deposits to be greater
than 500 dollars. There are some posts that have pet deposits greater than 500 dollars, which appear to be
outliers. However, we further explored those values by reading the text for those respective posts. It appears that
those posts are listings with high rental prices, which are so high that even the high pet deposit is lower than the
rental price. Thus, it is sensible to have a high pet deposit for a really expensive apartment listing. It would be a
concern if the pet deposit was greater than the rental price.

## 7 Heating and Air Conditioning
### 7.1 Extracting Heating and Fire Place
For this section, we define heating to be heaters and heating, and for it to be distinct from fireplaces. Firstly, to
obtain the heating we identify the types of heaters mentioned in the posts to be wall heaters, central heaters, and
centralized heaters. Whereas, the fireplaces include wood burning fireplaces, gas fireplaces, and fire pits. Using
these keywords, we create a pattern that gives us 2069 that have both heating and a fireplace, 6557 with only a
fireplace, 6219 with only a heater, and 31000 with neither a fireplace or a heater.

### 7.2 Skepticism of Extracting Heating and Fire Place
The limitation of this extraction is in how it is defined. There is a possibility that this pattern is not an
exhaustive match to all the types of heaters and fireplaces there are. However, the common types of these
features are certainly addressed in the pattern created.

### 7.3 Extracting Air Conditioning
In regards to the air conditioning, posts normally mention air conditioning or the abbreviation for air
conditioning, A/C. This extraction was simple, however, this assumes that apartments that do not have air
conditioning do not mention air conditioning at all. If they say something like, “no A/C” which would be
unusual as the post is meant to advertise the apartment, but if it were too, then the number obtained of
apartments with air conditioning is greater than it should actually be.

### 7.4 Analyzing Heating Features for Apartments with and without Air Conditioning
Here, we will explore the heating features for the apartments that have air conditioning and those that do not.

![screen shot 2019-02-20 at 11 59 32 pm](https://user-images.githubusercontent.com/32987017/53152895-a48d3080-356b-11e9-86fb-e53fdea3695e.png)

From this, we see that apartments with air conditioning are more likely to have both features (heater and
fireplace) than apartments without air conditioning. Furthermore, the apartments with air conditioning are more
likely to have heaters only than the apartments that do not have air conditioning. Overall, apartments with air
conditioning are more likely to have some heating feature, whether it be a fireplace, a heater, or both a fireplace
and heat. This is evident by the either looking at the greater sizes for the grey, orange, and blue bar which
represent both heating features, fireplaces, and heaters respectively. Or one could see that apartments without
air conditioners have a significantly higher green, representing no heating feature, than apartments with air
conditioning. We observed that apartments with A/C are more likely to have heating features. This is what one
would expect, since apartments with A/C are usually nicer apartments, and these sort of apartments are more
likely to have additional apartment features; including heating.


### 7.5 Analyzing Air Conditioning Feature for Apartments with Heating Features
Next, we will explore the air conditioning feature for the apartments that have heating features and those that do
not.

![screen shot 2019-02-20 at 11 59 39 pm](https://user-images.githubusercontent.com/32987017/53152898-a7882100-356b-11e9-9337-412a03a980ee.png)

We see that apartments with fire places and heaters are most likely to have an A/C. This is
apparent because the bar for both has the largest purple bar which denotes the proportion of apartments that
have A/C. Also, apartments with neither heaters nor fireplaces are least likely to have an A/C, evident by the
none bar having the smallest purple bar. The reason this is what we would expect, is because apartments that
have heating features are more likely to be nicer apartments with more features, thereby they are more likely to
have other apartment features such as air conditioning.

### 8 Craigslist Optional Feature
Craigslist has an optional feature to individuals who post on their website. This feature hides their contact
information, such as their email or phone number from web scrapers.

## 8.1 Extracting Optional Feature
Upon observing the posts it becomes apparent that those that have this feature on state “show contact info” in
the text rather than their respective email or phone number. We cannot simply just extract the number of posts
that have the pattern “show contact info” in the post, and assume that the posts that do not have the pattern
“show contact info” do not have the optional feature on. This is true, because apartments that that do not have
“show contact info” may just not mention any phone or email in their post, thus we are unable to identify if that
post has the feature on or off.

Therefore, we can extract “show contact info” and if the post has that pattern, then we know for sure that the
optional feature is on. Furthermore, we can attempt to extract a phone or email, and if an email address or phone 
number is obtained that means the optional feature is off. While all the other posts we would be unable to tell if
it has the feature on or off.

Now, using the various patterns observed by looking at an appropriate number of posts we extract the phone
number, email, and “show contact info.”

## 8.2 Limitation of Extracting Optional Feature
As mentioned earlier apartments that do not provide an email or phone number, we are unable to identify if that
person has the optional feature on or off, because there is no pattern to match to.

## 8.3 Visualizing Optional Feature

![screen shot 2019-02-21 at 12 00 17 am](https://user-images.githubusercontent.com/32987017/53152916-b40c7980-356b-11e9-8129-5ce2d095db24.png)

It is apparent that the vast majority of people who post apartments listings on Craigslist have the optional feature
on. With the increasing awareness that individuals possess of internet safety, individuals are more likely to have
features like this on. Although, the intent of web scrapers may not malicious, having the feature on gives a sense
of security. Therefore, it makes sense why almost all of the postings have this feature on.

In this project, we analyzed the apartments of the Craigslist postings by studying some insightful characteristics
extracted from the text for some regions in California. The conclusions we arose throughout the analysis were 
supported by the various visualizations. Still, it is important to remember the limitations and assumptions made
throughout the report, especially since there are numerous ways to have defined and extracted the patterns of
interest.

