class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.string :japanese
      t.string :korean
      t.string :example
      t.string :fq 

      t.timestamps
    end
  end
end
