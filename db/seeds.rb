# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@alexendria = Library.create!(name: 'Alexendria', public_library: false, employees: 1)
@potter = @alexendria.books.create!(name: "Harry Potter and The Sorcer's Stone", checked_out: true, pages: 224)
@potter = @alexendria.books.create!(name: "Harry Potter and The Chamber of Secrets", checked_out: false, pages: 357)