class ChangeCertificateDniToString < ActiveRecord::Migration[5.2]
  def change
    change_column :certificates, :dni, :string, limit: 50
  end
end
