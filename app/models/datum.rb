class Datum < ApplicationRecord
  belongs_to :task
  has_one_attached :file
  def opener
    class_name = "#{data_type.camelize}Opener"
    class_name.constantize.new(self)
  end
end
