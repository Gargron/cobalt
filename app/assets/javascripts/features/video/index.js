import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';
import VideoPlayer from './VideoPlayer';
import axios from 'axios';
import { connect } from 'react-redux';
import { fetchVideo } from '../../actions';

@connect(state => ({ video: state.video }), dispatch => ({ fetchVideo: id => dispatch(fetchVideo(id)) }))
export default class Video extends PureComponent {

  static propTypes = {
    match: PropTypes.object,
    video: PropTypes.object,
    fetchVideo: PropTypes.func.isRequired,
  };

  componentDidMount () {
    const { id } = this.props.match.params;
    const { fetchVideo } = this.props;

    fetchVideo(id);
  }

  componentWillReceiveProps (nextProps) {
    if (this.props.match.params.id !== nextProps.match.params.id) {
      this.props.fetchVideo(nextProps.match.params.id);
    }
  }

  render () {
    const { video } = this.props;

    if (!video.id) {
      return null;
    }

    return (
      <div className='video'>
        <VideoPlayer video={video} />

        <div className='video__about'>
          <h1 className='video__about__title'>{video.title}</h1>
          <div className='video__about__published'>Published on {video.published_at}</div>
          {video.description.length > 0 && <div className='video__about__description'>{video.description}</div>}
        </div>
      </div>
    );
  }

}
