require('pry-byebug')
require_relative('../db/sql_runner')
require_relative('movie')
require_relative('star')

class Casting

  def initialize(options)
    @movie_id= options['movie_id']
    @star_id= options['star_id']
    @star_fee= options['star_fee'].to_i()
    @id = options['id'].to_i() if options['id']
  end

  def save()
    sql= "INSERT INTO castings
          (movie_id, star_id, star_fee)
          VALUES
          ($1, $2, $3)
          RETURNING id"
    values= [@movie_id, @star_id, @star_fee]
    @id= SqlRunner.run(sql, values).first()['id']
  end

  def self.all()
    sql= "SELECT * FROM castings"
    results= SqlRunner.run(sql)
    return Casting.map_out(results)
  end

  def self.map_out(sql_results)
    return sql_results.map{|result| Casting.new(result)}
  end

  def update()
    sql = "
    UPDATE castings SET (
      movie_id,
      star_id,
      star_fee) =
    ($1,$2, $3)
    WHERE id = $4"
    values= [@movie_id, @star_id, @star_fee, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM castings where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM castings"
    SqlRunner.run(sql)
  end

  def self.display_all_stars_by_movie(movie_id)
    sql= "SELECT stars.* FROM stars
          INNER JOIN castings
          ON castings.star_id = stars.id
          WHERE movie_id = $1"
    values= [movie_id]
    stars= SqlRunner.run(sql, values)
    return Star.map_out(stars)
  end

  def self.display_all_movies_by_star(star_id)
    sql= "SELECT movies.* FROM movies
          INNER JOIN castings
          ON castings.movie_id = movies.id
          WHERE star_id = $1"
    values= [star_id]
    movies= SqlRunner.run(sql, values)
    return Movie.map_out(movies)
  end


end
