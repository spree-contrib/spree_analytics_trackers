class AddSecondIdToSpreeTrackers < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_trackers, :second_analytics_id, :string
    add_column :spree_trackers, :purchase_id, :string
  end
end
