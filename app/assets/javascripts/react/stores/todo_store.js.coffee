class TodoStore
  @displayName: 'TodoStore'

  constructor: ->
    @bindActions(TodoActions)
    @todos = []

    @exportPublicMethods(
      {
        getTodos: @getTodos
      }
    )

  onInitData: (props)->
    @todos = props.todos

  onSubmitTodo: (name)->
    $.ajax
      type: 'POST'
      url: '/todos'
      data:
        todo:
          name: name
      success: (response)=>
        @todos.push(response)
        @emitChange()
      error: (response)=>
        console.log('error')
        console.log(response)

    return false

  onDeleteTodo: (todo_id) ->
    #taskIndex = parseInt(todo_id.target.value, 10)
    # logic to take out todo from js array
    console.log @todos[0].id #  find the id of an obj
    @setState (state) =>
      state.todos.splice(0, 1)
      return todos: state.todos
    # Ajax call to delete - works with controller
    $.ajax
      type: 'DELETE'
      url: "/todos/#{todo_id}"
      success: (response)=>
        _.find(@todos, { id: response.id} ) # aici
        @emitChange()
      error: (response)=>
        console.log('error')
        console.log(response)

    return false

  getTodos: ()->
    @getState().todos

window.TodoStore = alt.createStore(TodoStore)
