require('pry-byebug')
require_relative('models/movie')
require_relative('models/star')
require_relative('models/casting')

Star.delete_all()
Movie.delete_all()
Casting.delete_all()

star1= {'first_name'=>'Cary', 'last_name'=> 'Grant'}
star2= {'first_name'=>'Tommy', 'last_name'=> 'Wiseau'}
star3= {'first_name'=>'Angelina', 'last_name'=>'Jolie'}
star4= {'first_name'=>'Eva Marie', 'last_name'=>'Saint'}

star1= Star.new(star1)
star2= Star.new(star2)
star3= Star.new(star3)
star4= Star.new(star4)

star1.save()
star2.save()
star3.save()
star4.save()

movie1= {'title'=>'North by Northwest', 'genre'=>'Thriller'}
movie2= {'title'=>'The Room', 'genre'=> 'GENIUS'}
movie3= {'title'=>'Tomb Raider', 'genre'=>'Action'}

movie1= Movie.new(movie1)
movie2= Movie.new(movie2)
movie3= Movie.new(movie3)

movie1.save()
movie2.save()
movie3.save()

movie2.genre = "WORST"

movie2.update()

casting1= {'movie_id'=> movie1.id, 'star_id'=> star1.id, 'star_fee'=>20000}
casting2= {'movie_id'=> movie2.id, 'star_id'=> star2.id, 'star_fee'=>1000000}
casting3= {'movie_id'=> movie3.id, 'star_id'=> star3.id, 'star_fee'=>5000000}
casting4= {'movie_id'=> movie1.id, 'star_id'=> star4.id, 'star_fee'=>10}


casting1= Casting.new(casting1)
casting2= Casting.new(casting2)
casting3= Casting.new(casting3)
casting4= Casting.new(casting4)

casting1.save()
casting2.save()
casting3.save()
casting4.save()

stars_in_north_by_northwest= Casting.display_all_stars_by_movie(movie1.id)

Casting.display_all_movies_by_star(star2.id)



binding.pry()
nil
