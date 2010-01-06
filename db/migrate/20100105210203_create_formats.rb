class CreateFormats < ActiveRecord::Migration
  def self.up
    create_table :formats do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
    Format.create(:name => "800x600",
                    :description => "Standard format")
    Format.create(:name => "1280x800",
                    :description => "Modern format")
  end

  def self.down
    drop_table :formats
  end
end
