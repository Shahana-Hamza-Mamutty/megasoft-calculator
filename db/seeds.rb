# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
data = [ 
	{type: "Operation::Add", display_sign: '+', action: '+', position: 1},
	{type: "Operation::Subtract", display_sign: '-', action: '-', position: 2},
	{type: "Operation::Multiply", display_sign: '*', action: '*', position: 3},
	{type: "Operation::Divide", display_sign: '÷', action: '/', position: 4},
	{type: "Operation::Factorial", display_sign: 'x!', action: '!', position: 5},
	{type: "Operation::SquareRoot", display_sign: '√x', action: 'sqrt', position: 6},
	{type: "Operation::CubeRoot", display_sign: '3√x', action: 'cbrt', position: 7},
	{type: "Operation::Power", display_sign: 'x^y', action: '^', position: 8}
]

operators = Operator.create(data)
