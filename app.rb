require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/book')
require('./lib/patron')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'library'})

get('/') do
  erb(:index)
end

get('/books') do
  @books = Book.all()
  erb(:books)
end

get('/books/new') do
  erb(:books_form)
end

post('/books/new') do
  @title = params.fetch('title')
  @author = params.fetch('author')
  new_book = Book.new({:title => @title, :author => @author})
  new_book.save()
  erb(:success)
end

get('/book/:id') do
  @book = Book.find_book(params.fetch('id').to_i())
  erb(:book)
end

get('/book/:id/update') do
  @book = Book.find_book(params.fetch("id").to_i())
  erb(:update_book_form)
end

patch('/book/:id/update') do
  title = params.fetch('title')
  author = params.fetch('author')
  @book = Book.find_book(params.fetch('id').to_i())
  @book.update_title({:title => title})
  @book.update_author({:author => author})
  erb(:book)
end

post('/book/:id/update') do
  @title = params.fetch('title')
  @author = params.fetch('author')
  new_book = Book.new({:title => @title, :author => @author})
  new_book.save()
  erb(:success)
end

delete("/book/:id/delete") do
  @book = Book.find_book(params.fetch("id").to_i())
  @book.delete_book()
  erb(:success)
end
