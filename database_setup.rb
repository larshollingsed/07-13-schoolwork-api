DB = SQLite3::Database.new("schoolwork.db")

DB.execute("CREATE TABLE IF NOT EXISTS assignments (id INTEGER PRIMARY KEY, assignment_name TEXT, description TEXT, repository TEXT, link TEXT);")

DB.execute("CREATE TABLE IF NOT EXISTS collaborators (id INTEGER PRIMARY KEY, collaborator_name TEXT);")

DB.execute("CREATE TABLE IF NOT EXISTS collaborations (assignment_id INTEGER, collaborator_id INTEGER);")

DB.results_as_hash = true