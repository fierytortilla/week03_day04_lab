require('pry-byebug')
require_relative('../db/sql_runner')

class Star

  attr_reader :first_name, :last_name, :id

  def initialize(options)
    @first_name= options['first_name']
    @last_name= options['last_name']
    @id = options['id'].to_i() if options['id']
  end

  def save()
    sql= "INSERT INTO stars
          (first_name, last_name)
          VALUES
          ($1, $2)
          RETURNING id"
    values= [@first_name, @last_name]
    @id= SqlRunner.run(sql, values).first()['id']
  end

  def self.map_out(sql_results)
    return sql_results.map{|result| Star.new(result)}
  end

  def self.all()
    sql= "SELECT * FROM stars"
    results= SqlRunner.run(sql)
    return Star.map_out(results)
  end

  def update()
    sql = "
    UPDATE stars SET (
      first_name,
      last_name) =
    ($1,$2)
    WHERE id = $3"
    values= [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM stars where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM stars"
    SqlRunner.run(sql)
  end

end
