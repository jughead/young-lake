# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
City.create!([
  {name: 'Petrozavodsk'},
  {name: 'Moscow'},
  {name: 'Saint-Petersburg'},
  {name: 'London'}
])

Theme.create!([
  {name: 'IT'},
  {name: 'Ruby'},
  {name: 'Ruby on Rails'},
  {name: 'PHP'},
  {name: 'Yii'},
  {name: 'Sports'},
  {name: 'Politics'},
  {name: 'Religion'},
  {name: 'Food and drinks'},
  {name: 'Software development'},
])
