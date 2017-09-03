class CreateAircities < ActiveRecord::Migration[5.0]
  def change
    create_table :aircities do |t|

      t.string :name
      t.string :pinyin
      t.string :aqi
      t.timestamps
    end
      add_index :aircities ,:pinyin
  end
end
