require_relative "contact"
require_relative "rolodex"

class CRM

  attr_accessor :name

  def initialize(name_sent_in)
    @name = name_sent_in
  end

  def print_main_menu
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display all the contacts"
    puts "[5] Display an attribute" 
    puts "[6] Exit"
    puts "Enter a number: "
  end

  def main_menu
    print_main_menu
    user_selected = gets.to_i
    call_option(user_selected)
    until user_selected == 6 do 
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def add_new_contact
    print "Enter First Name: "
    first_name = gets.chomp
    print "Enter Last Name: "
    last_name = gets.chomp
    print "Enter Email Address: "
    email = gets.chomp
    print "Enter a Note: "
    note = gets.chomp
    contact = Contact.new(first_name, last_name, email, note)
    Rolodex.add_contact(contact)
    puts "\e[H\e[2J"
  end

  def modify_existing_contact
    puts "Whose information would you like to modify?"
    single_contact = gets.chomp

    puts "Enter the element you would like to change."
    puts"[1] First Name"
    puts"[2] Last Name"
    puts"[3] Email"
    puts"[4] Note"
    to_modify = (gets.chomp.to_i)
    puts "Enter the new value."
    modification = gets.chomp
    puts "\e[H\e[2J"
  
    
    Rolodex.contacts.each do |x|
      if x.first_name == single_contact || x.last_name == single_contact
        case to_modify
        when 1
          puts "It was #{x.first_name}"
          x.first_name = modification 
          puts "Now it's #{x.first_name}"
        when 2
         puts "It was #{x.last_name}"
         x.last_name = modification
         puts "Now it's #{x.last_name}"
         when 3
         puts "It was #{x.email}"
         x.email = modification
         puts "Now it's #{x.email}"
         when 4
         puts "It was #{x.note}"
         x.note = modification
         puts "Now it's #{x.note}"
        else
          puts "That's not an option"
        end
      end
    end
  end

  def delete_a_contact
    puts "Whose information would you like to delete?"
    to_delete = gets.chomp

    Rolodex.contacts.each do |x|
      if x.first_name == to_delete || x.last_name == to_delete
        x.first_name = nil
        x.last_name = nil
        x.email = nil
        x.note = nil
      else
        puts "That entry does not exist."

      end
    end
    puts "\e[H\e[2J"
  end

  def display_all_contacts
    puts "\e[H\e[2J"
    Rolodex.contacts.each do|x|
      puts "#{x.last_name},   #{x.first_name},  Email: #{x.email};  Note: #{x.note}"
    end
  end

  def display_an_attribute
    puts "\e[H\e[2J"
    puts "Enter the type of element you would like to see."
    puts"[1] First Name"
    puts"[2] Last Name"
    puts"[3] Email"
    puts"[4] Note"
    display_val = (gets.chomp.to_i)
  
    puts "Whose?"
    single_contact = gets.chomp
    puts "\e[H\e[2J"
    Rolodex.contacts.each do |x|
      if x.first_name == single_contact || x.last_name == single_contact
        case display_val
        when 1
         puts "#{x.first_name}"
        when 2
         puts "#{x.last_name}"
         when 3
         puts "#{x.email}"
         when 4
         puts "#{x.note}"
        else
          puts "That's not an option"
        end
      end
    end
  end

  # def exit_program
  #   puts "Implement me"
  # end


  def call_option(user_selected)
    add_new_contact if user_selected == 1
    modify_existing_contact if user_selected == 2
    delete_a_contact if user_selected == 3
    display_all_contacts if user_selected == 4
    display_an_attribute if user_selected == 5
    #exit_program if user_selected == 6
  
    # Finish off and do the rest for 3 through 6
    # To be clear, the methods add_new_contact and modify_existing_contact
    # haven't been defined yet
  end

end



my_crm = CRM.new("First CRM")

my_contact = Contact.new("Adrian", "Carton de Wiart", "adianwiart@gmail.com", "Even cooler.")
contact2 = Contact.new("Esteban", "Robo", "123@thewolf.com", "He's an asshole")
contact3 = Contact.new("Ralph", "Huckster", "getatme@supercool.com", "Super genuine")

my_rolodex = Rolodex.new





my_crm.main_menu


