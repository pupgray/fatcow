class User < ApplicationRecord
  has_icon :user, show: { star: -> { !name.nil? } }, form: { wrench: -> { name == 'special' } }
end
