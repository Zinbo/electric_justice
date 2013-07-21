# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

BlogEntry.create([{entry: 'This is message 1'}, {entry: 'This is message 2'}, {entry: 'This is message 3'}, {entry: 'This is message 4'}, {entry: 'This is message 5'}] )
poll = Poll.create(question: "blah?")
Answer.create(poll_id: poll.id, answer: "yes")
Answer.create(poll_id: poll.id, answer: "no")

poll = Poll.create(question: "Alliance or horde?")
Answer.create(poll_id: poll.id, answer: "Alliance")
Answer.create(poll_id: poll.id, answer: "Horde")

poll = Poll.create(question: "Favourite Class?")
Answer.create(poll_id: poll.id, answer: "Paladin")
Answer.create(poll_id: poll.id, answer: "Warrior")
Answer.create(poll_id: poll.id, answer: "Druid")
Answer.create(poll_id: poll.id, answer: "Mage")
Answer.create(poll_id: poll.id, answer: "Priest")
Answer.create(poll_id: poll.id, answer: "Death Knight")
Answer.create(poll_id: poll.id, answer: "Warlock")
Answer.create(poll_id: poll.id, answer: "Shaman")
Answer.create(poll_id: poll.id, answer: "Hunter")
Answer.create(poll_id: poll.id, answer: "Monk")
Answer.create(poll_id: poll.id, answer: "Rogue")
