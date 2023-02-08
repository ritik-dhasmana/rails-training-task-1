class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.string :body 
      t.date :date_published 
      t.string :category
      t.timestamps
    end
  end
end
