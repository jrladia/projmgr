# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
p1 = Project.create(projnumber: 123, projname: "Name of Project 1 ", location: "Anywhere, USA", client: "Client Name", scope: "renovation", status: 33, stage: "BCA")
p2 = Project.create(projnumber: 126, projname: "Name of Project 2", location: "Anywhere, USA", client: "Client Name", scope: "renovation", status: 34, stage: "BCA")
p3 = Project.create(projnumber: 323, projname: "Name of Project 3", location: "Anywhere, USA", client: "Client Name", scope: "renovation", status: 35, stage: "BCA")