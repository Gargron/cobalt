import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';

export default class VideoDescription extends PureComponent {

  static propTypes = {
    video: PropTypes.object.isRequired,
  };

  render () {
    const { video } = this.props;

    return (
      <div className='video-description'>
        <h1 className='video-description__title'>{video.title}</h1>
        <div className='video-description__published'>Published on {video.published_at}</div>
        {video.description.length > 0 && <div className='video-description__text'>{video.description}</div>}
      </div>
    );
  }

}
