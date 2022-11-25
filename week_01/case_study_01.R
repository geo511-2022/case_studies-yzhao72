# load the iris dataset
data(iris)
# Calculate the mean of the Petal.Length field and save it as an object named petal_length_mean
x = iris$Petal.Length
petal_length_mean = mean(x)
petal_length_mean
# Plot the distribution of the Petal.Length column as a histogram
library(ggplot2)
histogram = ggplot(data=iris, aes(x))
histogram + geom_histogram(binwidth=0.2, color="black", aes(fill=Species)) + 
  xlab("Petal Length") +  ylab("Frequency") + ggtitle("Histogram of Petal Length")
