
require 'graphql'

module Types
  ManagedSubscriptionType = GraphQL::ObjectType.define do
    name 'ManagedSubscription'
    description 'Resembles a ManagedSubscription Object Type'

    field :id, !types.ID
    field :tenant_id, types.String
    field :subscription_id, types.String
    field :subscription_source, types.String
  end
end
