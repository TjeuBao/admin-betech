class SubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :name,
              :email,
              :subscription_type
end
