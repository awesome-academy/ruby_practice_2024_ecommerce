class Order < ApplicationRecord
  belongs_to :user
  belongs_to :receiver_info
  has_many :order_details

  enum status: {
    pending: "pending",
    shipping: "shipping",
    completed: "completed",
    cancelled: "cancelled"
  }

  scope :search_by_receiver_name, lambda {|query|
    joins(:receiver_info).where("receiver_infos.name LIKE ?", "%#{query}%")
  }

  scope :filter_by_status, lambda {|status|
    where(status: status) if status.present?
  }

  scope :filter_by_date, lambda {|start_date, end_date|
    where(date_place_order: start_date..end_date) if start_date.present? && end_date.present?
  }
end
