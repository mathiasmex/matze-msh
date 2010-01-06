class Photo < ActiveRecord::Base
  def picture_file= (image_data)
    if image_data != ""
      self.filename = image_data.original_filename
      self.content_type = image_data.content_type.chomp
      self.binary_data = image_data.read
    end
  end
end