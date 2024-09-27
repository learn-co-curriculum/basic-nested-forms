class Person < ActiveRecord::Base
  has_many :addresses
  accepts_nested_attributes_for :addresses

  def index
    @people = Person.all
  end

  def new
    @person = Person.new
    @person.addresses.build(address_type: 'work')
    @person.addresses.build(address_type: 'home')
  end

  def create
    person = Person.create(person_params)
    redirect_to people_path
  end

  private

  def person_params
    params.require(:person).permit(
      :name,
      addresses_attributes: [
        :street_address_1,
        :street_address_2, 
        :city,
        :state,
        :zipcode,
        :address_type
      ]
    )
    end
  end
end
