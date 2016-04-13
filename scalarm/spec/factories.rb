FactoryGirl.define do
  factory :result, class: Scalarm::Parser::Result do
    processors   '7'
    problem_size '1200'
    scaled       'true'
    time         '0.2132'

    initialize_with { new(processors: processors, problem_size: problem_size, scaled: scaled, time: time) }
  end
end
