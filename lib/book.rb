class Book
  attr_reader(:title, :author, :id)

  define_method (:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each do |book|
      title = book.fetch('title')
      author = book.fetch('author')
      id = book.fetch('id').to_i()
      books.push(Book.new({:title => title, :author => author, :id => id}))
    end
    books
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title, author) VALUES ('#{@title}', '#{@author}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_book|
    self.id() == another_book.id()
  end

  define_singleton_method(:find_book) do |id|
    book = DB.exec("SELECT * FROM books WHERE id = #{id};")
    title = book.first().fetch('title')
    author = book.first().fetch('author')
    id = book.first().fetch('id').to_i()
    Book.new({:title => title, :author => author, :id => id})
  end

  define_method(:update) do |attributes|
    @title = attributes.fetch(:title, @title)
    @author = attributes.fetch(:author, @author)
    @id = self.id()
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id};")
    DB.exec("UPDATE books SET author='#{@author}' WHERE id=#{@id};")

    attributes.fetch(:patron_ids, []).each() do |patron_id|
      DB.exec("INSERT INTO patron_book (book_id, patron_id) VALUES (#{self.id()}, #{patron_id});")
    end
  end

  define_method(:delete_book) do
    DB.exec("DELETE FROM patron_book WHERE book_id = #{self.id()};")
    DB.exec("DELETE FROM books WHERE id=#{self.id()};")
  end

  define_method(:patrons) do
    book_patrons = []
    results = DB.exec("SELECT patron_id FROM patron_book WHERE book_id = #{self.id()};")
    results.each() do |result|
      patron_id = result.fetch("patron_id").to_i()
      patron = DB.exec("SELECT * FROM patrons WHERE id = #{patron_id};")
      name = patron.first().fetch("name")
      book_patrons.push(Patron.new({:name => name, :id => patron_id}))
    end
    book_patrons
  end
end
