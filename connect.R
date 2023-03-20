# Load the mongolite package
library(mongolite)

# Connect to MongoDB
conn <- mongo(collection = "details", db = "peason")
print(conn)

# Drop previous data
conn$drop()

# Show collections
print(conn$run('{"listCollections":1}'))

# Server info
print(conn$info())

# Insert 5 records to it
data <- data.frame(
  name = c("Siva", "Prakash", "Akhil", "Melvin", "Aravind"),
  age = c(21, 23, 22, 20, 22)
)
print(conn$insert(data))

# Count Documents
print(conn$count())

# Find the records
print(conn$find('{"age": {"$gte": 22}}'))

print(conn$find('{"age": {"$gt": 22}}'))

print(conn$find('{"age": {"$lt": 22}}'))

print(conn$find('{"age": {"$lte": 22}}'))

print(conn$find('{"age": {"$eq": 22}}'))

print(conn$find('{"age": {"$ne": 22}}'))

print(conn$find('{"name": {"$in": ["Prakash", "Akhil", "Melvin"]}}'))

print(conn$find('{"name": {"$nin": ["Prakash", "Akhil", "Melvin"]}}'))

print(conn$find('{"$and": [{"name": "Prakash"}, {"age": {"$gt": 30}}]}'))

print(conn$find('{"$or": [{"name": "Prakash"}, {"name": "Akhil"}]}'))

print(conn$find('{"name": {"$not": {"$eq": "Prakash"}}}'))

print(conn$find('{"name": {"$exists": true}}'))

print(conn$find('{"age": {"$type": "number"}}'))

# Sort and limit
print(conn$find('{"age": {"$gte": 22}}', sort = '{"age": 1}', limit = 2))

# Update
print(conn$update('{"name": "Akhil"}', '{"$set": {"age": 50}}'))

# Delete
print(conn$remove('{"name": "Prakash"}'))

# Aggregate
print(conn$aggregate('[{"$match": {"age": {"$gte": 22}}}, {"$group": {"_id": null, "count": {"$sum": 1}}}]'))

# MapReduce
print(conn$mapreduce("function() { emit(this.name, this.age); }", "function(key, values) { return Array.avg(values); }"))

# Add index
print(conn$index(add = '{"age" : 1}'))

# Remove index
print(conn$index(remove = "age_1"))

# Export data
print(conn$export(file("data/export.json")))

# Import data
conn$drop()
print(conn$import(file("data/export.json")))

# Quit connection
print(conn$disconnect())
