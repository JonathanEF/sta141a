# Load Packages
library(dplyr)
library(ggplot2)
library(viridis)
library(nnet)
library(tidyr)
library(ggrepel)

# Question 1 ----------------------------------
# read_digits
read_digits = function(file) {
  df = read.table(file, header = FALSE, sep = "")
  df = apply(df, 2, as.numeric) # converting all values in data frame into a numeric
  df = as.data.frame(df)
  colnames(df) = c("label", paste0("p", 1:256))
  df$label = as.factor(df$label)
  return(df)
}

# Test the function
# Provide Path and obtain test df and train df
test_path = "~/Desktop/School/sta141a/data/digits/test.txt"
train_path = "~/Desktop/School/sta141a/data/digits/train.txt"
test = read_digits(test_path)
train = read_digits(train_path)

# Overview
ncol(test) # 257
ncol(train) # 256
nrow(test) # 2007
nrow(train) # 7291

# Question 2 ---------------------------------

# obtain average value of all 256 pixels for each number label
train_mean_df =  aggregate(. ~ label,train, mean) # applies mean to all columns except label (used to group)

# plot average look of digits
image_numbers = function(data) {
  par(mfrow = c(3,4))
  for (i in 0:9) { # Ken Wang OH
    m = data[data$label == i,-1] # obtain the 256 pixels for the label
    m = t(apply(matrix((as.numeric(m)), nrow = 16, ncol = 16), 1, rev)) # convert the pixels into a matrix
    image(m, col = grey(seq(1,0,length = 256))) # plot the matrix
  }
}

# obtain image for how the average looks for test and train data
image_numbers(data = train_mean_df)

# identify useful and least useful pixels for classifcation
graphics.off() # reset graphics so the plot doesnt add onto the image_numbers plot
rem_labels_df = train[,-1]
var_matrix = as.matrix(apply(rem_labels_df, 2, var))
final_matrix = matrix(variance[, 1:ncol(var_matrix)], 16, 16)
image(t(apply(final_matrix, 1, rev)), col = grey(seq(1, 0, length = 256)))

# Question 3 -----------------

# Binded data
dist_set = rbind(test,train) 

# euclidean distance matrix
distances = as.matrix(dist(dist_set))

# manhattan distance matrix
distances_m = as.matrix(dist(dist_set, method = "manhattan"))

# Predict_knn ------------------------------
predict_knn = function(test,train, k, dm) {
  combined_df = rbind(test,train)
  labels = combined_df[,1]
  sub_distances = dm[1:nrow(test),(nrow(test) + 1):(nrow(test) + nrow(train)), drop = FALSE]
  
  # obtain lowest distances
  prediction_labels = unlist(apply(sub_distances,1,function(x){
    column_index = order(x)[1:k] + nrow(test)
    prediction_labels_freq = table(labels[column_index])
    # Voting - Break Ties
    random_winner = prediction_labels_freq[which.is.max(prediction_labels_freq)]
    winner = as.numeric(names(random_winner)) # which.is.break tie breakers
    return(winner)
  }))

  return(unname(prediction_labels))
}

predict_knn(test,train,4,distances)

# 4 -----------------------------------

# reproducibility
set.seed(2018)

# randomize training distance matrix
random_rows = sample(nrow(train)) 
train_dist_df = dist(train[random_rows,])
train_dist = as.matrix(train_dist_df)

# randomize manhattan training distance matrix
train_dist_manhattan_df = dist(train[random_rows,], method = "manhattan")
train_dist_manhattan = as.matrix(train_dist_manhattan_df)

# cv_error_knn -----------------
cv_error_knn = function(m, train, model, k, dm){ # use randomized distance matrix for dm
  
  # create m randomized folds
  shuffled_train = train[random_rows,]
  folds = split(random_rows, 1:m)
  
  e_hats = lapply(1:m, function(x){
    # find error estimates
    pred_labels = as.numeric(model(train = shuffled_train[-folds[[x]],], test = shuffled_train[folds[[x]],], k, dm)) # Patrick OH
    e_hat = (table(pred_labels == shuffled_train[-folds[[x]],]$label))[2] / sum(table(pred_labels == shuffled_train[-folds[[x]],]$label)) 
  })
  
  # average error rate of all error rate estimates
  errors = unlist(e_hats)
  average_error = sum(errors) / m
  return(average_error)
}
cv_error_knn(10,train,predict_knn,4,train_dist)

# 5 -------------------------------------

# euclidean 10 CV Errors for K 1 to 15
euclidean_cv_errors = sapply(1:15, function(x) {
  cv_error_knn(10,train,predict_knn, x, dm = train_dist) # randomized euclidean distance matrix
})
euclidean_cv_errors

# manhattan 10 cv errors for all 1 to 15
manhattan_cv_errors = sapply(1:15, function(x) {
  cv_error_knn(10,train,predict_knn, x, dm = train_dist_manhattan) # randomized manhattan distance matrix
})
manhattan_cv_errors

# create cv error data frame
# columns will be k values, euclidean errors, and manhattan errors
cv_error_df = as.data.frame(cbind(c(1:15), euclidean_cv_errors, manhattan_cv_errors)) # randomized manhattan distance matrix
colnames(cv_error_df) = c("k_value", "euclidean_error", "manhattan_error")
cv_error_df

# plot 10 cv error rates
ggplot(cv_error_df, aes(x = k_value)) +
  geom_line(aes(y = euclidean_error * 100, color = "Euclidean"), size = 1.75) +
  geom_line(aes(y = manhattan_error * 100, color = "Manhattan"), size = 1.75) +
  scale_color_viridis(discrete = TRUE, option = "viridis") +
  theme(axis.text = element_text(size = 12),
        axis.title = element_text(size = 15,face = "bold"),
        legend.title = element_text(size = 15),
        legend.text = element_text(size = 12),
        plot.title = element_text(size = 18),
        plot.subtitle = element_text(size = 16),
        axis.title.x = element_text(margin = margin(t = 15, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(margin = margin(t = 0, r = 5, b = 0, l = 0))) +
  guides(color = guide_legend(title = "Distance Method")) +
  labs(subtitle = "Euclidean vs Manhattan", 
       y = "CV Error Rate ( % )", 
       x = "K - Value", 
       title = "Comparing 10-fold CV Error Rates", 
       caption = "Source: digits.zip")

# 6 ---------------------------------------

# use difference distance matrix (unrandomized onesl; computed in question 3)
dim(distances) # euclidean distance matrix
dim(distances_m) # manhattan distance matrix

# euclidean test errors for all k 1 to 15
euclidean_test_errors = sapply(1:15, function(x) {
  predictions = predict_knn(test,train, x, distances) # unrandomized euclidean distance matrix
  test_error = unname((table(predictions == test$label))[1]/sum(table(predictions == test$label)))
})
euclidean_test_errors

# test errors for all k 1 to 15
manhattan_test_errors =  sapply(1:15, function(x) {
  predictions = predict_knn(test,train, x, distances_m) # unrandomized manhattan distance matrix
  test_error = unname((table(predictions == test$label))[1]/sum(table(predictions == test$label)))
})
manhattan_test_errors

# create test_error data frame
# columns will be k values, euclidean errors, and manhattan errors
test_error_df = as.data.frame(cbind(c(1:15), euclidean_test_errors, manhattan_test_errors))
colnames(test_error_df) = c("k_value", "euclidean_test_error", "manhattan_test_error")
test_error_df

# test error of two methods for k 1 to 15
ggplot(test_error_df, aes(x = k_value)) +
  geom_line(aes(y = euclidean_test_error * 100, color = "Euclidean"), size = 1.5) +
  geom_line(aes(y = manhattan_test_error * 100, color = "Manhattan"), size = 1.5) +
  scale_color_viridis(discrete = TRUE, option = "viridis") +
  theme(axis.text = element_text(size = 12),
        axis.title = element_text(size = 15,face = "bold"),
        legend.title = element_text(size = 15),
        legend.text = element_text(size = 12),
        plot.title = element_text(size = 18),
        plot.subtitle = element_text(size = 16),
        axis.title.x = element_text(margin = margin(t = 15, r = 0, b = 0, l = 0)),
        axis.title.y = element_text(margin = margin(t = 0, r = 5, b = 0, l = 0))) +
  guides(color = guide_legend(title = "Distance Method")) +
  labs(subtitle = "Euclidean vs Manhattan", 
       y = "Test Error Rate ( % )", 
       x = "K - Value", 
       title = "Comparing Test Error Rates", 
       caption = "Source: digits")

# test which digits are usually wrong for eucliean model
p = sapply(1:15, function(x) {
  predictions = predict_knn(test,train, x, distances)
  wrong_labels = unlist(test$label[predictions != test$label]) # incorrect labels
})

# most commonly missed label
sort(table(unlist(p)), decreasing = TRUE)

# Citations ------------
# Worked in a gorup with Kelly Chan, Jiemin Huang, Fenglan Jiang, Rohan Malhotra
# invalid graphic state after using par() : https://stackoverflow.com/questions/20155581/persistent-invalid-graphics-state-error-when-using-ggplot2
# Converting all values in data frame into a numeric:https://stat.ethz.ch/pipermail/r-help/2006-October/114289.html
# changing name of columns for df: https://stackoverflow.com/questions/37154481/make-sequential-numeric-column-names-prefixed-with-a-letter
# using aggregate: https://stackoverflow.com/questions/34523679/aggregate-multiple-columns-at-once
# reverse/transpose matrix : https://stackoverflow.com/questions/32443250/matrix-to-image-in-r?fbclid=IwAR2dymyb_gLFrOxD-cqvsJhIG_NzJ0F58ZOYANoJaPrvVXdz3kxfIWzJcTA
# obtaining the column value in a matrix given the position of a value in a matrix: http://r.789695.n4.nabble.com/Finding-the-position-of-a-variable-in-a-data-frame-td805142.html
# if/ else loop in predict_knn: Ken Wang Discussion
# selecting fold and using it as validation: Patrick OH
# basic structure of predict_knn, cv_error_knn : Nick's Lecture, Patrick OH
# using which.is.max to break ties for voting function : https://www.rdocumentation.org/packages/nnet/versions/7.3-12/topics/which.is.max

