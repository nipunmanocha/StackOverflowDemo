RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods

    config.before(:suite) do
        DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
        DatabaseCleaner.strategy = :transaction
        DatabaseCleaner.start
    end

    config.after(:each) do
        DatabaseCleaner.clean
    end
end
