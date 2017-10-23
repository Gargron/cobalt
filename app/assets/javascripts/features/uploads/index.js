import React, { Component } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';

export default class Uploads extends Component {

  state = {
    videos: [],
  };

  componentDidMount () {
    axios.get('/api/videos').then(res => this.setState({ videos: res.data }));
  }

  render () {
    const { videos } = this.state;

    return (
      <div>
        {videos.map(video => <Link key={video.id} to={`/videos/${video.id}`}>{video.title}</Link>)}
      </div>
    );
  }

}
