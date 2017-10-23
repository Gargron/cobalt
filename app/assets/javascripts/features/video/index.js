import React, { Component } from 'react';
import VideoPlayer from './VideoPlayer';
import axios from 'axios';

export default class Video extends Component {

  state = {
    video: null,
  };

  componentDidMount () {
    const { id } = this.props.match.params;

    axios.get(`/api/videos/${id}`).then(res => this.setState({ video: res.data }));
  }

  render () {
    const { video } = this.state;

    if (!video) {
      return null;
    }

    return (
      <div className='video'>
        <h1>{video.title}</h1>

        <VideoPlayer video={video} />
      </div>
    );
  }

}
