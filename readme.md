# Larz's Schoolwork Assignment API

## Basic API Documentation


### see all assignments
####/api/assignments
returns all of the assignments(including their attributes) in JSON format

### see all assignments a collaborator worked on
####/api/assignments/:id
#####:id is the collaborator's id - INTEGER
returns all assignments(including their attributes) that the collaborator worked on in JSON format


### see all collaborators
####/api/collaborators
returns all collaborators(and their attributes) in JSON format

### get all assignments a collaborator has worked on
#### /api/collaborators/:id
##### :id is the collaborator's id - INTEGER
returns all of the assignments(and their attributes) the given collaborator has worked on in JSON format

### delete an assignment
####/api/assignments/delete/:id
##### :id is the assignment's id - INTEGER
deletes an assignment from the assignments table and all rows from the collaborations tables associated with that assignment

returns the assignment that was deleted in JSON format

### add a collaborator
####/api/collaborators/add/:name
##### :name is the collaborator's name - STRING(?)
returns the new collaborator in JSON format

### delete a collaborator
####/api/collaborators/delete/:id
##### :id is the collaborator's id - INTEGER
returns the deleted collaborator in JSON format

### add collaborator to existing assignment
####/api/assignments/add_collaborator/:assignment_id/:collaborator_id
##### :assignment_id is the assignment's id - INTEGER
##### :collaborator_id is the collaborator's id - INTEGER
Returns the assignment(JSON format) if successful or a message if unsuccessful

### remove a collaborator from an existing assignment
####/api/assignments/remove_collaborator/:assignment_id/:collaborator_id
##### :assignment_id is the assignment's id - INTEGER
##### :collaborator_id is the collaborator's id - INTEGER
Returns the assignment(JSON format) if successful or a message if unsuccessful