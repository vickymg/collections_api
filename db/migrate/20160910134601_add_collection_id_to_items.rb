class AddCollectionIdToItems < ActiveRecord::Migration
  def change
    add_reference :items, :collection, index: true, foreign_key: true
  end
end
