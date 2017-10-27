import React, { PureComponent } from 'react';
import { BrowserRouter as Router } from 'react-router-dom';
import { Provider } from 'react-redux'
import { createStore, applyMiddleware, compose } from 'redux';
import thunk from 'redux-thunk';
import appReducer from './reducers';

import UI from './features/ui';

const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;

const store = createStore(
  appReducer,
  composeEnhancers(applyMiddleware(thunk))
);

export default class App extends PureComponent {

  render () {
    return (
      <Provider store={store}>
        <Router>
          <UI />
        </Router>
      </Provider>
    );
  }

}
