class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
    Category.create(:name => "Basics",
                    :description => "Basic webprogramming")
    Category.create(:name => "Advanced",
                    :description => "CMS based webprogramming")
    Category.create(:name => "Professional",
                    :description => "Special webprogramming")
    Category.create(:name => "Tutorials",
                    :description => "Learning by doing")
    Category.create(:name => "Snippets",
                    :description => "Tips and Tricks")
  end

  def self.down
    drop_table :categories
  end
end
