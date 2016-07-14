class Patron
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each do |patron|
      name = patron.fetch('name')
      id = patron.fetch('id').to_i()
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    patrons
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_patron|
    self.id() == another_patron.id()
  end

  define_singleton_method(:find_patron) do |id|
    patron = DB.exec("SELECT * FROM patrons WHERE id = #{id};")
    name = patron.first().fetch('name')
    id = patron.first().fetch('id').to_i()
    patron = Patron.new({:name => name, :id => id})
    patron
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:book_ids, []).each() do |book_id|
      DB.exec("INSERT INTO patron_book (book_id, patron_id) VALUES (#{book_id}, #{self.id()});")
    end
  end

  define_method(:delete_patron) do
    DB.exec("DELETE FROM patron_book WHERE patron_id = #{self.id()};")
    DB.exec("DELETE FROM patrons WHERE id = #{self.id()};")
  end

  define_method(:books) do
    patron_books = []
    results = DB.exec("SELECT book_id FROM patron_book WHERE patron_id = #{self.id()};")
    results.each() do |result|
      book_id = result.fetch("book_id").to_i()
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      title = book.first().fetch("title")
      author = book.first().fetch("author")
      patron_books.push(Book.new({:title => title, :author => author, :id => book_id}))
    end
    patron_books
  end

end
