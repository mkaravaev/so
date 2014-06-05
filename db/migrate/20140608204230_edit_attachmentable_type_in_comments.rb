class EditAttachmentableTypeInComments < ActiveRecord::Migration
  def change
    change_column :attachments, :attachmentable_type, :string
  end
end
