class ManagedSubscription < ActiveRecord::Base
  validates :tenant_id, presence: true
end
