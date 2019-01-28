FactoryBot.define do
  factory :operator do
  	factory :add do
  		type { 'Operation::Add' }
  		action { '+' }
  		display_sign { '+' }
  		position { 1 }
  	end 
  	factory :subtract do
  		type { 'Operation::Subtract' }
  		action { '-' }
  		display_sign { '-' }
  		position { 1 }
  	end 
  	factory :multiply do
  		type { 'Operation::Multiply' }
  		action { '*' }
  		display_sign { '*' }
  		position { 1 }
  	end 
  	factory :divide do
  		type { 'Operation::Divide' }
  		action { '/' }
  		display_sign { '/' }
  		position { 1 }
  	end 
  	factory :square_root do
  		type { 'Operation::SquareRoot' }
  		action { 'sqrt' }
  		display_sign { 'sqrt' }
  		position { 1 }
  	end 
  	factory :cube_root do
  		type { 'Operation::CubeRoot' }
  		action { 'cbrt' }
  		display_sign { 'cbrt' }
  		position { 1 }
  	end 
  	factory :factorial do
  		type { 'Operation::Factorial' }
  		action { '!' }
  		display_sign { '!' }
  		position { 1 }
  	end 
  	factory :power do
  		type { 'Operation::Power' }
  		action { '^' }
  		display_sign { '^' }
  		position { 1 }
  	end 
  end
end
