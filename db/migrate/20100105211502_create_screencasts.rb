class CreateScreencasts < ActiveRecord::Migration
  def self.up
    create_table :screencasts do |t|
      t.references :product, :format
      t.integer :duration
      t.integer :size # in Megabytes
      t.string :preview_url
      t.integer :revision

      t.timestamps
    end
  end

  def self.down
    drop_table :screencasts
  end
end
