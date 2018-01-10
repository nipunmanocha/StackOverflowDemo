def iterate_user_entities (users, entities)
  users.each do |user|
      entities.each do |entity|
          yield(user, entity)
      end
  end
end
