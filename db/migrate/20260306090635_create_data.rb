class CreateData < ActiveRecord::Migration[8.0]
  def change
    create_table :data do |t|
      t.string :content
      t.string :data_type
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
