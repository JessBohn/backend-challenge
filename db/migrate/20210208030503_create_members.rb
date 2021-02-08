class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.string :name
      t.text :website
      t.text :tags, array: true, default: []

      t.timestamps
    end
  end
end
