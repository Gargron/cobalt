import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';

@connect(state => ({ uploaded: state.upload.uploaded }))
export default class UploadPreview extends PureComponent {

  static propTypes = {
    uploaded: PropTypes.object.isRequired,
  };

  render () {
    const { id, published } = this.props.uploaded;

    return (
      <div className='upload-preview'>
        Upload successful! {published ? <span>Published! Congrats! <Link to={`/videos/${id}`}>View the video</Link></span> : 'Just press publish when you are ready'}
      </div>
    );
  }

}
