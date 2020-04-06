class AddEntityToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_reference :addresses, :entity, polymorphic: true, index: true
  end
end
