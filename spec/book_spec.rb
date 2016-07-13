require('spec_helper')

describe(Book) do
  describe('#title') do
    it('will display the books title') do
      test_book = Book.new({:title => 'Emma', :author => 'Jane Austin', :id => nil})
      expect(test_book.title()).to(eq('Emma'))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('will save the book') do
      test_book = Book.new({:title => 'Pride and Prejudice', :author => 'Jane Austin', :id => nil})
      test_book.save()
      expect(Book.all()).to(eq([test_book]))
    end
  end

  describe('#==') do
    it('is the same book if the info matches') do
      book1 = Book.new({:title => 'Pride and Prejudice', :author => 'Jane Austin', :id => nil})
      book2 = Book.new({:title => 'Pride and Prejudice', :author => 'Jane Austin', :id => nil})
      expect(book1).to(eq(book2))
    end
  end

  describe('.find_book') do
    it("returns a book based on its id") do
      book1 = Book.new({:title => "Test Title", :author => "Test Author", :id => nil})
      book2 = Book.new({:title => "Test Title2", :author => "Test Author2", :id => nil})
      book1.save()
      book2.save()
      expect(Book.find_book(book1.id)).to(eq(book1))
    end
  end

  describe("#update_title") do
    it("lets you update a book title") do
      book = Book.new({:title => "Test Title", :author => "Test Author", :id => nil})
      book.save()
      book.update_title({:title => "New Title"})
      expect(book.title()).to(eq("New Title"))
    end
  end

  describe("#update_author") do
    it("lets you update a book author") do
      book = Book.new({:title => "Test Title", :author => "Test Author", :id => nil})
      book.save()
      book.update_author({:author => "Test Author"})
      expect(book.author()).to(eq("Test Author"))
    end
  end
end
