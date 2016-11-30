class Item < ActiveRecord::Base
    has_many :transactions, class_name: 'Transaction', foreign_key: 'item_id'
    serialize :transactions, JSON
end
