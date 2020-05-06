class AddAttachmentImageToCareers < ActiveRecord::Migration[4.2]
  def up
    add_attachment :careers, :image
  end

  def down
    remove_attachment :careers, :image
  end
end
