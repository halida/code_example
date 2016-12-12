def run
  db = {
    users: [
      {id: 1, name: "James", age: 18},
      {id: 2, name: "Bob", age: 41},
    ],
    contacts: [
      {user_id: 1, address: "Shangrao"},
      {user_id: 1, address: "Beijing"},
      {user_id: 2, address: "Beijing"},
    ],
  }

  # create schema
  create_table(:user, columns: {id: Integer, name: String, age: Integer})

  # insert
  insert(:user, {id: 1, name: "James", age: 18})

  # delete
  table(:users).filter(name.like, "%ames").delete

  # query
  table(:users).filter(name.like, "%ames").select(:age)

  table(:users).join(:contacts, on: users.id == contacts.user_id).
    filter(contacts.address.like "Beijing%").
    select(:age)

  # update
  table(:users).filter(name.like, "%ames").update(age: 12)

  # transaction
  rows = table(:users).filter(name.like, "%ames")
  rows.lock
  rows.unlock

  rows.with_lock do
    max_age = rows.select(:age).max
    rows.update(age: max_age)
  end
end
