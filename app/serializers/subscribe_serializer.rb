class SubscribeSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :name,
              :email,
              :subscribe_type
end
