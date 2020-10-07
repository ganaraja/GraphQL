
require 'graphql'
require_relative 'query'
require_relative 'mutation'

GraphAppSchema = GraphQL::Schema.define do
  query QueryType
  mutation MutationType
end
