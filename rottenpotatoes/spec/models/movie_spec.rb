require "rails_helper"
require "movie"

describe Movie do
    before(:all) do
        @movies = Movie.create([{:title => "Star Wars", :rating => "PG", :director => "George Lucas", :release_date => "1977-05-25"},{:title => "Blade Runner", :rating => "PG", :director => "Ridley Scott", :release_date => "1982-06-25"},{:title => "Alien", :rating => "R", :release_date => "1979-05-25"},{:title => "THX-1138", :rating => "R", :director => "George Lucas", :release_date => "1971-03-11"}])
    end
    
    describe "#movies_with_same_director" do
        context "given that a movie has a director" do
            it "returns each and every movie with the same director" do
                expect(Movie.find_by_title("Star Wars").movies_with_same_director.all.count).to eq 2
                expect(Movie.find_by_title("Star Wars").movies_with_same_director.all.count).to include(Movie.find_by_title("Star Wars"), Movie.find_by_title("THX-1138"))
                expect(Movie.find_by_title("Blade Runner").movies_with_same_director.all.count).to eq 1
                expect(Movie.find_by_title("Blade Runner").movies_with_same_director).to include(Movie.find_by_title("Blade Runner"))
            end
        end
        
        context "given that a movie does not have a director" do
            it "does not return any movies" do
                expect(Movie.find_by_title("Alien").movies_with_same_director.all.count).to eq 0
            end
        end
    end
end