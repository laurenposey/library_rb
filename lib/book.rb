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
    book = Book.new({:title => title, :author => author, :id => id})
    book
  end

  define_method(:update_title) do |attributes|
    @title = attributes.fetch(:title)
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id};")
  end

  define_method(:update_author) do |attributes|
    @author = attributes.fetch(:author)
    @id = self.id()
    DB.exec("UPDATE books SET author='#{@author}' WHERE id=#{@id};")
  end

end
