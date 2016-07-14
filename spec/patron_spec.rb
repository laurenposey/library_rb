require('spec_helper')

describe(Patron) do
  describe('#name') do
    it('will display the patron name') do
      test_patron = Patron.new({:name => 'Emma', :id => nil})
      expect(test_patron.name()).to(eq('Emma'))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('will save the patron') do
      test_patron = Patron.new({:name => 'Emma', :id => nil})
      test_patron.save()
      expect(Patron.all()).to(eq([test_patron]))
    end
  end

  describe('#==') do
    it('is the same patron if the info matches') do
      patron1 = Patron.new({:name => 'Emma', :id => nil})
      patron2 = Patron.new({:name => 'Emma', :id => nil})
      expect(patron1).to(eq(patron2))
    end
  end

  describe('.find_patron') do
    it("returns a patron based on its id") do
      patron1 = Patron.new({:name => "Emma", :id => nil})
      patron2 = Patron.new({:name => "Emma", :id => nil})
      patron1.save()
      patron2.save()
      expect(Patron.find_patron(patron1.id)).to(eq(patron1))
    end
  end

  describe("#update") do
    it("lets you update patrons in the database") do
      patron = Patron.new({:name => "Test Name", :id => nil})
      patron.save()
      patron.update({:name => "New Name"})
      expect(patron.name()).to(eq("New Name"))
    end

    it("lets you add a book to a patron") do
      patron = Patron.new({:name => "Emma", :id => nil})
      patron.save()
      book1 = Book.new({:title => "Test Title", :author => "Test Author", :id => nil})
      book1.save()
      book2 = Book.new({:title => "Test Title2", :author => "Test Author2", :id => nil})
      book2.save()
      patron.update({:book_ids => [book1.id(), book2.id()]})
      expect(patron.books()).to(eq([book1, book2]))
    end
  end

  describe("#books") do
    it("returns all the books checked out by a particular patron") do
      patron = Patron.new({:name => "Emma", :id => nil})
      patron.save()
      book1 = Book.new({:title => "Test Title", :author => "Test Author", :id => nil})
      book1.save()
      book2 = Book.new({:title => "Test Title2", :author => "Test Author2", :id => nil})
      book2.save()
      patron.update({:book_ids => [book1.id(), book2.id()]})
      expect(patron.books()).to(eq([book1, book2]))
    end

    it("returns a due date for checked out books") do
      patron = Patron.new({:name => "Emma", :id => nil})
      patron.save()
      book1 = Book.new({:title => "Test Title", :author => "Test Author", :id => nil})
      book1.save()
  end

  describe("#delete_patron") do
    it("lets you remove a patron from the database") do
      patron1 = Patron.new({:name => "Emma", :id => nil})
      patron2 = Patron.new({:name => "Lauren", :id => nil})
      patron1.save()
      patron2.save()
      patron1.delete_patron()
      expect(Patron.all()).to(eq([patron2]))
    end
  end

end
