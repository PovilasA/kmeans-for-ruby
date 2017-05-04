class Algorithms
  def self.kmeans(vectors, clusters, distance, seed)
    
    # Setting seed to be able to reproduce results.
    r = Random.new(seed)
    
    cc = Array.new(clusters) { [] }
    m = Array.new(clusters) { [r.rand, r.rand] }
    clusters_arr = Array.new(clusters) { |i| i }
    x = vectors.map { |v| v.values[0..1] }
    
    loop  do
      dd = Array.new(clusters) { [] }
      vectors.each_index do |j|
        d = Array.new(clusters)
        clusters_arr.each do |k|
          d[k] = euclidean_distance(m[k], x[j]) if distance == 'euclidean'
          d[k] = mahalanobis_distance(m[k], x[j]) if distance == 'mahalanobis'
        end
        dd[d.rindex(d.min)] << x[j]
      end
    
      break if cc == dd
      new_m = dd.map { |d| vectors_average(d) }
  
      # Ensuring that each element in new_m is not an empty array.
      new_m.each_index do |i|
        new_m[i] = m[i] if new_m[i].empty?
      end
      m = new_m
      cc = dd
    end
    cc
  end
  
  def self.euclidean_distance(p1, p2)
    p1 = [p1] unless p1.is_a?(Array)
    p2 = [p2] unless p2.is_a?(Array)
    sum_of_squares = 0
    p1.each_with_index do |p1_coord,index| 
      sum_of_squares += (p1_coord - p2[index]) ** 2 
    end
    Math.sqrt( sum_of_squares )
  end
  
  def self.vectors_average(vectors)
    vectors.transpose.map {|x| x.reduce(:+)/vectors.size.to_f}
  end
end

class Results
  def self.performance(vectors, results, n_of_clusters)
    results = json_results(results)
    
    # Class names in vectors (or in data) could be different comparing to class
    # names in results. So we have to try every possible combination of class
    # names in results. Trying all possible combinations computationally is
    # probably not the best option but it is good enough for small k.
    
    # Permutation that produces best performance will be interpreted
    # as a performance of a model.
    
    perf = []
    permutations(n_of_clusters).each do |permutation|
      correct, incorrect = [0, 0]
      vectors.each do |v|
        match_result = permute_results(results, permutation)
          .select { |r| r[:x] == v['x'] && r[:y] == v['y'] }[0]
        v['class'] == match_result[:class] ? correct += 1 : incorrect += 1
      end
      perf << correct.to_f/(correct + incorrect)
    end
    perf.max
  end
  
  def self.json_results(results)
    json_type_results = []
    results.each_with_index do |result, i|
      result.each do |r|
        json_type_results << { 'x': r[0], 'y': r[1], 'class': i+1 }
      end
    end
    json_type_results
  end
  
  def self.permutations(n)
    array =*(1..n)
    array.permutation(n).to_a
  end
  
  def self.permute_results(results, permutation)
    res = []
    results.each do |r|
      res << { 'x': r[:x], 'y': r[:y], 'class': permutation[r[:class]-1] }
    end
    res
  end
end