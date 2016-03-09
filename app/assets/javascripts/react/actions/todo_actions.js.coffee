class TodoActions
  constructor: ->
    @generateActions(
      'initData',
      'submitTodo',
      'deleteTodo'
    )

window.TodoActions = alt.createActions(TodoActions)
