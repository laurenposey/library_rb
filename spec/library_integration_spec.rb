require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the index path', {:type => :feature}) do
  it('displays a button for librarians') do
    visit('/')
    expect(page).to have_content("I'm a librarian!")
    click_link("I'm a librarian!")
    expect(page).to have_content("Add a book to the database!")
  end
end

describe('the add the book path', {:type => :feature}) do
  it('lets a librarian add a book to the database') do
    visit('/books/new')
    expect(page).to have_content("Add a book to the database!")
    fill_in('title', :with => "Test Book")
    fill_in('author', :with => "Test Author")
    click_button('Add Book')
    expect(page).to have_content("Book has been added to database!")
  end
end

describe('the list the book path', {:type => :feature}) do
  it('lets a librarian view all books') do
    visit('/books/new')
    expect(page).to have_content("Add a book to the database!")
    fill_in('title', :with => "Test Title")
    fill_in('author', :with => "Test Author")
    click_button('Add Book')
    expect(page).to have_content("Book has been added to database!")
    visit('/books')
    expect(page).to have_content('Test Title')
  end
end

describe('view the book page', {:type => :feature}) do
  it('lets a librarian see an individual book') do
    visit('/books')
    click_link("Add a book to the database!")
    expect(page).to have_content("Add a book to the database!")
    fill_in('title', :with => "Test Title")
    fill_in('author', :with => "Test Author")
    click_button('Add Book')
    expect(page).to have_content("Book has been added to database!")
    click_link("Back")
    expect(page).to have_content("Test Title")
    click_link("Test Title")
    expect(page).to have_content("Book Info")
  end
end

describe('the update book path', {:type => :feature}) do
  it('lets a librarian update book info') do
    visit('/books')
    click_link("Add a book to the database!")
    expect(page).to have_content("Add a book to the database!")
    fill_in('title', :with => "Test Title")
    fill_in('author', :with => "Test Author")
    click_button('Add Book')
    expect(page).to have_content("Book has been added to database!")
    click_link("Back")
    expect(page).to have_content("Test Title")
    click_link("Test Title")
    expect(page).to have_content("Book Info")
    click_link("Update")
    expect(page).to have_content("Update book info")
    fill_in('title', :with => "New Title")
    fill_in('author', :with => "New Author")
    click_button('Update')
    expect(page).to have_content('New Title')
  end
end

describe('the delete book path', {:type => :feature}) do
  it('lets a librarian delete a book') do
    visit('/books')
    click_link("Add a book to the database!")
    expect(page).to have_content("Add a book to the database!")
    fill_in('title', :with => "Test Title")
    fill_in('author', :with => "Test Author")
    click_button('Add Book')
    expect(page).to have_content("Book has been added to database!")
    click_link("Back")
    expect(page).to have_content("Test Title")
    click_link("Test Title")
    expect(page).to have_content("Book Info")
    click_link("Update")
    expect(page).to have_content("Update book info")
    click_button('Delete Book')
    expect(page).to have_content('Book has been')
  end
end
