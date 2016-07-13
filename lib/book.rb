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
    book = DB.exec("INSERT INTO books (title, author) VALUES ('#{@title}', '#{@author}');")
  end

  define_method(:==) do |another_book|
    self.title().==(another_book.title()).&(self.author().==(another_book.author()))
  end

end
