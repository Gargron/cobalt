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

  render () {
    const { video } = this.props;

    if (!video.id) {
      return null;
    }

    return (
      <div className='video'>
        <VideoPlayer video={video} />

        <h1>{video.title}</h1>
        {video.account.display_name}
      </div>
    );
  }

}
