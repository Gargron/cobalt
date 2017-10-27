import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { fetchUploads } from '../../actions';
import Thumbnail from './Thumbnail';

@connect(state => ({ videos: state.uploads }), dispatch => ({ fetchUploads: () => dispatch(fetchUploads()) }))
export default class Uploads extends PureComponent {

  static propTypes = {
    videos: PropTypes.array.isRequired,
    fetchUploads: PropTypes.func.isRequired,
  };

  componentDidMount () {
    const { fetchUploads } = this.props;
    fetchUploads();
  }

  render () {
    const { videos } = this.props;

    return (
      <div className='uploads'>
        <div className='uploads__header'>
          My channel
        </div>

        <div className='uploads__grid'>
          {videos.map(video => <Thumbnail key={video.id} video={video} />)}
        </div>
      </div>
    );
  }

}
