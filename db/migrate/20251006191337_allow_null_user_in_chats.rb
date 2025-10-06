class AllowNullUserInChats < ActiveRecord::Migration[7.1]
  def change
    change_column_null :chats, :user_id, true
  end
end
