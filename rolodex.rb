require_relative "contact"

class Rolodex
  @contacts = []
  @id = 1000

  def self.add_contact(contact)
    contact.id = @id
    @contacts << contact
    @id += 1
  end

  def self.contacts
    @contacts
  end

def self.print_attribute(num)
  case num
  when 1
    @contacts.each{|x| puts "#{x.first_name}"}

  when 2
    @contacts.each{|x| puts "#{x.last_name}"}

  when 3
    @contacts.each{|x| puts "#{x.email}"}

  when 4
    @contacts.each{|x| puts "#{x.note}"}

  when 5
    @contacts.each{|x| puts "#{x.id}"}

  else
    puts "That's not an option."
  end

end


end