# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Good.delete_all
Order.delete_all

Good.create(name: 'County pizza',
            price: 8,
            weight: 0.7,
            discription: 'Tasty pizza',
            img: '/assets/pizza1.jpg',
            category: 'pizza',
            insale: true)

Good.create(name: 'Italy pizza',
            price: 9,
            weight: 0.7,
            discription: 'Original pizza from Italy',
            img: '/assets/pizza2.jpg',
            category: 'pizza',
            insale: true)

Good.create(name: 'Meat pizza',
            price: 8,
            weight: 0.7,
            discription: 'In this perfect pizza presents only meat and little piece of chease',
            img: '/assets/pizza3.jpg',
            category: 'pizza',
            insale: true)

Good.create(name: 'Super burger',
            price: 5,
            weight: 0.4,
            discription: 'Really big burger',
            img: '/assets/burger1.jpg',
            category: 'burger',
            insale: true)

Good.create(name: 'Little burger',
            price: 3,
            weight: 0.2,
            discription: 'Not a really big burger',
            img: '/assets/burger2.jpg',
            category: 'burger',
            insale: true)

Good.create(name: 'Roman cake',
            price: 11,
            weight: 0.5,
            discription: 'This cake was design by Kamonomin II',
            img: '/assets/cake1.jpg',
            category: 'cake',
            insale: true)

Good.create(name: "Sushi 'Taro'" ,
            price: 13,
            weight: 0.6,
            discription: "Sushi 'Taro' right from Japan",
            img: '/assets/sushi1.jpg',
            category: 'sushi',
            insale: true)

Good.create(name: 'Water',
            price: 2,
            weight: 0.75,
            discription: 'Bottle of water',
            img: '/assets/water 1.jpg',
            category: 'drink',
            insale: true)

Good.create(name: 'Cola',
            price: 5,
            weight: 0.75,
            discription: 'Drink with a lot of sugar',
            img: '/assets/cola1.jpg',
            category: 'drink',
            insale: true)

puts 'Success: Goods data loaded'
