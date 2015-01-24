class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :source
      t.string :caption

      t.timestamps
    end
  end
end
