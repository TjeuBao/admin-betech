class GenerateSlugsForExistingPostsAndCareers < ActiveRecord::Migration[6.0]
  def change
    Post.find_each(&:save)
    Career.find_each(&:save)
  end
end
