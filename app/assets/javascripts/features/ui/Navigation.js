import React, { Component } from 'react';
import { NavLink } from 'react-router-dom';

export default class Navigation extends Component {

  render () {
    return (
      <div className='navigation'>
        <div className='navigation__section'>
          <ul className='navigation__section__items'>
            <li><NavLink exact activeClassName='active' to='/'>Home</NavLink></li>
            <li><NavLink exact activeClassName='active' to='/uploads'>My channel</NavLink></li>
            <li><NavLink exact activeClassName='active' to='/subscriptions'>Subscriptions</NavLink></li>
          </ul>
        </div>

        <div className='navigation__section'>
          <h4 className='navigation__section__header'>Library</h4>

          <ul className='navigation__section__items'>
            <li><NavLink exact activeClassName='active' to='/history'>History</NavLink></li>
            <li><NavLink exact activeClassName='active' to='/favourites'>Favourites</NavLink></li>
          </ul>
        </div>

        <div className='navigation__section'>
          <h4 className='navigation__section__header'>Subscriptions</h4>

          <ul className='navigation__section__items'>
            <li><NavLink exact activeClassName='active' to='/channel/test'>Test</NavLink></li>
          </ul>
        </div>
      </div>
    );
  }

}
