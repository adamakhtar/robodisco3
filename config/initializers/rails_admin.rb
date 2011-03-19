RailsAdmin.config do |config|
  config.model User do
    list do
      field :username
      field :email
      field :created_at
    end
  end
end

RailsAdmin.authorize_with :cancan

