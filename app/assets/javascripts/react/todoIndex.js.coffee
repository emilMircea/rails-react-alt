{ div, h1, ul, li, a, span, label, input } = React.DOM

# THE FORM
TodoForm = React.createFactory React.createClass
  getInitialState: ->
    todoName: ""
  onInputChange: (e) ->
    @setState(todoName: e.target.value)
  onInputKeyDown: (e) ->
    if e.keyCode == 13 && this.refs.todo.value.length
      TodoActions.submitTodo(this.refs.todo.value)
      @setState(todoName: "")
  onDeleteTodo: ->
    console.log 'tried to delete'
  render: ->
    div className: 'form-group',
      label {}, 'Enter Todo'
      input
        onChange: @onInputChange,
        onKeyDown: @onInputKeyDown,
        ref: 'todo',
        className: 'form-control',
        placeholder: 'Enter todo name'
        value: @state.todoName

# THE LIST ITEM
TodoListItem = React.createFactory React.createClass
  onDeleteTodo: ->
    TodoActions.deleteTodo(@props.todo.id) # aici
  render: ->
    todoListClasses = 'list-item'
    li className: todoListClasses,
      a onClick: @onDeleteTodo, className: 'btn btn-primary', 'Delete' # aici
      span className: 'list-text', @props.todo.name

# THE LIST
TodoList = React.createFactory React.createClass
  render: ->
    ul className: 'list-unstyled',
      _.map @props.todos, (todo)=>
        TodoListItem(key: "todo-#{todo.id}", todo: todo)

  window.TodoIndex = React.createClass
    getInitialState: ->
      todos: []
    componentWillMount: ->
      TodoStore.listen(@onChange)
      TodoActions.initData(@props)
    componentWillUnmount: ->
      TodoStore.unlisten(@onChange)
    onChange: (state) ->
      @setState(state)
    render: ->
      div className: 'container',
        div className: 'row',
          div className: 'col-xs-12',
            h1 {}, 'Todo List'
            TodoForm()
            TodoList(todos: @state.todos, deleteTask: @deleteTask)
