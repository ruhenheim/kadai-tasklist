# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include ApplicationHelper

# 自分用アカウントと、そのテストデータ
user = User.create(name: "akira uchiyama", email: "user@example.com", password: "techacademy")
(1..100).each do |number|
  Task.create(user: user, status: status_select_list[rand(3)], content: 'test content ' + number.to_s)
end

# ダミーユーザ用アカウントと、そのテストデータ
10.times do |c|
  _name = "test" + c.to_s
  user = User.create(name: _name, email: "#{_name}@test.jp", password: "test")
  100.times do |m|
    _content = "test post " + m.to_s
    user.tasks.create(content: _content, status: status_select_list[rand(3)])
  end
end
