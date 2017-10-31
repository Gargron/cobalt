import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';
import VideoPlayer from './VideoPlayer';
import { connect } from 'react-redux';
import { fetchVideo } from '../../actions';
import VideoAuthor from './VideoAuthor';
import VideoDescription from './VideoDescription';

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
          <VideoDescription video={video} />
          <VideoAuthor account={video.account} />
        </div>
      </div>
    );
  }

}
