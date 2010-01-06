class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :manufacturer
  belongs_to :photo, :dependent => :destroy

  validates_presence_of :name, :description, :price,
                        :category, :manufacturer
  validates_uniqueness_of :name

end
