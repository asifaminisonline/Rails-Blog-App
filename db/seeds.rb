# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(name: 'Tom', photo: 'https://www.istockphoto.com/vector/businessman-icon-vector-symbol-for-web-flat-design-gm1390193778-447241583', bio: 'Teacher from Mexico.')
User.create(name: 'Lilly', photo: 'https://www.istockphoto.com/vector/businessman-avatar-icon-gm1298227218-391128738', bio: 'Teacher from Poland.')
User.create(name: 'Tobin', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher.')
User.create(name: 'Mwape', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Zambia.')


Post.create(author_id: 1, title: 'Hello', text: 'This is my first post')
Post.create(author_id: 2, title: 'Hello World', text: 'This is my second post')
Post.create(author_id: 1, title: 'Hello', text: 'This is my Third post')
Post.create(author_id: 1, title: 'Hello', text: 'This is my fourth post')

Comment.create(post_id: 1, author_id: 1, text: 'Hi Tom!' )
Comment.create(post_id: 2, author_id: 2, text: 'Hi Tom!')
Comment.create(post_id: 2, author_id: 2, text: 'Hi Tobin!')
Comment.create(post_id: 2, author_id: 2, text: 'Hi Microverse')
Comment.create(post_id: 2, author_id: 2, text: 'Hi Student success')
Comment.create(post_id: 2, author_id: 2, text: 'Hello Rails')
