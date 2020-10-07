require 'graphql'
require_relative 'types/ms_type'

QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema"

  field :managed_subscriptions, types[Types::ManagedSubscriptionType] do
    argument :tenant_id, types.String
    description "Get a list of managedsubscriptions"
    resolve ->(_obj, args, _ctx) {
      if args[:tenant_id]
        ManagedSubscription.where(tenant_id: args[:tenant_id])
      else
        ManagedSubscription.all
      end
    }
  end
end
