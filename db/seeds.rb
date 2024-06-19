# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Role.create(name: 'admin')
Role.create(name: 'consumer')
Role.create(name: 'creator')

User.create(email: 'admin@example.com', password: 'password')
User.create(email: 'consumer@example.com', password: 'password')
User.create(email: 'creatorconsumer@example.com', password: 'password')

user = User.find_by(email: 'admin@example.com')
user.roles << Role.find_by(name: 'admin')
user = User.find_by(email: 'consumer@example.com')
user.roles << Role.find_by(name: 'consumer')
user = User.find_by(email: 'creatorconsumer@example.com')
user.roles << Role.find_by(name: 'creator')
user.roles << Role.find_by(name: 'consumer')
