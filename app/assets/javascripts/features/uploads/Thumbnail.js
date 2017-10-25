import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router-dom';

export default class Thumbnail extends PureComponent {

  static propTypes = {
    video: PropTypes.object.isRequired,
  };

  render () {
    const { id, title, urls: { thumbnail }, account: { display_name } } = this.props.video;

    return (
      <Link to={`/videos/${id}`} className='thumbnail'>
        <img src={thumbnail} alt='' />
        <strong className='thumbnail__title'>{title}</strong>
        <span className='thumbnail__author'>{display_name}</span>
      </Link>
    );
  }

}
