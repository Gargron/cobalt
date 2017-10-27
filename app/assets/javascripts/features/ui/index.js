import React, { Component } from 'react';
import { Route } from 'react-router-dom';

import Uploads from '../uploads';
import Video from '../video';
import Upload from '../upload';

import Header from './Header';
import Navigation from './Navigation';

export default class UI extends Component {

  render () {
    return (
      <div className='ui'>
        <div className='ui__header'>
          <Header />
        </div>

        <div className='ui__layout'>
          <div className='ui__navigation'>
            <Navigation />
          </div>

          <div className='ui__page'>
            <Route path='/uploads' component={Uploads} />
            <Route path='/videos/:id' component={Video} />
            <Route path='/upload' component={Upload} />
          </div>
        </div>
      </div>
    );
  }

}
