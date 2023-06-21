Admin.create!(
  email: 'k@k',
  password: '123456'
)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tag.create([
  { name: '栄養満点' },
  { name: '簡単' },
  { name: '時短' },
  { name: 'コスパ◎' },
  { name: '洋風' },
  { name: '中華風' },
  { name: '和風' },
  { name: 'おもてなし' }
])