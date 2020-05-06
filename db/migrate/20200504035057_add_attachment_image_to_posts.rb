class AddAttachmentImageToPosts < ActiveRecord::Migration[4.2]
  def up
    add_attachment :posts, :image
  end

  def down
    remove_attachment :posts, :image
  end
end
