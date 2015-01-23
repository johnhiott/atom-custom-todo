AtomCustomTodoView = require './atom-custom-todo-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomCustomTodo =
  atomCustomTodoView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomCustomTodoView = new AtomCustomTodoView(state.atomCustomTodoViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomCustomTodoView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-custom-todo:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomCustomTodoView.destroy()

  serialize: ->
    atomCustomTodoViewState: @atomCustomTodoView.serialize()

  toggle: ->
    console.log 'AtomCustomTodo was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
