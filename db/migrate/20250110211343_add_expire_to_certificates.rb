class AddExpireToCertificates < ActiveRecord::Migration[5.2]
  def change
    add_column :certificates, :expire, :boolean, default: true
  end
end
