class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :attachmentable, polymorphic: true  


  private

    def self.assign_attachments(params, object)
    if params
      params.split(",").each do |attachment|
        attachment = Attachment.find(attachment)
        attachment.attachmentable = object if attachment.attachmentable_id == nil
        attachment.save
      end
    end
  end
  
end
