

To run a program you can access online environment using link: https://ide.c9.io/povilasa/kmeans. 
Unfortunately you will not be able to open this environment unless you have ```cloud9``` account. If you don't have account there you might run the code in your machine. To do that you need ```Ruby``` and testing gem ```Rspec```. You may install it with:

```gem install rspec```

I have not used any specific gems for this algorithm so I hope you will not need to install anything else.

To run tests you can run:

```rspec spec_kmeans.rb```

Tests include unit tests for small, low-level methods and also includes integration tests for each task (A, B, C). **Attention!** Test in `spec_kmeans.rb:21` takes couple of minutes. 

Data used for examples was generated using `R`. 2D plot is attached in this email (`Rplot.png`).

Now I will shortly summarize each task:

- **A**

Algorithm for `vectors` data might be run using command:

```ruby
results = Algorithms.kmeans(vectors, clusters, distance, seed)
```

Performance of the algorithm might be calculated using command:

```ruby
Results.performance(vectors, results, k)
```

For given dataset (`vector.json`) model has about 80 percent accuracy.


- **B**

To automatically determine number of clusters `k` I used cross validation method. The idea here is that if algorithm should be able to return very similar results (accuracy) for all subsets of the dataset. This means that algorithm is stable and not overfitted. I decided to run `kmeans` algorithm for different training sets using different `k` and collect all performance results. The best `k` is determined using metric:

```ruby
mean(performances)/standard_deviation(performances) 
```

The higher this metrics is, the better `k` was selected.

All this can be done using command:

```ruby
k_best = Results.cross_validation(vectors, distance, iterations, size, seed)
```

This `k_best` might be used to compute final model with automatically selected `k`.

```ruby
results = Algorithms.kmeans(vectors, k_best, distance, seed)
```

For different `seed` algorithm might return different results but in this case it usually returned same results as it was in **A** (`k_best = 3` and 80 percent accuracy).


- **C**

To use apriori information about data distribution I decided to use different distance function. I chose Mahalanobi distance instead of Euclidean distance. This metric calculates distance between two vectors using covariance matrix of those vectors. This short [paragraph](https://en.wikipedia.org/wiki/Mahalanobis_distance#Relationship_to_normal_random_variables) briefly summarizes why this metric is proper for normal distribution data. 

Unfortunately Ruby does not have any function to calculate Mahalanobis distance. Or installation of libraries that contains that function are complicated. To calculate it manually it requires lots of other mathematical functions such as covariance matrix and inverse matrix. So I was not able to compute that. Probably other programming language would be better choice for this particular situation. But I did not expect to have this kind of problem.
