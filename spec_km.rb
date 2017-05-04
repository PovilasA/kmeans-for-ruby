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
      end
    end
  end
end