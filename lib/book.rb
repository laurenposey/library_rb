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
      books.push(Book.new({:title => title, :author => author}))
    end
    books
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title, author) VALUES ('#{@title}', '#{@author}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_book|
    self.title().==(another_book.title()).&(self.author().==(another_book.author()))
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
