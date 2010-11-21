class AddTokenToAuthorizations < ActiveRecord::Migration
  def self.up
    add_column :authorizations, :token, :string
    add_column :authorizations, :secret, :string
  end

  def self.down
    remove_column :authorizations, :secret
    remove_column :authorizations, :token
  end
end
