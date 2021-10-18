class Movie < ActiveRecord::Base
    def self.all_ratings
        return ["G", "PG", "PG-13", "R", "NC-17"]
    end
    
    def movies_with_same_director
        return Movie.where({director: self.director})
    end
end
