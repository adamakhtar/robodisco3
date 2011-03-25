# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
@admin_role = Role.find_or_create_by_name(:name => "admin")

User.find_or_create_by_username(:username => "robodisco", :email => "adamtemporary@googlemail.com", :password => "secrets", :password_confirmation => "secrets")
@admininstrator = User.find_or_create_by_username(:username => "adam", :email => "adamsubscribe@googlemail.com", :password => "secrets", :password_confirmation => "secrets")
@admininstrator.roles << @admin_role
@admininstrator.save






