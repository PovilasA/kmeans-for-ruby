require './kmeans'
require 'json'

RSpec.describe Algorithms do
  describe 'kmeans' do
    
    def read_vectors_json
      file = File.read('vectors.json')
      JSON.parse(file)
    end
  
    # Integration test for task A
    it 'with euclidean distance returns correct performance' do
      vectors = read_vectors_json
      results = Algorithms.kmeans(vectors, 3, 'euclidean', 100)
      expect(Results.performance(vectors, results, 3)).to be_within(0.01).of(0.8)
    end
    
    # Integration test for task B
    # This might take a while... Get a cup of tea or coffee :)
    it 'runs with k determined using cross validation' do #UNCOMMENT!!!
      vectors = read_vectors_json
      k_best = Results.cross_validation(vectors, 'euclidean', 10, 1.to_f/3, 101)
      expect(k_best).to eq(3)
      results = Algorithms.kmeans(vectors, k_best, 'euclidean',  1)
      expect(Results.performance(vectors, results, k_best)).to be_within(0.01)
        .of(0.8)
    end
    
    describe 'auxiliary methods' do
      describe 'euclidean_distance' do
        it 'works for one dimension vectors (integers)' do
          expect(Algorithms.euclidean_distance(2,5)).to eq(3)
        end
        
        it 'works for multidimensional vectors' do
          expect(Algorithms.euclidean_distance([2,4], [5,8])).to eq(5)
        end
      end
      
      it 'vectors_average calculates average for each element' do
        expect(Algorithms.vectors_average([[1,2,3], [4,5,6]]))
        .to eq([2.5,3.5,4.5])
      end
    end
  end
  
  describe Results do
    describe 'performance' do
      it 'json_results return proper hash' do
        results = [[[1, 2], [3, 4]],[[5, 6]]]
        expect(Results.json_results(results))
          .to eq([{ x: 1, y: 2, class: 1 },
                  { x: 3, y: 4, class: 1 },
                  { x: 5, y: 6, class: 2 }])
      end
      
      it 'permutations return all possible permutations' do
        expect(Results.permutations(3)).to eq(
          [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]])
      end
      
      it 'permute_results changes class names according to given permutation' do
        results = [{ x: 1, y: 2, class: 1 },
                   { x: 3, y: 4, class: 2 },
                   { x: 5, y: 6, class: 3 }]
        permutation = [3, 1, 2]
        expect(Results.permute_results(results, permutation))
          .to eq([{ x: 1, y: 2, class: 3 },
                  { x: 3, y: 4, class: 1 },
                  { x: 5, y: 6, class: 2 }])
      end
    end
  end
end
