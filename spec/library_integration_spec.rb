require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the index path', {:type => :feature}) do
  it('displays the add new patron and add new book links') do
    visit('/')
    expect(page).to have_content("Welcome!")
  end
end

describe('the add a book path', {:type => :feature}) do
  it('lets a librarian add a book to the database') do
    visit('/')
    click_link('Add a new book')
    expect(page).to have_content("Welcome to the Books page")
    fill_in('title', :with => "Test Title")
    fill_in('author', :with => "Test Author")
    click_button('Add book')
    expect(page).to have_content("Test Title")
  end
end

describe('the add a patron path', {:type => :feature}) do
  it('lets a librarian add a patron to the database') do
    visit('/')
    click_link('Add a new patron')
    expect(page).to have_content("Welcome to the Patron page")
    fill_in('name', :with => "Test Name")
    click_button('Add patron')
    expect(page).to have_content("Test Name")
  end
end

describe('the list the book path', {:type => :feature}) do
  it('lets a librarian view all books') do
    visit('/books')
    expect(page).to have_content("Welcome to the Books page")
    fill_in('title', :with => "Test Title")
    fill_in('author', :with => "Test Author")
    click_button('Add book')
    expect(page).to have_content("Test Title")
  end
end


describe('the update a book path', {:type => :feature}) do
  it('lets a librarian update book info') do
    visit('/books')
    fill_in('title', :with => "Test Title")
    fill_in('author', :with => "Test Author")
    click_button('Add book')
    expect(page).to have_content("Test Title")
    click_link("Test Title")
    expect(page).to have_content("Test Title")
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
    fill_in('title', :with => "Test Title")
    fill_in('author', :with => "Test Author")
    click_button('Add book')
    expect(page).to have_content("Test Title")
    click_link("Test Title")
    expect(page).to have_content("Test Title")
    click_link("Update")
    expect(page).to have_content("Update book info")
    click_button('Delete Book')
    expect(page).to have_content('Book has been')
  end
end
