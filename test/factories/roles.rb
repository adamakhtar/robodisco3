# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :role do |f|
  f.sequence(:name) {|i| "role-#{i}" }
end
