class Pokemon

  attr_reader :name, :type, :id, :db, :hp

  def initialize(props = {})
    @name = props['name']
    @type = props['type']
    @id = props['id']
    @hp = props['hp']
    @db = props['db']
  end

  def self.save(name, type, db)
    sql_string = <<-SQL_STRING
      INSERT INTO pokemon (name, type) VALUES (?, ?)
    SQL_STRING

    db.execute(sql_string, name, type)
  end

  def self.find(id, db)
    sql_string = <<-SQL_STRING
      SELECT * FROM pokemon WHERE id = ?
    SQL_STRING

    pokemon_array = db.execute(sql_string, id)
    id = pokemon_array[0][0]
    name = pokemon_array[0][1]
    type = pokemon_array[0][2]
    hp = pokemon_array[0][3]

    new_pokemon = Pokemon.new('id' => id, 'name' => name, 'type' => type, 'hp' => hp)

  end

  def alter_hp(hp, db)

    sql_string = <<-SQL_STRING
      UPDATE pokemon SET hp = ? WHERE id = ?
    SQL_STRING

    db.execute(sql_string, hp, self.id)

  end

end
