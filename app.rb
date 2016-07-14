require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/book')
require('./lib/patron')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'library'})

get('/') do
  @books = Book.all()
  @patrons = Patron.all()
  erb(:index)
end

get('/books') do
  @books = Book.all()
  erb(:books)
end

post('/books') do
  title = params.fetch("title")
  author = params.fetch("title")
  book = Book.new({:title => title, :author => author, :id => nil})
  book.save()
  @books = Book.all()
  erb(:books)
end

get('/patrons') do
  @patrons = Patron.all()
  erb(:patrons)
end

post("/patrons") do
  name = params.fetch("name")
  patron = Patron.new({:name => name, :id => nil})
  patron.save()
  @patrons = Patron.all()
  erb(:patrons)
end

get("/books/:id") do
  @book = Book.find_book(params.fetch("id").to_i())
  @patrons = Patron.all()
  erb(:book_info)
end

get("/patrons/:id") do
  @patron = Patron.find_patron(params.fetch("id").to_i())
  @books = Book.all()
  erb(:patron_info)
end

patch("/books/:id") do
  book_id = params.fetch("id").to_i()
  @book = Book.find_book(book_id)
  patron_ids = params.fetch("patron_ids")
  @book.update({:patron_ids => patron_ids})
  @patrons = Patron.all()
  erb(:book_info)
end

patch("/patrons/:id") do
  patron_id = params.fetch("id").to_i()
  @patron = Patron.find_patron(patron_id)
  book_ids = params.fetch("book_ids")
  @patron.update({:book_ids => book_ids})
  @books = Book.all()
  erb(:patron_info)
end


get('/books/:id/update') do
  @book = Book.find_book(params.fetch("id").to_i())
  erb(:update_book_form)
end

patch('/books/:id/update') do
  title = params.fetch('title')
  author = params.fetch('author')
  @book = Book.find_book(params.fetch('id').to_i())
  @book.update({:title => title, :author => author})
  @books = Book.all()
  erb(:books)
end

post('/books/:id/update') do
  @title = params.fetch('title')
  @author = params.fetch('author')
  new_book = Book.new({:title => @title, :author => @author})
  new_book.save()
  erb(:success)
end

delete("/books/:id/delete") do
  @book = Book.find_book(params.fetch("id").to_i())
  @book.delete_book()
  @books = Book.all()
  erb(:success)
end
