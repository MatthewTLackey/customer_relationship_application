require_relative "contact"
require_relative "rolodex"

class CRM

  attr_accessor :name

  def initialize(name_sent_in)
    @name = name_sent_in
  end

  def print_main_menu
    puts "What would you like to do?"
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display all the contacts"
    puts "[5] Display a specific attribute"
    puts "[6] Display a specific contact"
    puts "[7] Display all entries of an attribute"
    puts "[8] Exit"
    puts "Enter a number: "
  end

  def main_menu
    puts "\e[H\e[2J"
    print_main_menu
    user_selected = gets.to_i
    call_option(user_selected)
    until user_selected == 8 do

      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def add_new_contact
    puts "\e[H\e[2J"
    print "Enter First Name: "
    first_name = gets.chomp
    print "Enter Last Name: "
    last_name = gets.chomp
    print "Enter Email Address: "
    test_email = gets.chomp
    until /\w+[@]\w+[.]\w+/.match(test_email)
      puts "That's not a valid email address."
      puts "Enter a new Email address:"
      test_email = gets.chomp
    end
    email = test_email
    print "Enter a Note: "
    note = gets.chomp
    contact = Contact.new(first_name, last_name, email, note)
    Rolodex.add_contact(contact)
    puts "\e[H\e[2J"
  end

  def modify_existing_contact
    puts "\e[H\e[2J"
    display_all_contacts
    puts "Whose information would you like to modify?"
    single_contact = gets.chomp
    if confirm_change?
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
        if x.first_name == single_contact || x.last_name == single_contact || x.id.to_s == single_contact
          case to_modify
          when 1
            puts "It was #{x.first_name}"
            puts "It will be #{modification}"
            x.first_name = modification if confirm_change?
            puts "Now it's #{x.first_name}"
          when 2
           puts "It was #{x.last_name}"
           puts "It will be #{modification}"
           x.last_name = modification if confirm_change?
           puts "Now it's #{x.last_name}"
           when 3
           puts "It was #{x.email}"
           puts "It will be #{modification}"
           x.email = modification if confirm_change?
           puts "Now it's #{x.email}"
           when 4
           puts "It was #{x.note}"
           puts "It will be #{modification}"
           x.note = modification if confirm_change?
           puts "Now it's #{x.note}"
          else
            puts "That's not an option"
          end
        end
      end
    end
  end

  def delete_a_contact
    puts "\e[H\e[2J"
    display_all_contacts
    puts "Whose information would you like to delete?"
    to_delete = gets.chomp

    Rolodex.contacts.each do |x|
      if x.first_name == to_delete || x.last_name == to_delete || x.id.to_s == to_delete
        puts "This will delete:"
        puts "#{x.last_name}, #{x.first_name}"
      end
    end

    Rolodex.contacts.delete_if{|x| ((x.first_name == to_delete || x.last_name == to_delete || x.id.to_s == to_delete) && confirm_change?)}
      
        # x.first_name = nil
        # x.last_name = nil
        # x.email = nil
        # x.note = nil
    
  end

  def display_all_contacts
    puts "\e[H\e[2J"
    puts "The current contacts are:"
    Rolodex.contacts.each do|x|
      puts "Id: #{x.id} #{x.last_name},   #{x.first_name},  Email: #{x.email};  Note: #{x.note}"
    end
  end

  def display_an_attribute
    puts "\e[H\e[2J"
    second_menu
    display_val = (gets.chomp.to_i)
    
    puts "Whose?"
    single_contact = gets.chomp

    Rolodex.contacts.each do |x|
      if x.first_name == single_contact || x.last_name == single_contact || x.id.to_s == single_contact
        case display_val
        when 1
          puts "#{x.first_name}"
        when 2
          puts "#{x.last_name}"
        when 3
          puts "#{x.email}"
        when 4
          puts "#{x.note}"
        when 5
          puts "#{x.id}"
        else
          puts "That's not an option"
        end
      end
    end
  end

  def display_particular_contact
    puts "\e[H\e[2J"
    puts "Which contact would you like to display?"
    puts "Enter an ID number or name"
    which_contact = gets.chomp
    Rolodex.contacts.each do |x|
      if x.first_name == which_contact || x.last_name == which_contact || x.id.to_s == which_contact
        puts "#{x.id}: #{x.last_name}, #{x.first_name} Email: #{x.email} Note: #{x.note}"
      end 
    end
  end

  def display_all_of_one_attribute
    puts "\e[H\e[2J"
    second_menu
    display_val = (gets.chomp.to_i)

    case display_val
    when 1
      puts "First names:"
      Rolodex.print_attribute(display_val)

    when 2
      puts "Last names:"
      Rolodex.print_attribute(display_val)

    when 3
      puts "Emails:"
      Rolodex.print_attribute(display_val)

    when 4
      puts "Notes:"
      Rolodex.print_attribute(display_val)

    when 5
      puts "Id numbers:"
      Rolodex.print_attribute(display_val)
    else
      puts "That is not a valid option."
    end
  end

  def call_option(user_selected)
    add_new_contact if user_selected == 1
    modify_existing_contact if user_selected == 2
    delete_a_contact if user_selected == 3
    display_all_contacts if user_selected == 4
    display_an_attribute if user_selected == 5
    display_particular_contact if user_selected == 6
    display_all_of_one_attribute if user_selected == 7
    #exit_program if user_selected == 6

  end

  def confirm_change?
    puts "Are you sure?"
    confirmation = gets.chomp
    if confirmation == "y"|| confirmation == "Y"|| confirmation == "Yes"
      return true
    else 
      return false
    end
  end

  def second_menu
    puts "Enter the type of element you would like to see."
    puts"[1] First Name"
    puts"[2] Last Name"
    puts"[3] Email"
    puts"[4] Note"
    puts "[5] Id number"
  end

end



my_crm = CRM.new("First CRM")
my_rolodex = Rolodex.new

my_crm.main_menu


