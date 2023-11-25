# frozen_string_literal: true

class AddAddressPartyAndImage < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :address, :string
    add_column :representatives, :party, :string
  end
end
