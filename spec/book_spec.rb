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
end
