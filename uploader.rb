require 'csv'

# paths to images and addesses datasets
addresses_path = "/Users/ritwickmalhotra/Desktop/address_dataset.csv"
images_path = "/Users/ritwickmalhotra/Desktop/Houses-dataset/houses_dataset/"

def destroy_all
  Apartment.all.each { |apt| apt.really_destroy! }
end

def create_property
end

def populate_random addresses_path, images_path
  addresses = CSV.read(addresses_path, headers: true)

  image_names = Dir.entries(images_path)
  bathroom = []
  frontal = []
  kitchen = []
  bedroom = []

  image_names.each do |img|
    bathroom.push(img) if img.include?("bathroom")
    frontal.push(img) if img.include?("frontal")
    kitchen.push(img) if img.include?("kitchen")
    bedroom.push(img) if img.include?("bedroom")
  end
  apartments_count = (0..image_names.size).to_a

  apartments_count.each_with_index do |_, idx|
    price = rand(500..5000)

    apt = Apartment.create!(
      rate_weekly_subunit: price,
      rate_monthly_subunit: price * 30,
      description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
  quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
  consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
  cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
  proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      bedrooms_count: rand(1..5),
      bathrooms_count: rand(1..5),
      people_count: rand(1..5),
      area: rand(20..100),
      construction_year: rand(1999..2021),
      floor: rand(1..5),
      value_of_property: price * 50,
      value_of_mobility: price * 2,
      phone: addresses[idx]["phone1"],
    )

    location = Location.create!(
      street: addresses[idx]["address"],
      house_number: rand(0..200),
      city: addresses[idx]["city"],
      country: "GB",
      province: addresses[idx]["province"],
      location_type: "multiline_address"
    )
    apt.update!(location: location)

    apt.images.attach(
      io: File.open(images_path + bathroom[idx]),
      filename: bathroom[idx],
      content_type: 'image/jpeg',
      identify: false
    )

    apt.images.attach(
      io: File.open(images_path + frontal[idx]),
      filename: bathroom[idx],
      content_type: 'image/jpeg',
      identify: false
    )

    apt.images.attach(
      io: File.open(images_path + kitchen[idx]),
      filename: bathroom[idx],
      content_type: 'image/jpeg',
      identify: false
    )

    apt.images.attach(
      io: File.open(images_path + bedroom[idx]),
      filename: bathroom[idx],
      content_type: 'image/jpeg',
      identify: false
    )
  end
end
