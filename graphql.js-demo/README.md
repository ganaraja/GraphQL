# GraphQL.js Todo App Example

This is a ToDo app example that uses [**GraphQL.js**](https://github.com/f/graphql.js), [**Sinatra**](https://sinatrarb.com) and [**GraphQL-Ruby**](https://github.com/rmosolgo/graphql-ruby).

## Samples

This implementation includes following features:

- Queries
- Mutations
- Subscriptions (Live via EventSource)

![Gif](./demo.gif)

## Installation

```bash
git clone https://github.com/f/graphql.js-demo
cd graphql.js-demo

bundle install
ruby app.rb

# Your server will be started on http://localhost:4567
```

## The Focus

The main focus here to create GraphQL JavaScript clients easily. Please read the following code to see how easy to query a GraphQL server.

```js
var graph = graphql("/graphql", {
  alwaysAutodeclare: true,
  fragments: {
    todo: `on Todo {
      id
      text
      isCompleted
    }`
  }
})

function getTodos() {
  return graph.query.run(`allTodos { ...todo }`)
}

function addTodo(text) {
  return graph.mutate(`todoAdd(text: $text) { ...todo }`)({
    text: text
  })
}

function setTodo(id, isCompleted) {
  return graph.mutate(`todoComplete(id: $id, status: $isCompleted) { ...todo }`)({
    "id!ID": id,
    isCompleted: isCompleted
  })
}

function removeTodo(id) {
  return graph.mutate(`todoRemove(id: $id) { ...todo }`)({
    "id!ID": id
  })
}
```

### Subscriptions

This includes `EventSource` model of subscriptions.

```js
var source = new EventSource(`/graphql?query=
  subscription ($id: ID!) {
    todoAdded(id: $id) {
      id
      text
    }
    todoUpdated(id: $id) {
      id
      isCompleted
    }
    todoRemoved(id: $id) {
      id
    }
  }`)
source.addEventListener('graphql.todoAdded', function (message) {
  var data = JSON.parse(message.data)
  var todo = data.data.todoAdded
  todos.innerHTML += "<li id='" + todo.id + "'>" + todo.text + "</li>"
})
source.addEventListener('graphql.todoRemoved', function (message) {
  var data = JSON.parse(message.data)
  var todo = data.data.todoRemoved
  var el = document.querySelector("li#" + todo.id)
  todos.removeChild(el)
})
source.addEventListener('graphql.todoUpdated', function (message) {
  var data = JSON.parse(message.data)
  var todo = data.data.todoUpdated
  var el = document.querySelector("li#" + todo.id)
  el.className = "completed"
})
```
