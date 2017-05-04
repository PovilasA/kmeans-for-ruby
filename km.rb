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
end