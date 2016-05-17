# StatesView

StatesView is a small implementation on top of [StatefulViewController](https://github.com/aschuch/StatefulViewController). 

It's a placeholder for any view(Controller) that needs an asynchronous task to complete to get its data. It will start on the loading state and, depending on what you'll tell it, will transition to the loaded state (by displaying the viewController you'll give it), the empty state or the error state.
