module Spree
  class Size < Spree::Base
    validates :name, presence: true
  end
end