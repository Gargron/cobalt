import React, { Component } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { Provider } from 'react-redux'
import { createStore, applyMiddleware, compose } from 'redux';
import thunk from 'redux-thunk';
import appReducer from './reducers';

import Uploads from './features/uploads';
import Video from './features/video';
import Upload from './features/upload';

const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;

const store = createStore(
  appReducer,
  composeEnhancers(applyMiddleware(thunk))
);

export default class App extends Component {

  shouldComponentUpdate () {
    return false;
  }

  render () {
    return (
      <Provider store={store}>
        <Router>
          <div>
            <Route exact path='/' component={Uploads} />
            <Route path='/videos/:id' component={Video} />
            <Route path='/upload' component={Upload} />
          </div>
        </Router>
      </Provider>
    );
  }

}
