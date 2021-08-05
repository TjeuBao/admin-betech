# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Tech.create([
    {
        name: "Rails",
        tech_type: 1
    },
    {
        name: "ReactJS",
        tech_type: 0
    },
    {
        name: "NodeJS",
        tech_type: 1
    },
    {
        name: "PHP",
        tech_type: 1
    },
])

DevelopmentType.create([
    {
        name: "Mobile IOS"
    },
    {
        name: "Mobile Android"
    },
    {
        name: "Website"
    },
])
