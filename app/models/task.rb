class Task < ApplicationRecord
    has_many :data_list, class_name: "Datum", dependent: :destroy
end
