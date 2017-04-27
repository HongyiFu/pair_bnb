class User < ApplicationRecord
  include Clearance::User
  enum gender: [:undefined, :male, :female]
end
