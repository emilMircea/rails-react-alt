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

    @setState (state) =>
      $.ajax
        type: 'DELETE'
        url: "/todos/#{todo_id}"
        success: (response)=>
          # aici gaseste todos si scoate by id cu lodash
          _.find(@todos, _.remove( @todos, { id: response.id}) ) # aici
          @emitChange()
        error: (response)=>
          console.log('error')
          console.log(response)

    return false

  getTodos: ()->
    @getState().todos

window.TodoStore = alt.createStore(TodoStore)
