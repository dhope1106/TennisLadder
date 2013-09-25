class AddAcceptedToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :accepted, :boolean
  end
end
