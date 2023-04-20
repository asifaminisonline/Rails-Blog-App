# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

first_user = User.create(name: 'Utsargo Roy', photo: 'https://avatars.githubusercontent.com/u/6623974?v=4',
                         bio: 'Full-Stack Developer')

second_user = User.create(name: 'John Michael Doe',
                          photo: 'https://media.gettyimages.com/id/1301087492/vector/semi-random-rainbow-colored-60-60-60-triangle-pattern.jpg?s=612x612&w=gi&k=20&c=pb_dh_VF6L5IgOk4rsbfqM7zIjTA4VA3NxZoiqpJMcs=', bio: 'Front-End Developer')

first_post = Post.create(title: 'First Post', text: 'This is my first post', author_id: first_user.id)

second_post = Post.create(title: 'Second Post', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis lobortis mi libero, et hendrerit ante vulputate auctor. Vestibulum tortor nunc, vestibulum ut erat eu, fermentum sodales mauris. Fusce sit amet nisl vitae enim egestas eleifend quis vel sem. Sed laoreet sapien sed ex semper commodo. Cras lacinia erat facilisis enim vehicula commodo. Etiam vitae lectus ut velit rhoncus sagittis sit amet et diam. Phasellus ut orci vel augue rutrum porttitor. Mauris accumsan, nulla non ullamcorper lobortis, dui mauris luctus augue, nec luctus sem ex facilisis lacus. Quisque fringilla urna libero, vel pretium arcu fermentum et. Morbi facilisis justo posuere dapibus lacinia. Sed tempus, tortor non placerat imperdiet, dui est feugiat dui, in porta neque orci ac ligula. Sed eu gravida velit.


    Donec elementum, massa at commodo vestibulum, lectus ipsum congue nibh, sit amet egestas nunc lacus vitae nisl. Morbi sed libero nec eros accumsan aliquet. Sed imperdiet vulputate porttitor. Suspendisse potenti. Nullam hendrerit mollis elementum. Donec gravida metus commodo, hendrerit ex a, convallis libero. Morbi at nunc sit amet tellus consectetur interdum. Vivamus sodales erat vitae ante sagittis pellentesque eget ac ligula. Etiam sed lacus et quam tempus aliquam. In orci nulla, ornare quis nisl id, ultrices mollis sem. Curabitur eleifend bibendum tellus, eget finibus sem scelerisque auctor. Vivamus sem orci, elementum id mauris nec, mattis tempus neque. Duis in luctus massa, interdum condimentum ipsum. Duis non bibendum nibh.

    Aenean ac tincidunt tortor, ut faucibus orci. Duis viverra a eros nec mollis. Aenean nec erat molestie, imperdiet enim rhoncus, pulvinar orci. Pellentesque nec lectus at nunc scelerisque pellentesque. Vestibulum vehicula ornare lobortis. Aliquam ullamcorper molestie orci, ut volutpat lorem maximus vel. Curabitur non bibendum ex. Nullam id porta quam, ut elementum odio. Donec sit amet sapien eu lorem placerat rhoncus vitae eget purus. Suspendisse ac nulla lorem.

    ', author_id: first_user.id)

third_post = Post.create(title: 'Third Post', text: 'This is my third post', author_id: second_user.id)

fourth_post = Post.create(title: 'Fourth Post', text: 'This is my fourth post', author_id: first_user.id)

first_comment = Comment.create(post: first_post, author: first_user, text: 'This is my first comment')

second_comment = Comment.create(post: second_post, author: first_user, text: 'This is my second comment')

third_comment = Comment.create(post: second_post, author: first_user, text: 'Awesome Post')
fourth_comment = Comment.create(post: first_post, author: second_user, text: 'Nice writeup')
fifth_comment = Comment.create(post: second_post, author: first_user, text: 'Really nice post')
sixth_comment = Comment.create(post: second_post, author: first_user, text: 'I love ruby')
seventh_comment = Comment.create(post: first_post, author: second_user, text: 'Amazing post!!!')
eighth_comment = Comment.create(post: second_post, author: first_user, text: 'Wow!')
ninth_comment = Comment.create(post: first_post, author: second_user, text: 'Love it')

like = Like.create(author: first_user, post: second_post)
like_two = Like.create(author: second_user, post: second_post)
like_two = Like.create(author: second_user, post: first_post)
