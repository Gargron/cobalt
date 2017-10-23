import React, { Component } from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import Uploads from './features/uploads';
import Video from './features/video';

export default class App extends Component {

  render () {
    return (
      <Router>
        <div>
          <Route exact path='/' component={Uploads} />
          <Route path='/videos/:id' component={Video} />
        </div>
      </Router>
    );
  }

}
