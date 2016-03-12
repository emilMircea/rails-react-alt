class TodoActions
  constructor: ->
    @generateActions(
      'initData',
      'submitTodo',
      'deleteTodo',
      'updateTodo'
    )

window.TodoActions = alt.createActions(TodoActions)
