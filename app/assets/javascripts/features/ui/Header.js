import React, { PureComponent } from 'react';
import { Link } from 'react-router-dom';

export default class Header extends PureComponent {

  render () {
    return (
      <div className='header'>
        <div className='header__brand'>
          Cobalt
        </div>

        <div className='header__search' />

        <div className='header__profile'>
          <Link to='/upload'><i className='ion-plus' /> Upload</Link>
        </div>
      </div>
    );
  }

}
