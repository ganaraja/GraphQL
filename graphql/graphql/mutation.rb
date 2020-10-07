
require 'graphql'
require_relative 'types/ms_type'
require_relative 'resolvers/create_managed_subscription'
require_relative 'resolvers/update_managed_subscription'
require_relative 'resolvers/delete_managed_subscription'

MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createManagedSubcription, function: CreateManagedSubcription.new
  field :updateManagedSubcription, function: UpdateManagedSubcription.new
  field :deleteManagedSubcription, function: DeleteManagedSubcription.new
end
