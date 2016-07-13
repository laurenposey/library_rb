require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/book')
require('./lib/patron')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'library_test'})

get('/') do
  erb(:index)
end

get('/books') do
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
