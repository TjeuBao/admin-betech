class AddGitRepoTrelloToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :git_repo, :string
    add_column :projects, :trello, :string
  end
end
