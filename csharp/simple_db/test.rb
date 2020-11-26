def run
  db = Connection.new
  db.create_table('authors', name: :string)
  db.create_table('books', title: :string, description: :string, author_id: :integer)

  db.insert(:authors, name: 'a1')
  db.insert(:books, title: 'sicp', author_id: 1)

  q_author = db.query(:authors, "name like 'xxx'")
  db.query(:books)
  
end
