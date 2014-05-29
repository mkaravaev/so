class CreateTagsQuestions < ActiveRecord::Migration
  def change
    drop_table :tags_questions
    create_table :tags_questions do |t|
      t.integer :tag_id
      t.integer :question_id
      t.timestamps
    end
  end
end
