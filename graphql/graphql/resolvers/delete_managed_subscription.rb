require 'graphql'
require_relative '../types/ms_type'

class DeleteManagedSubcription < GraphQL::Function
  # arguments passed as "args"
  argument :tenant_id, types.String
  argument :subscription_id, types.String
  argument :subscription_source, types.String

  # return type from the mutation
  type Types::ManagedSubscriptionType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context (which would be discussed later)
  def call(_obj, args, _ctx)
    m = ManagedSubscription.find_by(tenant_id: args[:tenant_id])

    m.destroy unless m.nil?
  end
end
