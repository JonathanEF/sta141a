
# Load Packages --------------------
library(stringr)
library(dplyr)
library(ggplot2)
library(lubridate)
library(viridis)
library(viridisLite)

# Question 1 -----------------------
# create function read_post that reads a single Craigslist post from a text file
# file as parameter
read_post = function(file) {
  post = readLines(file, encoding = "UTF-8") # read all text lines of file
  post = str_c(post, collapse = "\n") # collapse into single string to make it easier to extract certain string patterns
}

# Question 2 -----------------------
# create function read_all_posts that uses read_post(from Question 1) to read all information from all posts in a directory and return them in a single data frame. 
read_all_posts = function(directory) {
  # create object called files that is a list of all files in provided directory
  files = list.files(directory, full.names = TRUE)
  
  # use read_post to obtain text of all files in directory
  posts = sapply(files, read_post)
  
  # usings posts create a dataframe
  d_df = data.frame(text = posts, region = basename(directory))

  result = str_split_fixed(d_df$text, "\n", 2)
  d_df$title = result[, 1]
  d_df$desc = result[, 2]
  
  # extract additional features/information
  # latitude
  d_df = d_df %>% mutate(latitude = str_extract(desc, regex("Latitude: [-0-9,.]+", ignore_case = TRUE)))
  d_df$latitude = as.numeric(str_extract(d_df$latitude, "[0-9,.]+"))
  
  # longitude
  d_df = d_df %>% mutate(longitude = str_extract(desc, regex("Longitude: [-0-9,.]+", ignore_case = TRUE)))
  d_df$longitude = as.numeric(str_extract(d_df$longitude, "[0-9,.]+"))
  
  # bedrooms
  d_df = d_df %>% mutate(bedrooms = str_extract(desc, regex("Bedrooms: [0-9,.]+", ignore_case = TRUE)))
  d_df$bedrooms = as.numeric(str_extract(d_df$bedrooms, "[0-9,.]+"))
  
  # bathrooms
  d_df = d_df %>% mutate(bathrooms = str_extract(desc, regex("Bathrooms: [0-9,.]+", ignore_case = TRUE)))
  d_df$bathrooms = as.numeric(str_extract(d_df$bathrooms, "[0-9,.]+"))
  
  # sqft
  d_df = d_df %>% mutate(sqft = str_extract(desc, regex("Sqft: [0-9,.]+", ignore_case = TRUE)))
  d_df$sqft = str_extract(d_df$sqft, "[0-9,.]+")
  d_df$sqft = as.numeric(str_remove_all(d_df$sqft, ","))
  
  # price
  d_df = d_df %>% mutate(user_price = str_extract(d_df$desc, regex("\\$[0-9,.]+ per month|price: \\$[0-9,.]+",ignore_case = TRUE)))
  d_df$user_price = str_extract(d_df$user_price, "[0-9,.]+")
  d_df$user_price = as.numeric(str_remove_all(d_df$user_price, ","))
  
  # date
  d_df = d_df %>% mutate(date = str_extract(d_df$desc, regex("date posted: [a-zA-Z]+ [0-9]+, [0-9]+ at [0-9:]+", ignore_case = TRUE)))
  d_df$date = str_remove_all(d_df$date, regex("date posted: ", ignore_case = TRUE))
  d_df$date = strptime(d_df$date, "%B %d, %Y at %H:%M")
  
  # return data frame
  d_df
}

# Test for one directory
setwd("~/Desktop/School/sta141a/data/messy")
test_dir = "~/Desktop/School/sta141a/data/messy/losangeles"
View(read_all_posts(test_dir))


# Question 3 -----------------------
# explanation in report

# Question 4 -----------------------
# Extract the rental price from the title of each Craigslist post.
# Do all of the titles have prices? 
# How do these prices compare to the user-specified prices (the price attribute)?

# this function takes a directory and reads all the text files within it
# then it reads the file and combines every line into a single string
# finally it creates a data frame for each directory with a text column and a region column
load_posts = function(directory) {
  files = list.files(directory, full.names = TRUE)
  
  posts = sapply(files, function(file) {
    post = readLines(file, encoding = "UTF-8")
    str_c(post, collapse = "\n")
  })
  data.frame(text = posts, region = basename(directory))
}

# obtain files of each city in messy folder
# create path to obtain all directories in messy folder
# obtain data frame for every folder region in messy folder
# combine data frames into one
messy_dir = "~/Desktop/School/sta141a/data/messy"
dirs = list.files(messy_dir, full.names = TRUE)
posts = lapply(dirs, load_posts)
posts_df = do.call(rbind, posts)

# split text into title, and remaining text and add to data frame
result = str_split_fixed(posts_df$text, "\n", 2)
posts_df$title = result[, 1]
posts_df$text = result[, 2]

# overview of data
nrow(posts_df) # 45845 apartments

# extract title price and user price from text and add to data frame
# remove all commas
# extract only the numerical characters of the price
# coerce character into numeric
posts_df = posts_df %>% mutate(title_price = str_extract(posts_df$title, "\\$[0-9,.]+"))  
posts_df = posts_df %>% mutate(user_price = str_extract(posts_df$text, regex("\\$[0-9,.]+ per month|price: \\$[0-9,.]+",ignore_case = TRUE)))
posts_df$title_price = str_extract(posts_df$title_price, "[0-9,.]+")
posts_df$user_price = str_extract(posts_df$user_price, "[0-9,.]+")
posts_df$title_price = as.numeric(str_remove_all(posts_df$title_price, ","))
posts_df$user_price = as.numeric(str_remove_all(posts_df$user_price, ","))

# observe number of na
table(is.na(posts_df$title_price)) # 176 NA 
table(is.na(posts_df$user_price)) # 190 NA
# 176 posts do not have price in title

# how do the prices compare between title and user
equal_df = posts_df[posts_df$title_price == posts_df$user_price,]
nrow(equal_df) # 44706 posts where title price and user price are equal
nrow(posts_df) # 45845 total posts
# 1139 not equal

# Question 5 --------------------------
# Extract the deposit amount from the text of each Craigslist post. Is there a relationship
# between rental price and deposit amount?

# extract security deposit from text and add to data frame
# extract only the numerical characters of the security deposit
# remove extra characters like the comma
# coerce character into a numeric
# must extract all not just first instance because text file can have both pet deposit and security deposit; remove pet deposits
posts_df = posts_df %>% mutate(deposit_price = str_extract(text, regex("(pets?|cats?|dogs?|moving|additional)? deposit:? (= |is |of )?\\$[0-9,.]+|(additional )?\\$[0-9,.]+ (security )?deposit", ignore_case = TRUE)))
posts_df$deposit_price = str_replace_all(posts_df$deposit_price, "(pets?|cats?|dogs?|moving|additional)? deposit:? (= |is |of )?\\$[0-9,.]+|additional \\$[0-9,.]+ deposit", "") # remove the ones that said pet deposit; we wanted the ones that just say deposit
posts_df$deposit_price = str_extract(posts_df$deposit_price, "[0-9,.]+")
posts_df$deposit_price = as.numeric(str_remove_all(posts_df$deposit_price, ","))

# undo
# observe number of na for security deposit prices
table(is.na(posts_df$deposit_price)) # 37354 NA, 8397 not NA

# graph security deposit vs title price
rm_na_df = subset(posts_df, !is.na(deposit_price))
rm_na_df = rm_na_df %>% filter(rm_na_df$user_price >= 200, rm_na_df$deposit_price > 99) # outliers and remove application fee;some dpeosits 99
summary(rm_na_df)
summary(rm_na_df)

ggplot(rm_na_df, aes(user_price, deposit_price)) + geom_point() + ylim(c(0,10000)) +
  geom_abline() +
  theme(axis.text=element_text(size = 16),
        axis.title=element_text(size = 20,face = "bold"),
        plot.title = element_text(size = 22),
        plot.subtitle = element_text(size = 18),
        axis.title.x = element_text(margin = margin(t = 15, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(margin = margin(t = 0, r = 5, b = 0, l = 0))) +
  labs(subtitle = "Apartment Rental Price vs Deposit Price", 
       y = "Deposit Price ($)", 
       x = "Apartment Price ($)", 
       title = "Scatterplot", 
       caption = "Source: messy")
cor(rm_na_df$title_price, rm_na_df$deposit_price) # correlation 0.411

# Question 6 --------------------------
# Extract a categorical feature from each Craigslist post (any part) that measures whether
# the apartment allows pets: cats, dogs, both, or none. Are there any apartments that allow
# some other kind of pet? For apartments that allow pets, make a graphic that shows how
# pet deposits are distributed and discuss what the graphic suggests about pet deposits.

# extract pet policy from text and create pet policy column
# then assign patterns to one of the following policies: both, none, cats, dogs
posts_df = posts_df %>% mutate(pet_policy = str_extract(text, regex("no pets?|pets? not allowed|(accept |love )pets?|pets?( |-)(friendly|welcome)|cats? (only|allowed|ok)|dogs? (only|allowed|ok)", ignore_case = TRUE)))
posts_df$pet_policy = str_replace(posts_df$pet_policy, regex("no pets?|pets? not allowed", ignore_case = TRUE), "none") # replace no pet regular expression with none (no pets allowed)
posts_df$pet_policy = str_replace(posts_df$pet_policy, regex("(accept |love )pets?|pets?( |-)(friendly|welcome)", ignore_case = TRUE), "both") # replace pet friendly regular expressions with both (both dog and cat allowed)
posts_df$pet_policy = str_replace(posts_df$pet_policy, regex("cats? (only|allowed|ok)", ignore_case = TRUE), "cats") # replace cat regular expression with cats (cats only)
posts_df$pet_policy = str_replace(posts_df$pet_policy, regex("dogs? (only|allowed|ok)", ignore_case = TRUE), "dogs") # replace dog regular expression with dogs (dogs only)
table(posts_df$pet_policy) # 10140 both, 1853 cats, 763 dogs, 58842 none

# check if we extracted an adequate number of pet policies from posts that mention pets
has_pet_in_text = str_detect(posts_df$text, "[Pp]ets?")
table(has_pet_in_text) # 28932
table(is.na(posts_df$pet_policy)) # 28007 not NA

# do pets allow other kinds of pets other than dogs and cats
# looking at posts posts that mention
other_pets_df = posts_df %>% filter(str_detect(text, regex("small caged animals", ignore_case = TRUE)) == TRUE)
head(other_pets_df$text)
# birds, hamsters, gerbils, rabbits, guinea pigs, chinchillas, aquarium/ terrarium animals ( fish, hermit crabs, turtles, frogs, small lizards)
# no exotic/dangeorus animals

# extract pet deposit from text
# further extract only the numerical characters
# removed |additional \\$[0-9,.]+ deposit|additional deposit of \\$[0-9,.]+
posts_df = posts_df %>% mutate(pet_deposit = str_extract(text, regex("pets? deposit: \\$[0-9,.]+|\\$[0-9,.]+ pets? deposit|\\$[0-9,.]+ per pet|pet deposit of \\$[0-9,.]+", ignore_case = TRUE)))
posts_df$pet_deposit = str_extract(posts_df$pet_deposit, "[0-9,.]+")
posts_df$pet_deposit = str_remove_all(posts_df$pet_deposit, ",")
posts_df$pet_deposit = as.numeric(posts_df$pet_deposit)
table(is.na(posts_df$pet_deposit)) # 44059 NA, # 1786 not NA

# plot the distribution of pet deposits
ggplot(posts_df, aes(x = pet_deposit)) + 
  geom_histogram(aes(y = stat(count)), binwidth = 50) +
  theme(axis.text=element_text(size = 16),
        axis.title=element_text(size = 20,face = "bold"),
        plot.title = element_text(size = 22),
        plot.subtitle = element_text(size = 18),
        axis.title.x = element_text(margin = margin(t = 15, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(margin = margin(t = 0, r = 5, b = 0, l = 0))) +
  labs(subtitle = "Pet Deposits", 
       y = "Count", 
       x = "Price", 
       title = "Histogram", 
       caption = "Source: messy")

# explore outliers/ pet deposits that are high
View(posts_df %>% filter(pet_deposit >= 1000))
outlier_df = posts_df %>% filter(pet_deposit >= 1000) 
outlier_df[,1] # read up on the pet deposits for these outliers
# after reading, it does not appear the expensive pet deposits are mistakes
# pet deposit can be greater than security deposit

# Question 7 --------------------------
# Extract a categorical feature from each Craigslist post that measures whether eachapartment has some kind of heating: 
# a heater, a fireplace (including wood-burning stoves),both, or neither of these. 
# Also extract a categorical feature from each Craigslist postthat measures whether each apartment has air conditioning. 
# Is air conditioning more common than heating? 
# Do apartments with air conditioning typically have heating? 
# Do apartments with heating typically have air conditioning?

# extract apartment heating features
posts_df = posts_df %>%  mutate(heating = str_extract(text, regex("(wall |central |centralized )?heat(er|ing)", ignore_case = TRUE)))
posts_df = posts_df %>%  mutate(fireplace = str_extract(text, regex("(wood burning |gas )?fire(places?| pit)", ignore_case = TRUE)))
# replace these patterns with heater or fireplace, because if a pattern was extracted then it means it has that feature
posts_df$heating = str_replace(posts_df$heating, regex("(wall |central |centralized )?heat(er|ing)", ignore_case = TRUE), "heater")
posts_df$fireplace = str_replace(posts_df$fireplace, regex("(wood burning |gas )?fire(places?| pit)?", ignore_case = TRUE), "fireplace")

# use paste to create new column that will be placeholder for if it has fireplace, heater, both, or none
# replace patterns to see which heating features are included if any
posts_df = posts_df %>% mutate(heating_features = paste(heating, fireplace))
posts_df$heating_features = str_replace(posts_df$heating_features, "heater fireplace", "both")
posts_df$heating_features = str_replace(posts_df$heating_features, "heater NA", "heater")
posts_df$heating_features = str_replace(posts_df$heating_features, "NA fireplace", "fireplace")
posts_df$heating_features = str_replace(posts_df$heating_features, "NA NA", "None")
table(posts_df$heating_features) # 2069 both, 6557 fireplace, 6219 heater, 31000 none

# visualize the various heating features ( not needed for homework ) use to get a better understanding of heating features
# convert to factors so we can reorder the barplot in increasing order
factors_heating_features = factor(posts_df$heating_features, levels = c("both", "heater", "fireplace", "None"))
ggplot(posts_df, aes(factors_heating_features)) + geom_bar() +
  geom_text(stat = "count", aes(label = ..count.., y = ..count.. + .5), vjust = -0.2, size = 5, color = "red") +
  theme(axis.text=element_text(size = 16),
        axis.title=element_text(size = 20,face = "bold"),
        plot.title = element_text(size = 22),
        plot.subtitle = element_text(size = 18)) +
  labs(subtitle = "Heating Features of Apartment Listings ", 
       y = "Count", 
       x = "Heating Feature", 
       title = "Barplot", 
       caption = "Source: messy")

# extract apartment air conditioning
posts_df = posts_df %>% mutate(air_conditioning = str_extract(text, regex("air( |-)conditioning|central(ized)? a/?c|a/c", ignore_case = TRUE)))
posts_df$air_conditioning = str_replace(posts_df$air_conditioning, regex("air( |-)conditioning|central(ized)? a/?c|a/c", ignore_case = TRUE), "Air Conditioning")
table(is.na(posts_df$air_conditioning)) # 35894 NA, 9951 not NA/ 9951 apartments have air conditioning
# so apartments have heating more often than air conditioning

# graph to see if apartments with air conditioning typically have heating
# graph proportions so answers are not skewed by sample size

# color blind safe
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
scale_colour_manual(values=cbPalette)

# plot if apartments with air conditioning typically have heating? 
ggplot(posts_df, aes(x = as.factor(air_conditioning))) + geom_bar(aes(fill = as.factor(heating_features)), position = "fill") +
  scale_x_discrete(labels = c("Apartment with A/C", "Apartment without A/C")) +
  scale_fill_manual(values = cbPalette, name = "Heating Feature", label = c("Both", "Fireplace Only", "Heater Only", "None")) +
  theme(axis.text=element_text(size = 16),
        axis.title=element_text(size = 20,face = "bold"),
        legend.text = element_text(size = 16),
        legend.title.align = 0.5,
        legend.title = element_text(size = 14, face = "bold"),
        plot.title = element_text(size = 22),
        plot.subtitle = element_text(size = 18),
        axis.title.x = element_text(margin = margin(t = 15, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(margin = margin(t = 0, r = 5, b = 0, l = 0))) +
  labs(subtitle = "Proportion of Heating Features for Apartments with and without AC", 
       y = "Proportion", 
       x = "Air Conditioning Feature", 
       title = "Barplot", 
       caption = "Source: messy")
# apartments with ac are more likely to have a heating feature than apartments without ac

# apartments with heating typically have air conditioning
# graph proportions so answers are not skewed by sample size
ggplot(posts_df, aes(x = as.factor(heating_features))) + geom_bar(aes(fill = as.factor(air_conditioning)), position = "fill") +
  scale_x_discrete(labels = c("Both", "Fireplace", " Heater", "None")) +
  scale_fill_viridis_d(na.value = "#D55E00", name = "A/C Feature", label = c("Has A/C","No A/C")) +
  theme(axis.text=element_text(size = 16),
        axis.title=element_text(size = 20,face = "bold"),
        legend.text = element_text(size = 16),
        legend.title.align = 0.5,
        legend.title = element_text(size = 14, face = "bold"),
        plot.title = element_text(size = 22),
        plot.subtitle = element_text(size = 18),
        axis.title.x = element_text(margin = margin(t = 15, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(margin = margin(t = 0, r = 5, b = 0, l = 0))) +
  labs(subtitle = "Proportion of Heating Features for Apartments with AC and without AC", 
       y = "Proportion", 
       x = "Heating Feature", 
       title = "Barplot", 
       caption = "Source: messy")
# apartments with both fireplace and heater are more likely to have air conditioning

# Question 8 --------------------------
# Craigslist has an optional feature to hide email addresses and phone numbers from webscrapers like the one that scraped this data set. 
# Do people seem to use this feature? How can you tell? 
# Explain your strategy and your conclusions.

# extracting contact info not enough; this skews the count of people not using this optional feature
# because sometimes there will just be no phone or email and this results in an unwarranted listing to have the optional feature off when it could be on
posts_df = posts_df %>%  mutate(optional = str_extract(text, regex("[(]?\\d{3}[)]?( |-)\\d{3}( |-)(\\d|o){4}|show contact info|[A-z0-9-]+\\@[A-z0-9-]+\\.[A-z0-9-]{2,3}", ignore_case = TRUE)))
posts_df$optional =  str_replace(posts_df$optional, regex("[(]?\\d{3}[)]?( |-)\\d{3}( |-)(\\d|o){4}", ignore_case = TRUE), "Phone Number") # replace to phone numbers
posts_df$optional =  str_replace(posts_df$optional, regex("[A-z0-9-]+\\@[A-z0-9-]+\\.[A-z0-9-]{2,3}", ignore_case = TRUE), "Email") # replace phone numbers to emails
table(posts_df$optional) # Email: 14, Phone Number: 34, Show contact Info: 34800
posts_df$optional =  str_replace(posts_df$optional, "Email|Phone Number", "Email or Phone") # replace phone numbers to phone numbers

# plot to observe how many people turn on feature
rem_na_posts_df = posts_df %>% filter(!is.na(optional)) # remove na of optionals column
ggplot(rem_na_posts_df, aes(x = as.factor(optional))) + geom_bar() +
  geom_text(stat = "count", aes(label = ..count.., y = ..count.. + .5), vjust = 0, size = 10, color = "red") + 
  scale_x_discrete(labels=c("Off", "On")) +
  theme(axis.text=element_text(size = 16),
        axis.title=element_text(size = 20,face = "bold"),
        plot.title = element_text(size = 22),
        plot.subtitle = element_text(size = 18),
        axis.title.x = element_text(margin = margin(t = 15, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(margin = margin(t = 0, r = 5, b = 0, l = 0))) +
  labs(subtitle = "Number of Listings that Hide and Don't Hide Contact Info", 
       y = "Count", 
       x = "Optional Feature", 
       title = "Barplot", 
       caption = "Source: messy")

# Overview of final data frame
nrow(posts_df)
names(posts_df)
str(posts_df)

# View final data frame
View(posts_df)

# Citations --------------------------
# Worked in Group with: Kelly Chan, Jiemin Huang, Fenglan Jiang, Rohan Malhotra
# Question 8 (pattern): https://piazza.com/class/jmf7qwk0sf03ya?cid=396
# labeling bar plot with heights : http://www-personal.umich.edu/~agrogan/bar_charts_in_ggplot2/
# use of paste: https://stackoverflow.com/questions/18115550/how-to-combine-two-or-more-columns-in-a-dataframe-into-a-new-column-with-a-new-n/40994869
# changing name of x axis for bar plot: https://stackoverflow.com/questions/39814184/in-r-ggplot-how-to-change-labels-for-multiple-barplots
# adjusting colors of barplot: https://piazza.com/class/jmf7qwk0sf03ya?cid=466
# modifying font size of plots: https://stackoverflow.com/questions/14942681/change-size-of-axes-title-and-labels-in-ggplot2/14942760
# modifying size of axes: https://stackoverflow.com/questions/14942681/change-size-of-axes-title-and-labels-in-ggplot2/14942760
# see which aspects can be changed: https://ggplot2.tidyverse.org/reference/theme.html
# changing size of legend text: https://stackoverflow.com/questions/9639127/adjust-position-and-font-size-of-legend-title-in-ggplot2








