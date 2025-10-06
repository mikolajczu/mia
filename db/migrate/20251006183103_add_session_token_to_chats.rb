class AddSessionTokenToChats < ActiveRecord::Migration[7.1]
  def change
    add_column :chats, :session_token, :string
    add_index :chats, :session_token
  end
end
