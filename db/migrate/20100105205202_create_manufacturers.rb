class CreateManufacturers < ActiveRecord::Migration
  def self.up
    create_table :manufacturers do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
    Manufacturer.create(:name => "Joomla",
                    :description => "The dynamic portal engine and content management system")
    Manufacturer.create(:name => "SilverStripe",
                    :description => "Open Source CMS / Framework")
    Manufacturer.create(:name => "Ruby on Rails",
                    :description => "Open Source web application framework")
  end

  def self.down
    drop_table :manufacturers
  end
end
