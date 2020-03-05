require('pry-byebug')
require_relative('../db/sql_runner')

class Movie

  attr_reader :title, :id
  attr_accessor :genre

  def initialize(options)
    @title= options['title']
    @genre= options['genre']
    @id = options['id'].to_i() if options['id']
  end

  def save()
    sql= "INSERT INTO movies
          (title, genre)
          VALUES
          ($1, $2)
          RETURNING id"
    values= [@title, @genre]
    @id= SqlRunner.run(sql, values).first()['id']
  end

  def self.all()
    sql= "SELECT * FROM movies"
    results= SqlRunner.run(sql)
    return Movie.map_out(results)
  end

  def self.map_out(sql_results)
    return sql_results.map{|result| Movie.new(result)}
  end

  def update()
    sql = "
    UPDATE movies SET (
      title,
      genre) =
    ($1,$2)
    WHERE id = $3"
    values= [@title, @genre, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM movies where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end


end
