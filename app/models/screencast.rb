class Screencast < ActiveRecord::Base
  belongs_to :product, :dependent => :destroy
  belongs_to :format
end
