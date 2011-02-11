# Read about factories at http://github.com/thoughtbot/factory_girl
Factory.define :album do |f|
  f.title "MyString"
  f.artist "MyString"
  f.sequence(:mb_id){ |i| "3F2504E0-4F89-11D3-9A0C-0305E82C330#{i}" }
end
