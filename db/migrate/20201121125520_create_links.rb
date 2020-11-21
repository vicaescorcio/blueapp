class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :original, null: false
      t.bigint :short_id
      t.integer :hits, default: 0

      t.timestamps
    end
  end
end
