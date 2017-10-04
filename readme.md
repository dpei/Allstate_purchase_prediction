# Allstate Purchase Prediction Challenge 


## Usage:

## Project Description: 
### Project Goal: 
Allstate group initiated a Purchase Prediction Challenge on Kaggle on 2014. Below is the challenge description from Kaggle page [1]:

As a customer shops an insurance policy, he/she will receive a number of quotes with different coverage options before purchasing a plan. This is represented in this challenge as a series of rows that include a customer ID, information about the customer, information about the quoted policy, and the cost. Your task is to predict the purchased coverage options using a limited subset of the total interaction history. If the eventual purchase can be predicted sooner in the shopping window, the quoting process is shortened and the issuer is less likely to lose the customer’s business. 
Using a customer’s shopping history, can you predict what policy they will end up choosing?

One customer may quote several times before buying a car insurance policy. Things they may tweak during this process including their demographic information and/or their coverage option. For example, they may provide additional information on car value. They may also change their deductible amount. 

### Significance: 

From the perspective of insurance company, this challenge aims to predict what coverage option a customer will buy based on their quote history. This prediction is important because it allows insurance company guess what customer may like and it can be use for recommendation. A good recommendation can probably increase the number of people who buy Allstate’s insurance. In addition, if the recommendation performs well in early stage of quote, customer can spend much less time to buy a insurance in Allstate and thus increase the company profitability.

### Explorative analysis
[Two datasets](http://www.kaggle.com/c/allstate-purchase-prediction-challenge/data) were provided: train.csv and test.csv 

Each row represents one quote. One customer could have multiple quotes. To distinguish quotes within one customer. the variable shopping_point was used, Their demographic information and their coverage option were recorded in each row. Each column contains one demographic information or coverage option.
(pics/allstate-viz-1.png)

By analyzing the distribution of last shopping point number, we could know how much quotes people took before they buy. 
it is shown that the of shopping point 
Each customer has many  

Task: 
Action: what’s the method
Result: performance
## Methods:
Remove features
Create additional feature
Majority vote for GBM, random forest and SVM. 
Iterate over several combinations.
change G as the only strategy

Results:


Discussion:
The prediction from my model is 
The increase of prediction of best model is
is very limited.









Below are examples 
For my project, I entered the "[Allstate Purchase Prediction Challenge](http://www.kaggle.com/c/allstate-purchase-prediction-challenge)" on Kaggle. In this competition, the goal is to predict the exact car insurance options purchased by individual customers. The data available for training a model is the history of car insurance quotes that each customer reviewed before making a purchase, the options they actually purchased (the "purchase point"), and data about the customer and their car. The data available for testing was identical to the training set, except it was a different set of customers, the purchase point was excluded (since it was the value to be predicted), and an unknown number of quotes were also excluded.

For a prediction on a given customer to be counted as correct, one must successfully predict the value for all seven options, and each option has 2 to 4 possible values. Therefore, one could treat this as a classificiation problem with over 2,000 possible classes.


## Hypotheses

At the start of the competition, I came up with two hypotheses:

1. I hypothesized that smart feature engineering and feature selection would be more important than the usage of advanced machine learning techniques. This hypothesis was partially based on [readings](http://homes.cs.washington.edu/~pedrod/papers/cacm12.pdf) from the course, and partially based on necessity (my toolbox of machine learning techniques is somewhat limited!)

2. I hypothesized that there would be patterns in the data that I could use to my advantage, which would not necessarily even require machine learning. Here are some examples of patterns that I hypothesized:
	* Customers buying the last set of options they were quoted
	* Customers reviewing a bunch of different options, and simply choosing the set of options that they looked at the most number of times
	* Customers reviewing a bunch of different options, and simply choosing the set of options that was the cheapest
	* Individual options that are highly correlated (e.g., if A=1, then perhaps B is almost always 0)
	* Sets of options that are "illegal" (e.g., if C=1, then perhaps D cannot be 2)
	* Sets of options that are extremely common for a given customer characteristic (e.g., families with young kids always choose E=0 and F=2)
