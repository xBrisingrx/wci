class ChangeCertificateDniIntToBigInt < ActiveRecord::Migration[5.2]
  def change
    change_column :certificates, :dni, :bigint
  end
end
