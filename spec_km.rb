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
    
    describe 'auxiliary methods' do
      describe 'euclidean_distance' do
        it 'works for one dimension vectors (integers)' do
          expect(Algorithms.euclidean_distance(2,5)).to eq(3)
        end
        
        it 'works for multidimensional vectors' do
          expect(Algorithms.euclidean_distance([2,4], [5,8])).to eq(5)
        end
        
        it 'vectors_average calculates average for each element' do
          expect(Algorithms.vectors_average([[1,2,3], [4,5,6]]))
          .to eq([2.5,3.5,4.5])
        end
      end
    end
  end
end