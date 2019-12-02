class RemoveIndexEmailFromUsers < ActiveRecord::Migration[5.2]
  def change
    def change
      remove_index :users, column: :email, unique: true
    end
  end
end
