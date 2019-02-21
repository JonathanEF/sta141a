# Classifying Hand-written Digits

In this project, we’ll aim to classify handwritten digits with various models and measure to
accuracy of each model. We will be implementing k-nearest neighbors classification and testing
the error-rate with a 10-fold cross validation.

Because the classification power of k-nn is dependent on the k and the metric used to calculate
distance, it is important to mention that we will be using the Euclidean and Manhattan metrics for
distance calculations.

Using the cross-validation algorithm we will estimate the error rate of our k-nn model by fitting
multiple times on the training data. To do so, the number of folds will be defined to be m. The data
will be split into equal sizes and randomly selected without replacement. To obtain one error
estimate we will take one of the folds in the training data to be the validation set and train on the
remaining folds. This will be repeated for each fold so that we will obtain m error estimates. Next,
the average of all the error estimates will be taken and will define the cross-validation error rate
for that model.

# 1 Overview of the Data
The training and test data used in this project comes from two sources in a zip file (digits.zip). In
each data set there is a collection of grayscale images of scanned zip code digits. Each one the
images shows only one digit. For each file there are 257 entries, where the first entry is the digit
label and the rest are the pixel values in the 16 x 16 grayscale image. In the training file there are
7291 observations and in the testing file there are 2007.

# 2 Explore Digits Data
## 2.1 Average appearance of Digits
To obtain how the appearance of the digits look on average we will obtain the average value for
each pixel. First, we will group the data by labels so we can see how the digits look on average
for each label. There are 256 pixels for each digit and by finding the mean 

![screen shot 2019-02-21 at 12 11 19 am](https://user-images.githubusercontent.com/32987017/53153514-4cefc480-356d-11e9-8390-be3fecbbd122.png)

## 2.2 Pixel values for classification

![screen shot 2019-02-21 at 12 11 26 am](https://user-images.githubusercontent.com/32987017/53153522-51b47880-356d-11e9-944b-b2ecfdb4e00d.png)

In order to determine which pixels are most and least useful for classification we can use
variance. If the variance for a certain pixel (i.e.- column) is high, then that means the values in
for that pixel differ often for different observations. We expect the value for a particular column
to be the same across observations (i.e.- rows) if the label for those rows are the same, and if the
labels are different then we would expect the value for that pixel to be different. Thus, the
variance is high, then that means that pixel is used by different labels to distinguish them from
the others. So, a high variance pixel would be useful for classification.
From the image, we see that the pixels with higher variance are those that tend to be more
centered, whereas the pixels on the outside and edge areas tend to have lower variance. This is
true, because darker sections are an indication of higher variance. Therefore, we can conclude
that the pixels centered are more likely to be used for classification and those farther from the
center are least likely to be of help.

## 3 Cross Validation Error Function
For our cross-validation algorithm, cv_error_knn, we will be using our predict_knn function as
our model. The algorithm will be using 10 folds, where each fold serves as the validation set.
Prior, to obtaining the folds for training and validation, the training data set was randomized and
sampled without replacement until the number of desired folds was obtained.

### 3.1 Making cv_error_knn Efficient

#### Addressing Redundant Code
After randomizing the rows of our training data and splitting into m-equal folds, we want to be
able to select one of those folds, set it to be the validation set, then obtain an error estimate when
that particular fold is chosen to be the validation set. However, we want all folds to serve as the
validation set. An efficient implementation of looping can be done through the lapply function,
which loops over a list. From this, we will obtain an error estimate for each fold being selected to
be the validation.

#### Excluding the Distance Matrix from the Function
Calculating the distance matrix can take some time. While initially, the first thought is to put the
code that computes the distance matrix inside the function, this is inefficient. Because when
calling cv_error_knn the distance matrix used will always be the same, so the code will run
quicker if every time the function is called, it does not have to compute the matrix but rather
takes it as an argument. So, no matter how many time the function is called the distance matrix
for a particular distance method is computed once but can be used as many times as needed.

#### Make predict_knn Efficient
Since predict_knn is the model used for our cv_error_knn, it is important that we make that
function efficient too. To make this function efficient, we used similar approaches used in the
cv_error_knn function. This includes, utilization of vectorization or apply functions to avoid
redundant code and unnecessary for loops which could slow our code down. Also, the
unrandomized distance matrix for predict_knn is outside the function, so we would not have to
compile the distance matrix multiple times as it takes some time to run.

## 4 Ten-Fold Cross-Validation Error Rates
As mentioned earlier, the number of folds that will be used for the cross-validation error rates
will be 10. Increasing the number of folds decreases the bias, but variance increases too as m
increases since the folds are dependent on each other. The k values used will be from 1 to 15 and
the two distance metrics used to calculate distances will be the Euclidean and Manhattan.
### 4.1 10-Fold CV Error Rates

![screen shot 2019-02-21 at 12 11 34 am](https://user-images.githubusercontent.com/32987017/53153526-537e3c00-356d-11e9-8bdb-da93d9d5f625.png)

### 4.2 Best Distance Metric and K
From here we see that the best distance metric for this data set would depend on the level of k,
because as we can see from the plot, depending on which value of k is selected, the error rate can
be lower for either the Euclidean or Manhattan distance method. So, given a particular value of
k, we can however, select which distance metric would be best.
With that said, there appears no clear best combination of k and distance metric, because as k
increases not only does the error rate increase, but the better model continues to switch. Also, it
would not be useful to consider larger values of k. Although, considering larger values of k
would decrease variance, it would also increase bias. By keeping the value of k low we would
have a low bias model with a minimal error rate. Just keep in mind that the model will also have
high variance.

### 4.3 Considering Additional Values of K
When we answer this question this question, we should keep in mind of the bias-variance
tradeoff and the fact that as k increases the kNN tends to choose the majority class for all
predictions. This means that that small changes to the prediction point can lead to vastly different
changes in our prediction. For example, if k = 1, then we would have a high variance model.
Overall, if k is low, i.e.- 1, the variance of the model will be high and as k increases the bias of
our model will increase, which would mean the model would tend to choose what from the
majority of the neighbors and take that as the label, which may be off the target label.

## 5 Error Rates
To compute the error rates, the two distance methods used will be the Euclidean and the
Manhattan.

![screen shot 2019-02-21 at 12 11 41 am](https://user-images.githubusercontent.com/32987017/53153529-5547ff80-356d-11e9-9068-92def11ccd6d.png)

### 5.1 Comparing CV Error Rates to Test Error Rates
From here, we see that the Euclidean is the best distance method for our model across all values
of k. In addition, the test error rates are lower than the cross-validation error rates. Also, unlike
the cross-validation error rates which tend to increase as k increases, we see that for the
Euclidean error as the k increases it sometimes decreases the error rate. Also, it becomes
apparent that the best combination of k and distance method would be 4 and Euclidean. Since 
increasing k to 4 will reduce the variance and error rate, but it is not increased too high so that
the bias is too high.
