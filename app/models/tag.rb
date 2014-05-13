class Tag < ActiveRecord::Base

  after_validation :tag_exist?

  validates :name, presence: :true, length: { maximum: 20 }
  belongs_to :question


  def tag_exist?
    if Tag.exists?(name: "#{self.name}")
      self.errors.add(:name, "Tag already exist!")
      raise ActiveRecord::Rollback
    end
  end
end