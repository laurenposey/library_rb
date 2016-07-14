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

  describe("#update") do
    it("lets you update a book title") do
      book = Book.new({:title => "Test Title", :author => "Test Author", :id => nil})
      book.save()
      book.update({:title => "New Title"})
      expect(book.title()).to(eq("New Title"))
    end

    it("lets you update a book author") do
      book = Book.new({:title => "Test Title", :author => "Test Author", :id => nil})
      book.save()
      book.update({:author => "Test Author"})
      expect(book.author()).to(eq("Test Author"))
    end

    it("lets you add a patron to a book") do
      patron = Patron.new({:name => "Grace Hopper", :id => nil})
      patron.save()
      book = Book.new({:title => "How to Program", :author => "Ada Lovelace", :id => nil})
      book.save()
      book.update({:patron_ids => [patron.id()]})
      expect(book.patrons()).to(eq([patron]))
    end
  end

  describe("#delete_book") do
    it("lets you remove a book from the database") do
      book1 = Book.new({:title => "Test Title", :author => "Test Author", :id => nil})
      book2 = Book.new({:title => "Test Title2", :author => "Test Author2", :id => nil})
      book1.save()
      book2.save()
      book1.delete_book()
      expect(Book.all()).to(eq([book2]))
    end
  end

  describe("#patrons") do
    it("returns all of the patrons who have checked a particular book") do
      patron = Patron.new({:name => "Grace Hopper", :id => nil})
      patron.save()
      patron2 = Patron.new({:name => "Ada Lovelace", :id => nil})
      patron2.save()
      book = Book.new({:title => "Python", :author => "Lauren Posey", :id => nil})
      book.save()
      book.update(:patron_ids => [patron.id()])
      book.update(:patron_ids => [patron2.id()])
      expect(book.patrons()).to(eq([patron, patron2]))
    end
  end

end
